# 📁 vpn_bot/bot/handlers/payment/zarinpal.py

import aiohttp
import time
import uuid
import datetime

from aiogram import Router, F
from aiogram.types import Message, CallbackQuery
from aiogram.fsm.context import FSMContext
from aiogram.fsm.state import StatesGroup, State

from config import ZARINPAL_MERCHANT_ID
from vpn_bot.utils.i18n import t
from vpn_bot.context.lang_context import current_lang
from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.transaction import Transaction
from vpn_bot.db.models import Config

router = Router()
print("📦 zarinpal.py router loaded ✅")

class ZarinpalStates(StatesGroup):
    waiting_for_authority = State()

# 🔘 شروع پرداخت زرین‌پال


@router.callback_query(F.data == "payment:zarinpal")
async def start_zarinpal_payment(call: CallbackQuery, state: FSMContext):
    lang = current_lang.get()
    user_id = call.from_user.id

    amount = 100_000  # مبلغ تستی
    callback_url = "https://zarinpal.com/pg/services/WebGate/Callback"

    request_data = {
        "merchant_id": ZARINPAL_MERCHANT_ID,
        "amount": amount,
        "callback_url": callback_url,
        "description": t("payment_description", lang),
    }

    await call.message.edit_text(t("generating_payment_link", lang))

    async with aiohttp.ClientSession() as http_session:
        async with http_session.post("https://api.zarinpal.com/pg/v4/payment/request.json", json=request_data) as resp:
            result = await resp.json()

    authority = result.get("data", {}).get("authority")

    if authority:
        pay_url = f"https://www.zarinpal.com/pg/StartPay/{authority}"
        await state.set_state(ZarinpalStates.waiting_for_authority)

        await call.message.edit_text(
            t("zarinpal_payment_link", lang).format(url=pay_url),
            parse_mode="Markdown"
        )
    else:
        error_msg = result.get("errors", {}).get(
            "message", t("payment_failed", lang))
        await call.message.edit_text(f"❌ {error_msg}")

    await call.answer()

# 🔘 دریافت authority و بررسی پرداخت


@router.message(ZarinpalStates.waiting_for_authority)
async def process_zarinpal_authority(message: Message, state: FSMContext):
    authority = message.text.strip()
    user_id = message.from_user.id
    lang = current_lang.get()

    verify_data = {
        "merchant_id": ZARINPAL_MERCHANT_ID,
        "amount": 100_000,
        "authority": authority
    }

    verify_url = "https://api.zarinpal.com/pg/v4/payment/verify.json"

    await message.reply(t("checking_payment", lang))

    async with aiohttp.ClientSession() as http_session:
        async with http_session.post(verify_url, json=verify_data) as resp:
            json_data = await resp.json()

    if json_data.get("data", {}).get("code") == 100:
        ref_id = json_data["data"]["ref_id"]

        async with AsyncSessionLocal() as session:
            session.add(Transaction(
                user_id=user_id,
                plan_id=None,
                amount=100000,
                currency="IRT",
                gateway="zarinpal",
                status="paid",
                reference=ref_id,
                type="buy"
            ))

            session.add(Config(
                user_id=user_id,
                config_name=f"Zarinpal-{int(time.time())}",
                protocol="vless",
                server="vpn.example.com",
                port=443,
                uuid=str(uuid.uuid4()),
                expiration_date=(datetime.datetime.utcnow(
                ) + datetime.timedelta(days=30)).strftime("%Y-%m-%d"),
                active=1
            ))

            await session.commit()

        await message.reply(t("payment_success", lang).format(ref_id=ref_id), parse_mode="Markdown")
        await message.reply(t("config_ready", lang))

    else:
        error_msg = json_data.get("errors", {}).get(
            "message", t("payment_failed", lang))
        await message.reply(f"❌ {error_msg}")

    await state.clear()
