# 📁 vpn_bot/bot/handlers/common/start.py

from aiogram import Router
from aiogram.types import Message, CallbackQuery
from aiogram.filters import Command

from vpn_bot.utils.i18n import get_user_lang
from vpn_bot.utils.i18n import t
from vpn_bot.services.user_service import upsert_user
from vpn_bot.keyboards.language import language_keyboard
from vpn_bot.keyboards.main import main_menu_inline
from vpn_bot.context.lang_context import current_lang

router = Router()
print("📦 start.py router loaded ✅")

@router.message(Command("start"))
async def handle_start(message: Message):
    user_id = message.from_user.id
    username = message.from_user.username
    await upsert_user(user_id=user_id, username=username)

    # استفاده از زبان تلگرام برای اولین بار
    lang = message.from_user.language_code or "en"

    await message.answer(
        text=t("choose_language", lang),
        reply_markup=language_keyboard()
    )


@router.callback_query(lambda call: call.data.startswith("lang_"))
async def handle_language_selection(call: CallbackQuery):
    lang_code = call.data.split("_")[1]
    user_id = call.from_user.id

    await upsert_user(user_id=user_id, lang=lang_code)
    current_lang.set(lang_code)  # ← تنظیم context دستی

    await call.answer(t("language_set", lang_code))
    await call.message.edit_text(
        text=t("home_msg", lang_code),
        reply_markup=main_menu_inline(lang_code)
    )


@router.callback_query(lambda call: call.data == "change_lang")
async def handle_change_language(call: CallbackQuery):
    lang = await get_user_lang(call.from_user.id)
    await call.message.edit_text(
        t("choose_language", lang),
        reply_markup=language_keyboard()
    )


@router.callback_query(lambda call: call.data == "go:main")
async def go_to_main_menu(call: CallbackQuery):
    lang = await get_user_lang(call.from_user.id)
    await call.message.edit_text(
        t("home_msg", lang),
        reply_markup=main_menu_inline(lang)
    )
