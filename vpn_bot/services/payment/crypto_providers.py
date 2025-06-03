# 📁 vpn_bot/bot/handlers/payment/crypto_providers.py

from aiogram.utils.keyboard import InlineKeyboardBuilder
from aiogram.types import InlineKeyboardButton, Message
from aiogram import Router
from vpn_bot.services.payment.crypto_strategy import provider_map
from vpn_bot.context.lang_context import current_lang
from vpn_bot.utils.i18n import t

router = Router()

@router.callback_query(lambda c: c.data == "payment:crypto")
async def show_provider_selection(call):
    lang = current_lang.get()
    builder = InlineKeyboardBuilder()
    for name in provider_map.keys():
        builder.button(
            text=name,
            callback_data=f"crypto:provider:{name}"
        )  # افزودن دکمه برای هر provider :contentReference[oaicite:4]{index=4}
    builder.adjust(2)  # دو ستون :contentReference[oaicite:5]{index=5}
    builder.button(
        text=t("back", lang),
        callback_data="go:payment_menu"
    )
    await call.message.edit_text(
        t("choose_crypto_provider", lang),
        reply_markup=builder.as_markup()
    )
    await call.answer()
