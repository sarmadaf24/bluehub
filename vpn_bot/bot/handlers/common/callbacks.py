# 📁 vpn_bot/bot/handlers/common/callbacks.py

from aiogram.filters.callback_data import CallbackData
from aiogram import Router, F
from aiogram.types import CallbackQuery, BufferedInputFile
from vpn_bot.db.models import Config
from vpn_bot.db.models.user import User
from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.services.payment.order_service import create_order
from vpn_bot.utils.i18n import t
import qrcode
import io

router = Router()
print("📦 callbacks.py router loaded ✅")

@router.callback_query(F.data.startswith("get_qr_"))
async def handle_qr_callback(call: CallbackQuery):
    config_id = int(call.data.split("get_qr_")[1])

    async with AsyncSessionLocal() as session:
        config = await session.get(Config, config_id)
        user = await session.get(User, call.from_user.id)
        lang = user.lang if user and user.lang else "en"

    if not config:
        await call.answer(t("config_not_found", lang))
        return

    config_str = f"{
        config.protocol}://{config.uuid}@{config.server}:{config.port}"
    qr = qrcode.make(config_str)
    qr_bytes = io.BytesIO()
    qr.save(qr_bytes)
    qr_bytes.seek(0)

    caption = (
        f"{t('config_info', lang).format(name=config.config_name, server=config.server,
                                         port=config.port, uuid=config.uuid, protocol=config.protocol, exp=config.expiration_date)}"
    )

    await call.message.answer_photo(
        photo=BufferedInputFile(qr_bytes.read(), filename="qr.png"),
        caption=caption,
        parse_mode="Markdown"
    )
    await call.answer(t("qr_sent", lang))


@router.callback_query(F.data.startswith("buy:"))
async def handle_plan_purchase(callback: CallbackQuery):
    plan_id = int(callback.data.split(":")[1])
    user_id = callback.from_user.id

    async with AsyncSessionLocal() as session:
        user = await session.get(User, user_id)
        lang = user.lang if user and user.lang else "en"

    order = await create_order(user_id=user_id, plan_id=plan_id)

    await callback.message.edit_text(
        f"{t('order_success', lang)}\n"
        f"{t('order_id', lang)}: <code>{order.id}</code>\n"
        f"{t('waiting_payment', lang)}"
    )
    await callback.answer()


class MainMenuCD(CallbackData, prefix="main"):
    action: str
