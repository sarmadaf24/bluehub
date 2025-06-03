# 📁 vpn_bot/bot/handlers/payment/select.py

from aiogram import Router, F
from aiogram.types import CallbackQuery, InlineKeyboardMarkup, InlineKeyboardButton
from aiogram.fsm.context import FSMContext

from vpn_bot.context.lang_context import current_lang
from vpn_bot.utils.i18n import t
from vpn_bot.bot.handlers.payment.card import start_card_payment  # ← همین

router = Router()
print("📦 select.py router loaded ✅")

@router.callback_query(F.data.startswith("payment:"))
async def handle_payment_selection(call: CallbackQuery, state: FSMContext):
    lang = current_lang.get()
    payment_type = call.data.split(":", 1)[1]

    if payment_type == "zarinpal":
        await call.message.edit_text(
            t("payment_zarinpal_redirect", lang),
            reply_markup=InlineKeyboardMarkup(
                inline_keyboard=[[InlineKeyboardButton(
                    text=t("verify_now", lang),
                    callback_data="start:zarinpal"
                )]]
            )
        )

    elif payment_type == "paypal":
        await call.message.edit_text(t("paypal_not_ready", lang))

    elif payment_type == "crypto":
        await call.message.edit_text(
            t("payment_crypto_redirect", lang),
            reply_markup=InlineKeyboardMarkup(
                inline_keyboard=[[InlineKeyboardButton(
                    text=t("send_payment_code", lang),
                    callback_data="start:crypto"
                )]]
            )
        )

    elif payment_type == "card":
        await start_card_payment(call, state)

    else:
        await call.message.edit_text("❌ نوع پرداخت نامشخص است.")

    await call.answer()

@router.callback_query(F.data.startswith("payment:"))
async def handle_payment_selection(call: CallbackQuery, state: FSMContext):
    payment_type = call.data.split(":", 1)[1]
    if payment_type == "card":
        # کافیست تابع ورودی را فراخوانی کنیم
        await start_card_payment(call, state)
    else:
        # … بقیهٔ روش‌های پرداخت …
        pass
    await call.answer()


from vpn_bot.bot.handlers.payment.crypto_providers import show_crypto_providers

@router.callback_query(F.data == "payment:crypto")
async def start_crypto_payment(call: CallbackQuery, state: FSMContext):
    await show_crypto_providers(call, state)

