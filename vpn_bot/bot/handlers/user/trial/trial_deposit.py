# 📁 vpn_bot/bot/handlers/user/trial_deposit.py


from aiogram.exceptions import TelegramBadRequest
from aiogram import Router, F
from aiogram.fsm.state import StatesGroup, State
from aiogram.types import (
    CallbackQuery,
    InlineKeyboardMarkup, InlineKeyboardButton,
    Message, BufferedInputFile
)
from aiogram.fsm.context import FSMContext
from vpn_bot.utils.i18n import t        # ← این خط را اضافه کن
import logging
import qrcode
from config import ADMIN_IDS
from io import BytesIO
from uuid import uuid4
from datetime import datetime, timedelta
from urllib.parse import urlparse

from config import (
    TEST_XUI_PANEL_HOST,
    TEST_XUI_USERNAME,
    TEST_XUI_PASSWORD,
    CARD_NUMBER,
    CARD_BANK_NAME,
    CARD_HOLDER,
)
from vpn_bot.services.panel_service import get_inbound_by_protocol
from vpn_bot.services.test_panel_service import TestPanelService
from vpn_bot.services.trial_config_builder import save_trial_config
from vpn_bot.services.connection_service import send_config_to_user
from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.config import Config

logger = logging.getLogger("trial-deposit")

router = Router()
print("📦 trial_deposit.py router loaded ✅")

class DepositTrialStates(StatesGroup):
    choosing_option = State()
    waiting_proof   = State()


@router.callback_query(F.data == "trial_deposit")
async def trial_deposit_entry(callback: CallbackQuery, state: FSMContext):
    lang = (await state.get_data()).get("lang", "fa")
    await state.set_state(DepositTrialStates.choosing_option)
    text = t("deposit_intro", lang)
    kb = InlineKeyboardMarkup(inline_keyboard=[
        [InlineKeyboardButton(text=t("pay_card", lang), callback_data="trial_pay_card")],
        [InlineKeyboardButton(text=t("back_to_main", lang), callback_data="go:main")]
    ])
    await callback.message.edit_text(text, reply_markup=kb)
    await callback.answer()


@router.callback_query(DepositTrialStates.choosing_option, F.data == "trial_pay_card")
async def ask_for_proof(callback: CallbackQuery, state: FSMContext):
    lang = (await state.get_data()).get("lang", "fa")
    await state.set_state(DepositTrialStates.waiting_proof)
    text = t("send_proof_prompt", lang).format(
        card_number=CARD_NUMBER,
        bank=CARD_BANK_NAME,
        holder=CARD_HOLDER,
    )
    await callback.message.edit_text(text, reply_markup=None)
    await callback.answer()


@router.message(DepositTrialStates.waiting_proof, F.content_type.in_({"photo", "document"}))
async def send_proof_to_admin(msg: Message, state: FSMContext):
    lang = (await state.get_data()).get("lang", "fa")
    user_id = msg.from_user.id

    if msg.photo:
        file_id = msg.photo[-1].file_id
    elif msg.document:
        file_id = msg.document.file_id
    else:
        return await msg.answer(t("only_image_allowed", lang))

    caption = (
        "🧾 <b>تریال جدید</b>\n"
        f"👤 <b>کاربر:</b> {user_id}\n"
        "📦 تست ۲ روزه، ۱ GiB\n"
        "💳 روش: کارت‌به‌کارت\n"
        "💰 بیعانه پس از پایان دوره برگشت داده می‌شود"
    )
    kb = InlineKeyboardMarkup(inline_keyboard=[[
        InlineKeyboardButton(text="✅", callback_data=f"confirm_trial_deposit:{user_id}"),
        InlineKeyboardButton(text="❌", callback_data=f"reject_trial_deposit:{user_id}")
    ]])
    for admin in ADMIN_IDS:
        await msg.bot.send_photo(
            chat_id=admin,
            photo=file_id,
            caption=caption,
            reply_markup=kb,
            parse_mode="HTML"
        )

    await msg.answer(t("proof_submitted_admin", lang))
    await state.clear()


@router.callback_query(F.data.startswith("reject_trial_deposit:"))
async def handle_reject_trial_deposit(cb: CallbackQuery):
    user_id = int(cb.data.split(":", 1)[1])
    lang = "fa"
    try:
        await cb.bot.send_message(user_id, t("trial_deposit_rejected", lang))
        await cb.message.edit_text("🛑 درخواست تریال با بیعانه رد شد.")
    except TelegramBadRequest:
        pass
    finally:
        await cb.answer()


@router.callback_query(F.data.startswith("confirm_trial_deposit:"))
async def handle_confirm_trial_deposit(cb: CallbackQuery, state: FSMContext):
    user_id = int(cb.data.split(":", 1)[1])
    lang = "fa"
    logger.info("🔔 Confirm trial_deposit for user %s", user_id)

    days        = 2
    bytes_limit = 1 * 1024**3
    protocol    = "vless"

    # ۱) لاگین و دریافت اینباندها
    panel = TestPanelService(
        TEST_XUI_PANEL_HOST,
        TEST_XUI_USERNAME,
        TEST_XUI_PASSWORD,
    )
    if not await panel.login():
        logger.error("❌ Login to test panel failed")
        await cb.message.answer("❌ ورود به پنل تست شکست خورد.")
        return await cb.answer()

    inbounds = await panel.get_inbounds()
    inbound = next((ib for ib in inbounds if ib.get("protocol") == protocol), None)
    if not inbound:
        await cb.message.answer("❌ هیچ اینباند تست معتبری پیدا نشد.")
        await panel.close()
        return await cb.answer()

    panel_id   = inbound["id"]
    server     = inbound.get("server")
    port       = inbound.get("port")
    encryption = inbound.get("encryption")
    host       = inbound.get("host")
    path       = inbound.get("path", "")

    # ۲) ساخت کلاینت
    expiry_ms = int((datetime.utcnow() + timedelta(days=days)).timestamp() * 1000)
    client_id = str(uuid4())
    sub_id    = str(uuid4())
    payload   = {
        "id":         client_id,
        "email":      client_id,
        "password":   client_id,
        "flow":       "",
        "security":   "tls",
        "limitIp":    0,
        "enable":     True,
        "subId":      sub_id,
        "tgId":       "",
        "reset":      0,
        "expiryTime": expiry_ms,
        "totalGB":    bytes_limit,
    }

    if not await panel.add_client_to_inbound(panel_id, payload):
        logger.error("❌ add_client_to_inbound failed for %s", client_id)
        await cb.message.answer("❌ افزودن به سرور تست شکست خورد.")
        await panel.close()
        return await cb.answer()

    await panel.reload_panel()
    await panel.update_client(panel_id, client_id, payload)
    await panel.reload_panel()

    # ۳) تولید لینک و ذخیره کانفیگ
    link = panel.generate_v2ray_link(
        protocol=protocol,
        uuid=client_id,
        domain=server,
        port=port,
        encryption=encryption,
        password=client_id,
        host=host,
        path=path,
    )
    cfg = await save_trial_config(
        user_id=user_id,
        client_id=client_id,
        server=server,
        port=port,
        domain=server,
        bytes_limit=bytes_limit,
        days=days
    )
    logger.info("💾 Config saved (id=%s)", cfg.id)

    # ۴) ارسال کانفیگ
    await send_config_to_user(
        user_id=user_id,
        config=cfg,
        link=link,
        lang=lang
    )
    bio = BytesIO((link + "\n").encode())
    file = BufferedInputFile(bio.read(), filename=f"{protocol}_{client_id}.conf")
    await cb.bot.send_document(user_id, file)
    logger.info("📤 Config sent to %s", user_id)

    # پیام تأیید برای ادمین
    try:
        if cb.message.photo or cb.message.document:
            await cb.message.edit_caption("✅ تریال با موفقیت فعال و کانفیگ ارسال شد.")
        else:
            await cb.message.edit_text("✅ تریال با موفقیت فعال و کانفیگ ارسال شد.")
    except TelegramBadRequest:
        await cb.message.answer("✅ تریال با موفقیت فعال و کانفیگ ارسال شد.")

    await panel.close()
    await state.clear()
    await cb.answer()