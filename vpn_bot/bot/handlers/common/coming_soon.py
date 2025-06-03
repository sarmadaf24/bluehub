# 📁 vpn_bot/bot/handlers/common/coming_soon.py

from aiogram import Router, F
from aiogram.types import CallbackQuery
from vpn_bot.utils.i18n import get_user_lang
from vpn_bot.utils.i18n import t

router = Router()
print("📦 coming_soon.py router loaded ✅")


@router.callback_query(F.data == "coming_soon")
async def handle_coming_soon(call: CallbackQuery):
    lang = await get_user_lang(call.from_user.id)
    await call.answer(t("coming_soon", lang), show_alert=True)
