# 📁 vpn_bot/bot/handlers/common/main_menu.py

from aiogram import Router
from aiogram.types import Message
from vpn_bot.utils.i18n import get_user_lang
from vpn_bot.utils.i18n import t
from vpn_bot.utils.i18n import match_key_by_text
from aiogram.fsm.context import FSMContext
from vpn_bot.bot.states import SupportStates

router = Router()
print("📦 main_menu.py router loaded ✅")

from aiogram.types import InlineKeyboardMarkup, InlineKeyboardButton

def main_menu_inline(lang: str) -> InlineKeyboardMarkup:
    kb = InlineKeyboardMarkup(inline_keyboard=[
        [InlineKeyboardButton(text=t("buy", lang),  callback_data="buy")],
        [InlineKeyboardButton(text=t("trial", lang), callback_data="trial")],
        # ... بقیه گزینه‌ها
    ])
    return kb


@router.message(lambda msg: match_key_by_text("trial", msg.text))
async def handle_trial(message: Message):
    lang = await get_user_lang(message.from_user.id)
    await message.answer(t("trial_already_used", lang))


@router.message(lambda msg: match_key_by_text("wallet", msg.text))
async def handle_wallet(message: Message):
    lang = await get_user_lang(message.from_user.id)
    await message.answer("💳 کیف پول درحال توسعه است.")


@router.message(lambda msg: match_key_by_text("my_configs", msg.text))
async def handle_my_configs(message: Message):
    lang = await get_user_lang(message.from_user.id)
    await message.answer("📦 لیست کانفیگ‌ها در دسترس نیست (فعلاً).")


@router.message(lambda msg: match_key_by_text("referral", msg.text))
async def handle_referral(message: Message):
    lang = await get_user_lang(message.from_user.id)
    await message.answer("👥 سیستم دعوت در دست توسعه است.")


@router.message(lambda msg: match_key_by_text("guide", msg.text))
async def handle_guide(message: Message):
    lang = await get_user_lang(message.from_user.id)
    await message.answer("📚 راهنمای اتصال به زودی اضافه می‌شود.")


@router.message(lambda msg: match_key_by_text("support", msg.text))
async def handle_support(message: Message, state: FSMContext):
    await message.answer("لطفاً موضوع تیکت را وارد کنید:")
    await state.set_state(SupportStates.ask_topic)
