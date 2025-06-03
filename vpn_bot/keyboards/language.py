# 📁 vpn_bot/keyboards/language.py

from aiogram.types import InlineKeyboardMarkup, InlineKeyboardButton
from vpn_bot.utils.i18n import t


def language_keyboard() -> InlineKeyboardMarkup:
    LANGUAGES = {
        "fa": "🇮🇷 فارسی", "en": "🇺🇸 English", "tr": "🇹🇷 Türkçe",
        "ar": "🇸🇦 العربیة", "ru": "🇷🇺 Русский", "fr": "🇫🇷 Français",
        "de": "🇩🇪 Deutsch", "es": "🇪🇸 Español", "ur": "🇵🇰 اردو"
    }
    buttons = [
        [InlineKeyboardButton(text=name, callback_data=f"lang_{code}")]
        for code, name in LANGUAGES.items()
    ]
    return InlineKeyboardMarkup(inline_keyboard=buttons)


def top_inline_main_menu(lang: str) -> InlineKeyboardMarkup:
    buttons = [
        [InlineKeyboardButton(text=t("buy_config", lang), callback_data="menu_buy"),
         InlineKeyboardButton(text=t("my_configs", lang), callback_data="menu_my")],
        [InlineKeyboardButton(text=t("trial", lang), callback_data="menu_trial"),
         InlineKeyboardButton(text=t("wallet", lang), callback_data="menu_wallet")],
        [InlineKeyboardButton(text=t("referral", lang), callback_data="menu_referral"),
         InlineKeyboardButton(text=t("guide", lang), callback_data="menu_guide")],
        [InlineKeyboardButton(text=t("support", lang),
                              callback_data="menu_support")],
        [InlineKeyboardButton(text=t("change_language", lang),
                              callback_data="change_lang")]
    ]
    return InlineKeyboardMarkup(inline_keyboard=buttons)
