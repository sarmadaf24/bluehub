# 📁 vpn_bot/bot/handlers/user/buy/v2ray.py
# 📁 vpn_bot/bot/handlers/user/buy/v2ray.py

from aiogram import Router, F
from aiogram.types import CallbackQuery

from vpn_bot.utils.i18n import get_user_lang
from vpn_bot.utils.i18n import t
from vpn_bot.keyboards.buy import v2ray_type_keyboard, protocol_selection_keyboard
from vpn_bot.services.config_builder import generate_config_for_user

router = Router()
print("📦 v2ray.py router loaded ✅")

# ✅ نمایش منوی انواع V2Ray


@router.callback_query(F.data == "proto_v2ray")
async def show_v2ray_options(callback: CallbackQuery):
    lang = await get_user_lang(callback.from_user.id)
    await callback.message.edit_text(
        t("choose_v2ray_type", lang),
        reply_markup=v2ray_type_keyboard(lang)
    )

# 🔙 برگشت از V2Ray به لیست پروتکل‌ها


@router.callback_query(F.data == "go:protocols")
async def back_to_protocols(callback: CallbackQuery):
    lang = await get_user_lang(callback.from_user.id)
    await callback.message.edit_text(
        t("choose_protocol", lang),
        reply_markup=protocol_selection_keyboard(lang)
    )
