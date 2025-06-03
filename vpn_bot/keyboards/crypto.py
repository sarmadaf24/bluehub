# 📁 vpn_bot/keyboards/crypto.py

from aiogram.types import InlineKeyboardMarkup, InlineKeyboardButton
from vpn_bot.constants.crypto_coins import SUPPORTED_COINS


def get_crypto_coin_keyboard(lang: str = "fa") -> InlineKeyboardMarkup:
    buttons = []

    # 🧠 ایجاد دکمه‌ها از SUPPORTED_COINS دو‌تایی در هر ردیف
    for i in range(0, len(SUPPORTED_COINS), 2):
        row = []
        for coin in SUPPORTED_COINS[i:i+2]:
            symbol = coin["symbol"]
            emoji = coin["emoji"]
            row.append(
                InlineKeyboardButton(
                    text=f"{emoji} {symbol}",
                    callback_data=f"crypto_coin:{symbol.lower()}"
                )
            )
        buttons.append(row)

    # 🔙 دکمه برگشت
    buttons.append([
        InlineKeyboardButton(
            text="🔙 بازگشت", callback_data="go:payment_menu"
        )
    ])

    return InlineKeyboardMarkup(inline_keyboard=buttons)
