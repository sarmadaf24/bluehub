# 📁 vpn_bot/bot/handlers/user/buy/protocol.py


from aiogram import Router, F
from aiogram.types import CallbackQuery
from vpn_bot.utils.i18n import get_user_lang
from vpn_bot.utils.i18n import t
from vpn_bot.keyboards.buy import protocol_selection_keyboard
from vpn_bot.keyboards.language import top_inline_main_menu
from vpn_bot.services.config_builder import generate_config_for_user
from vpn_bot.services.connection_service import send_config_to_user

router = Router()
print("📦 protocol.py router loaded ✅")

# 🛍 هندلر برای دکمه خرید

@router.callback_query(F.data == "menu_buy")
async def handle_buy_menu(callback: CallbackQuery):
    lang = await get_user_lang(callback.from_user.id)

    await callback.message.edit_text(
        t("choose_protocol", lang),
        reply_markup=protocol_selection_keyboard(lang)
    )


# 🔜 هندلر برای دکمه‌هایی که هنوز فعال نیستن
@router.callback_query(F.data == "coming_soon")
async def handle_coming_soon(callback: CallbackQuery):
    lang = await get_user_lang(callback.from_user.id)
    await callback.answer(t("coming_soon", lang), show_alert=True)


# 🔙 هندلر دکمه برگشت به منوی اصلی
@router.callback_query(F.data == "go:protocols")
async def go_back_to_protocols(callback: CallbackQuery):
    lang = await get_user_lang(callback.from_user.id)
    await callback.message.edit_text(
        t("choose_protocol", lang),
        reply_markup=protocol_selection_keyboard(lang)
    )


@router.callback_query(F.data == "change_lang")
async def change_language_inline(callback: CallbackQuery):
    from vpn_bot.keyboards.language import language_keyboard
    await callback.message.edit_text(
        t("choose_language"),
        reply_markup=language_keyboard()
    )


@router.callback_query(F.data == "go:home")
async def go_back_home(callback: CallbackQuery):
    lang = await get_user_lang(callback.from_user.id)
    await callback.message.edit_text(
        t("home_msg", lang),
        reply_markup=top_inline_main_menu(lang)
    )
