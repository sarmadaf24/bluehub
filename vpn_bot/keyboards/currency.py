# 📁 vpn_bot/keyboards/currency.py

from aiogram.types import InlineKeyboardMarkup, InlineKeyboardButton
from vpn_bot.utils.i18n import t

CURRENCIES = ["toman", "usd", "eur", "aed", "try", "trx"]


def currency_selector_keyboard(current_currency: str = "toman", lang: str = "fa") -> InlineKeyboardMarkup:
    buttons = []

    for code in CURRENCIES:
        label = t(f"currency_{code}", lang)
        if code == current_currency:
            label = f"✅ {label}"
        buttons.append(
            InlineKeyboardButton(
                text=label,
                callback_data=f"currency:{code}"
            )
        )

    # تقسیم به ۳ ردیف ۲تایی
    rowed = [buttons[i:i+2] for i in range(0, len(buttons), 2)]

    return InlineKeyboardMarkup(inline_keyboard=rowed)
