# File: vpn_bot/bot/handlers/payment/card.py

import io
import logging
from uuid import uuid4
from urllib.parse import urlparse

from aiogram import F, Router
from aiogram.types import (
    CallbackQuery, BufferedInputFile,
    InlineKeyboardMarkup, InlineKeyboardButton,
    Message
)
from aiogram.fsm.context import FSMContext
from aiogram.fsm.state import State, StatesGroup
from aiogram.exceptions import TelegramBadRequest
from config import (
    CARD_NUMBER, CARD_HOLDER, CARD_BANK_NAME,
    ADMIN_IDS, XUI_PANEL_HOST, XUI_USERNAME, XUI_PASSWORD
)
from vpn_bot.services.panel_service import (
    PanelService, get_inbound_by_protocol, get_plan_by_id
)
from vpn_bot.services.server_service import get_best_server
from vpn_bot.services.config_builder import save_config_for_user
from vpn_bot.services.connection_service import send_config_to_user
from vpn_bot.utils.i18n import t
from vpn_bot.services.panel_service import PanelService
from vpn_bot.services.panel_service import PanelService, get_inbound_by_protocol, get_plan_by_id
from aiogram.exceptions import TelegramBadRequest
from vpn_bot.bot.handlers.user.buy.states import CardPaymentStates

logger = logging.getLogger("card-handler")

router = Router()
print("📦 card.py router loaded ✅")

class CardPaymentStates(StatesGroup):
    waiting_for_receipt = State()


@router.callback_query(F.data == "payment:card")
async def start_card_payment(callback: CallbackQuery, state: FSMContext):
    """شروع جریان پرداخت کارت‌به‌کارت"""
    data = await state.get_data()
    lang = data.get("lang", "fa")
    plan_id = data.get("plan_id", "؟")

    # گروه‌بندی هر 4 رقم و آماده‌سازی لینک کپی
    formatted = " ".join([CARD_NUMBER[i:i+4] for i in range(0, len(CARD_NUMBER), 4)])
    copy_link = f"tg://copy?text={CARD_NUMBER}"

    # قالب متن با i18n
    text = (
        f"<b>{t('money_back_guarantee', lang)}</b>\n\n"
        f"<b>{t('try_before_buy', lang)}</b>\n\n"
        f"📦 <b>{t('selected_plan', lang)}:</b> {plan_id}\n\n"
        f"{t('card_payment_instructions', lang)}\n\n"
        f"💳 <a href=\"{copy_link}\">{formatted}</a>\n\n"
        f"<i>{t('tap_to_copy_card', lang)}</i>"
    )

    keyboard = InlineKeyboardMarkup(inline_keyboard=[
        [InlineKeyboardButton(text=t("send_receipt", lang), callback_data="upload_receipt")],
        [InlineKeyboardButton(text=t("back_to_plans", lang), callback_data="go:plans")]
    ])

    await callback.message.edit_text(text, reply_markup=keyboard, parse_mode="HTML")
    await state.set_state(CardPaymentStates.waiting_for_receipt)
    await callback.answer()


@router.callback_query(F.data == "upload_receipt")
async def ask_for_receipt(callback: CallbackQuery, state: FSMContext):
    """کاربر را برای ارسال عکس یا اسکرین‌شات رسید فرا می‌خواند."""
    lang = (await state.get_data()).get("lang", "fa")
    await callback.message.answer(
        t("please_send_receipt_image", lang),
        parse_mode="HTML"
    )
    await state.set_state(CardPaymentStates.waiting_for_receipt)
    await callback.answer()

from datetime import datetime, timedelta

@router.message(CardPaymentStates.waiting_for_receipt)
async def receive_receipt(message: Message, state: FSMContext):
    """دریافت رسید از کاربر و ارسال به ادمین‌ها."""
    lang = (await state.get_data()).get("lang", "fa")
    user_id = message.from_user.id

    if message.photo:
        file_id = message.photo[-1].file_id
    elif message.document:
        file_id = message.document.file_id
    else:
        return await message.answer(t("only_image_allowed", lang))

    data = await state.get_data()
    plan_id = data.get("plan_id", 0)
    v2ray_type = data.get("v2ray_type", "vless")

    await message.answer(t("receipt_submitted", lang), parse_mode="HTML")
    await state.clear()

    caption = (
        f"🧾 <b>{t('new_receipt', lang)}</b>\n"
        f"👤 <b>{t('user', lang)}:</b> {user_id}\n"
        f"📦 <b>{t('selected_plan', lang)}:</b> {plan_id}\n"
        f"📡 <b>{t('selected_protocol', lang)}:</b> {v2ray_type.upper()}"
    )
    admin_kb = InlineKeyboardMarkup(
        inline_keyboard=[[
            InlineKeyboardButton(
                text="✅",
                callback_data=f"confirm_receipt:{user_id}:{plan_id}:{v2ray_type}:0"
            ),
            InlineKeyboardButton(
                text="❌",
                callback_data=f"reject_receipt:{user_id}"
            )
        ]]
    )
    for admin_id in ADMIN_IDS:
        await message.bot.send_photo(
            chat_id=admin_id,
            photo=file_id,
            caption=caption,
            reply_markup=admin_kb,
            parse_mode="HTML"
        )


from aiogram import F
from aiogram.types import CallbackQuery, BufferedInputFile
from aiogram.exceptions import TelegramBadRequest
from uuid import uuid4
from urllib.parse import urlparse
import io, json

@router.callback_query(F.data.startswith("confirm_receipt:"))
async def handle_confirm_receipt(callback: CallbackQuery, state: FSMContext):
    try:
        # ۱) پارس داده‌ها
        _, user_s, plan_s, proto, _ = callback.data.split(":", 4)
        user_id, plan_id = int(user_s), int(plan_s)
        protocol = proto.lower()

        # ۲) بارگذاری پلن و اینباند
        plan = await get_plan_by_id(plan_id)
        inbound = await get_inbound_by_protocol(protocol)
        if not plan or not inbound:
            return await callback.message.answer("❌ خطا در بارگذاری پلن/اینباند.")

        # ۳) محاسبه انقضا و حجم (بر حسب بایت)
        expiry_ts_ms   = int((datetime.utcnow() + timedelta(days=plan.duration_days)).timestamp() * 1000)
        transfer_bytes = (plan.volume_gb or 0) * 1024**3

        # ۴) تولید شناسه‌های کلاینت
        client_id = str(uuid4())
        sub_id    = str(uuid4())

        # ۵) لاگین به پنل
        parsed = urlparse(XUI_PANEL_HOST)
        panel  = PanelService(
            base_url=f"{parsed.scheme}://{parsed.netloc}",
            username=XUI_USERNAME,
            password=XUI_PASSWORD,
            panel_path=parsed.path,
        )
        if not await panel.login():
            return await callback.message.answer("❌ ورود به پنل شکست خورد.")

        # ۶) آماده‌سازی payload و افزودن کلاینت
        client = {
            "id":            client_id,
            "email":         client_id,
            "password":      client_id,
            "aid":           0,
            "flow":          "",
            "security":      "auto",
            "limitIp":       0,
            "enable":        True,
            "subId":         sub_id,
            "tgId":          "",
            "reset":         0,
            "expiryTime":    expiry_ts_ms,    # انقضا بر حسب ms
            "totalGB":       transfer_bytes,  # محدودیت حجم بر حسب بایت
        }
        if not await panel.add_client_to_inbound(inbound.id, client):
            return await callback.message.answer("❌ افزودن کلاینت به پنل شکست خورد.")
        await panel.reload_panel()

        # ۷) به‌روزرسانی محدودیت‌ها (پشتیبان)
        settings = {
            "expiryTime": expiry_ts_ms,
            "totalGB":    transfer_bytes,
            "flow":       "",
            "limitIp":    0,
            "enable":     True,
            "subId":      sub_id,
            "tgId":       "",
        }
        if not await panel.update_client(inbound.id, client_id, settings):
            return await callback.message.answer("❌ به‌روزرسانی محدودیت‌ها شکست خورد.")
        await panel.reload_panel()


        # ۶) ارسال کانفیگ و فایل
        link = panel.generate_v2ray_link(
            protocol=protocol,
            uuid=client_id,
            domain=inbound.server,
            port=inbound.port,
            encryption=inbound.encryption,
            password=client_id,
            host=inbound.host,
            path=inbound.path
        )
        config = await save_config_for_user(
            user_id=user_id,
            plan_id=plan_id,
            uuid=client_id,
            server_id=inbound.server,  # یا server.id
            v2ray_type=protocol,
            raw_link=link,
            port=inbound.port
        )
        await send_config_to_user(user_id, config, link, lang="fa")

        bio = io.BytesIO((link + "\n").encode())
        file = BufferedInputFile(bio.read(), filename=f"{protocol}_{client_id}.conf")
        await callback.bot.send_document(user_id, file)

        # ۲) ویرایش پیام قبلی (متن یا کپشن) در خودِ همان callback.message
        if callback.message.photo or callback.message.document:
            await callback.message.edit_caption("✅ کانفیگ با محدودیت پلن ارسال شد.")
        else:
            await callback.message.edit_text("✅ کانفیگ با محدودیت پلن ارسال شد.")

    except TelegramBadRequest:
        # اگر هیچ‌کدام از ویرایش‌ها امکان نداشت، پیام جدید بفرست
        await callback.message.answer("✅ کانفیگ با محدودیت پلن ارسال شد.")
    finally:
        # همیشه این دو خط اجرا شود
        await state.clear()
        await callback.answer()