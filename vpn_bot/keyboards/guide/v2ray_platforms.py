# vpn_bot/keyboards/guide/v2ray_platforms.py

from aiogram.types import InlineKeyboardMarkup, InlineKeyboardButton
from vpn_bot.utils.i18n import t


def v2ray_platforms_keyboard(lang: str = "fa") -> InlineKeyboardMarkup:
    buttons = [
        [InlineKeyboardButton(text=t("guide_android", lang), callback_data="guide:v2ray:android")],
        [InlineKeyboardButton(text=t("guide_ios", lang), callback_data="guide:v2ray:ios")],
        [InlineKeyboardButton(text=t("guide_windows", lang), callback_data="guide:v2ray:windows")],
        [InlineKeyboardButton(text=t("guide_macos", lang), callback_data="guide:v2ray:macos")],
        [InlineKeyboardButton(text=t("back", lang), callback_data="guide:back_to_protocols")]
    ]

    return InlineKeyboardMarkup(inline_keyboard=buttons)

