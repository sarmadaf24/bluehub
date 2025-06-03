# File: vpn_bot/keyboards/main.py

from aiogram.types import (
    InlineKeyboardMarkup, InlineKeyboardButton,
    ReplyKeyboardMarkup, KeyboardButton
)
from vpn_bot.utils.i18n import t

def main_menu_keyboard(lang: str = "fa") -> ReplyKeyboardMarkup:
    return ReplyKeyboardMarkup(
        keyboard=[
            [
                KeyboardButton(text=t("buy_config", lang)),
                KeyboardButton(text=t("my_configs", lang))
            ],
            [
                KeyboardButton(text=t("trial", lang))
            ],
            [
                KeyboardButton(text=t("referral", lang)),
                KeyboardButton(text=t("guide", lang))
            ],
            [
                KeyboardButton(text=t("support", lang))
            ]
        ],
        resize_keyboard=True
    )

def main_menu_inline(lang: str = "fa") -> InlineKeyboardMarkup:
    return InlineKeyboardMarkup(
        inline_keyboard=[
            [ InlineKeyboardButton(text=t("buy_config", lang), callback_data="main:buy") ],
            [ InlineKeyboardButton(text=t("my_configs", lang), callback_data="main:my_configs") ],
            [ InlineKeyboardButton(text=t("trial", lang), callback_data="main:trial") ],
            [ InlineKeyboardButton(text=t("referral", lang), callback_data="main:referral") ],
            [ InlineKeyboardButton(text=t("guide", lang), callback_data="main:guide") ],
            [ InlineKeyboardButton(text=t("support", lang), callback_data="main:support") ],
            [ InlineKeyboardButton(text=t("change_language", lang), callback_data="change_lang") ]
        ]
    )

# ─── اضافه می‌کنیم ───────────────────────────────────────────────────────────


