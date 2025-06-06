# 📁 /root/bluehub/vpn_bot/bot/handlers/payment/crypto.py

import time
import uuid
import datetime
import logging
from io import BytesIO

from aiogram import Router, F
from aiogram.types import (
    Message,
    CallbackQuery,
    InlineKeyboardMarkup,
    InlineKeyboardButton,
    BufferedInputFile
)
from aiogram.fsm.state import StatesGroup, State
from aiogram.fsm.context import FSMContext
from vpn_bot.utils.qr import generate_qr_base64, get_qr_image_bytes
from vpn_bot.constants.crypto_coins import SUPPORTED_COINS
from vpn_bot.constants.crypto_addresses import CRYPTO_ADDRESSES
from vpn_bot.utils.i18n import t
from vpn_bot.context.lang_context import current_lang
from vpn_bot.services.payment.nowpayments import create_invoice, check_payment_status
from vpn_bot.bot.handlers.user.buy.states import CryptoPaymentStates
from vpn_bot.bot.handlers.user.buy.plans import show_plan_list
from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.transaction import Transaction
from vpn_bot.db.models import Config
from vpn_bot.services.server_service import increment_server_clients
from vpn_bot.constants.crypto_coins import SUPPORTED_COINS
from vpn_bot.bot.handlers.user.buy.states import CryptoPaymentStates

router = Router()

class PaymentStates(StatesGroup):
    waiting_txid = State()

class CryptoPaymentStates(StatesGroup):
    select_provider       = State()
    select_coin           = State()
    waiting_for_txid      = State()
    waiting_for_payment_code = State()   # ← اضافه کنید
    waiting_for_payment   = State()

# اگر مبلغ پلن کمتر از این باشد، مسیر دستی (آفلاین) فعال می‌شود
MINIMUM_CRYPTO_PAYMENT = 5.0

async def _filter_nowpayments_provider(call: CallbackQuery, state: FSMContext) -> bool:
    data = await state.get_data()
    return data.get("selected_provider") == "nowpayments"

@router.callback_query(
    CryptoPaymentStates.select_coin,
    F.data.startswith("crypto_coin:"),
    _filter_nowpayments_provider
)
@router.callback_query(F.data.startswith("crypto:provider:"))
async def show_crypto_coins(call: CallbackQuery, state: FSMContext):
    lang = current_lang.get()
    buttons = []
    for i in range(0, len(SUPPORTED_COINS), 2):
        row = []
        for coin in SUPPORTED_COINS[i : i + 2]:
            sym = coin["symbol"]
            emoji = coin.get("emoji", "🪙")
            row.append(
                InlineKeyboardButton(
                    text=f"{emoji} {sym}",
                    callback_data=f"crypto_coin:{sym.lower()}"
                )
            )
        buttons.append(row)

    # یک‌بار دکمه برگشت
    buttons.append([
        InlineKeyboardButton(
            text=f"◀️ {t('back', lang)}",
            callback_data="payment:crypto"
        )
    ])

    await call.message.edit_text(
        t("choose_crypto", lang),
        reply_markup=InlineKeyboardMarkup(inline_keyboard=buttons)
    )
    await state.set_state(CryptoPaymentStates.choosing_coin)
    await call.answer()

# 1) مسیر اصلی انتخاب کوین و پرداخت
@router.callback_query(F.data.startswith("crypto_coin:"))
async def handle_crypto_coin(callback: CallbackQuery, state: FSMContext):
    lang = current_lang.get()
    coin = callback.data.split(":", 1)[1].lower()
    data = await state.get_data()
    amount_usd = float(data.get("amount_usd", 0))
    await state.update_data(selected_coin=coin)

    # 🔶 Offline/manual: آفلاین – نشان دادن QR + متن + دکمه‌ها در یک پیام
    if coin in ("usdt", "bnb") or amount_usd < MINIMUM_CRYPTO_PAYMENT:
        address = CRYPTO_ADDRESSES.get(coin, "❌")
        caption = (
            f"<b>✅ {t('crypto_payment_created', lang)} {coin.upper()}</b>\n\n"
            f"💸 <b>{t('send_to_address', lang)}:</b>\n"
            f"<code>{address}</code>\n\n"
            f"{t('money_back_guarantee', lang)}\n\n"
            f"{t('enter_txid_prompt', lang)}"
        )
        kb = InlineKeyboardMarkup(inline_keyboard=[
            [InlineKeyboardButton(text=t("enter_txid_button", lang), callback_data="enter_txid")],
            [InlineKeyboardButton(text=t("back_to_plans", lang),  callback_data="go:plans")],
        ])

        qr_b64  = generate_qr_base64(address)
        qr_file = get_qr_image_bytes(qr_b64)

        # ارسال یک پیام Photo با QR و کپشن و InlineKeyboard
        await callback.message.answer_photo(
            photo=qr_file,
            caption=caption,
            parse_mode="HTML",
            reply_markup=kb
        )
        await callback.answer()
        await state.set_state(CryptoPaymentStates.waiting_for_txid)

        return

    # 🔷 Online/invoice via NowPayments
    await callback.message.edit_text(t("loading", lang))
    await callback.answer()
    invoice = await create_invoice(
        price_amount   = amount_usd,
        price_currency = "usd",
        pay_currency   = coin.upper(),
        order_id       = f"{callback.from_user.id}_{coin}",
        description    = f"💸 {t('buy_subscription_with', lang)} {coin.upper()}"
    )
    link = invoice.get("invoice_url") if invoice else None

    if not link:
        await callback.message.edit_text("❌ " + t("payment_failed", lang))
        await callback.answer()
        return

    text = t("invoice_link_text", lang).format(link=link)
    kb = InlineKeyboardMarkup(inline_keyboard=[
        [InlineKeyboardButton(text=t("open_invoice", lang), url=link)],
        [InlineKeyboardButton(text=t("back", lang), callback_data="go:payment_menu")],
    ])
    await callback.message.edit_text(text, disable_web_page_preview=False, reply_markup=kb)
    await callback.answer()
    await state.set_state(CryptoPaymentStates.waiting_for_payment_code)


@router.callback_query(F.data == "enter_txid")
async def ask_for_txid(callback: CallbackQuery, state: FSMContext):
    lang = current_lang.get()
    # ویرایش یا ارسال پیام جدید برای درخواست TXID
    await callback.message.answer(t("enter_txid_prompt", lang))
    await state.set_state(CryptoPaymentStates.waiting_for_txid)
    await callback.answer()

@router.message(CryptoPaymentStates.waiting_for_txid)
async def receive_txid(msg: Message, state: FSMContext):
    txid = msg.text.strip()
    ok = await payments.check_txid(txid)
    lang = current_lang.get()
    if not ok:
        return await msg.reply(t("invalid_txid", lang))  # یک کلید جدید در langs تعریف کنید
    await msg.reply(t("txid_accepted", lang))
    await state.clear()
    # ادامه پردازش تراکنش...



# 4) handler دکمه‌ی «بازگشت به پلن‌ها»
@router.callback_query(F.data == "go:plans")
async def back_to_plans(callback: CallbackQuery, state: FSMContext):
    # ۱. حذف پیام حاوی QR
    await callback.message.delete()
    # ۲. نمایش لیست پلن‌ها به‌صورت پیام جدید
    await show_plan_list(callback, state)
    await callback.answer()

@router.message(CryptoPaymentStates.waiting_for_payment_code)
async def verify_crypto_payment(message: Message, state: FSMContext):
    lang = current_lang.get()
    payment_id = message.text.strip()
    await message.reply(t("checking_payment", lang))
    status = await check_payment_status(payment_id)
    logging.info(f"[Crypto] Status for {payment_id}: {status}")

    if status == "finished":
        data = await state.get_data()
        plan_id     = data.get("plan_id")
        amount_usd  = float(data.get("amount_usd", 0))
        v2ray_type  = data.get("v2ray_type", "vless")
        config      = Config(
            user_id         = message.from_user.id,
            config_name     = f"Crypto-{int(time.time())}",
            protocol        = v2ray_type,
            server          = "vpn.example.com",
            port            = 443,
            uuid            = str(uuid.uuid4()),
            expiration_date = (datetime.datetime.utcnow() +
                               datetime.timedelta(days=30)
                              ).strftime("%Y-%m-%d"),
            active          = 1
        )
        async with AsyncSessionLocal() as session:
            session.add(Transaction(
                user_id   = message.from_user.id,
                plan_id   = int(plan_id) if plan_id else None,
                amount    = amount_usd,
                currency  = "USD",
                gateway   = "nowpayments",
                status    = "paid",
                reference = payment_id,
                type      = "buy"
            ))
            session.add(config)
            await session.commit()

        await message.answer(t("config_ready", lang))
        await increment_server_clients(config.server)

    elif status == "waiting":
        await message.answer("⏳ " + t("payment_still_waiting", lang))
    elif status == "confirming":
        await message.answer("🔄 " + t("payment_confirming", lang))
    elif status == "expired":
        await message.answer("⛔ " + t("payment_expired", lang))
    elif status == "failed":
        await message.answer("❌ " + t("payment_failed", lang))
    else:
        await message.answer("❗ " + t("unknown_error", lang))

    await state.clear()


@router.callback_query(F.data == "go:payment_menu")
async def back_to_payment_menu(call: CallbackQuery, state: FSMContext):
    lang = current_lang.get()
    text = t("payment_menu", lang)
    keyboard = InlineKeyboardMarkup(inline_keyboard=[
        [InlineKeyboardButton(text="💳 زرین‌پال",    callback_data="payment:zarinpal")],
        [InlineKeyboardButton(text="💸 پی‌پال",       callback_data="payment:paypal")],
        [InlineKeyboardButton(text="💰 رمزارز",      callback_data="payment:crypto")],
        [InlineKeyboardButton(text="💳 کارت به کارت", callback_data="payment:card")],
        [InlineKeyboardButton(text="🔙 بازگشت",      callback_data="go:main_menu")],
    ])
    await call.message.edit_text(text, reply_markup=keyboard)
    await call.answer()

