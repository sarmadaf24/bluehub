# vpn_bot/bot/handlers/common/guide/v2ray.py

from aiogram import Router, F
from aiogram.types import CallbackQuery
from vpn_bot.keyboards.guide.v2ray import guide_protocols_keyboard
from vpn_bot.utils.i18n import t

from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.user import User

router = Router()
print("📦 v2ray.py router loaded ✅")

async def get_user(user_id: int):
    async with AsyncSessionLocal() as session:
        return await session.get(User, user_id)

@router.callback_query(F.data == "main:guide")
async def show_guide_menu(callback: CallbackQuery):
    user = await get_user(callback.from_user.id)
    lang = user.lang if user and user.lang else "fa"
    await callback.message.edit_text(
        text=t("guide_select_protocol", lang),
        reply_markup=guide_protocols_keyboard(lang)
    )
