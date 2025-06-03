# 📁 /root/bluehub/vpn_bot/bot/handlers/payment/crypto_providers.py

from aiogram import Router, F
from aiogram.types import CallbackQuery, InlineKeyboardButton, InlineKeyboardMarkup
from aiogram.fsm.context import FSMContext

from vpn_bot.context.lang_context import current_lang
from vpn_bot.utils.i18n import t

# ← این خط را دقیقاً به همین شکل در بالای فایل اضافه کن:
from vpn_bot.bot.handlers.payment.crypto import show_crypto_coins


router = Router()

PROVIDERS = [
    ("nowpayments",  "NOWPayments"),
    ("nobitex",      "Nobitex"),
    ("wallex",       "Wallex"),
    ("exir",         "Exir"),
]

ICONS = {
    "nowpayments":  "💰",
    "nobitex":      "🇮🇷",
    "wallex":       "💼",
    "exir":         "🦅",
}

@router.callback_query(F.data == "payment:crypto")
async def show_crypto_providers(call: CallbackQuery, state: FSMContext):
    lang = current_lang.get()
    buttons = []
    for key, label in PROVIDERS:
        buttons.append([
            InlineKeyboardButton(
                text=f"{ICONS.get(key,'🪙')} {label}",
                callback_data=f"crypto:provider:{key}"
            )
        ])
    buttons.append([
        InlineKeyboardButton(
            text=f"◀️ {t('back', lang)}",
            callback_data="go:payment_menu"
        )
    ])
    await call.message.edit_text(
        t("choose_crypto_provider", lang),
        reply_markup=InlineKeyboardMarkup(inline_keyboard=buttons)
    )
    await call.answer()

@router.callback_query(F.data.startswith("crypto:provider:"))
async def select_crypto_provider(call: CallbackQuery, state: FSMContext):
    provider = call.data.split(":", 2)[2]
    await state.update_data(selected_provider=provider)
    # ← اینجا فقط فراخوانی show_crypto_coins بدون import مجدد
    await show_crypto_coins(call, state)
    await call.answer()
