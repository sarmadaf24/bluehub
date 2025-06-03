# 📁 vpn_bot/bot/handlers/payment/paypal.py

from aiogram import Router, F
from aiogram.types import CallbackQuery, InlineKeyboardMarkup, InlineKeyboardButton
from vpn_bot.utils.i18n import t
from vpn_bot.context.lang_context import current_lang

router = Router()
print("📦 paypal.py router loaded ✅")

# 🔘 دکمه تأیید پرداخت


@router.callback_query(F.data == "payment:paypal")
async def handle_paypal_button(call: CallbackQuery):
    lang = current_lang.get()

    await call.message.edit_text(
        t("paypal_not_ready"),
        reply_markup=InlineKeyboardMarkup(inline_keyboard=[
            [InlineKeyboardButton(text=t("back"), callback_data="go:plans")]
        ])
    )
    await call.answer()


# 🔘 لینک پرداخت مستقیم (مثلاً از main menu یا دکمه جدا)
@router.callback_query(F.data == "pay_paypal")
async def handle_paypal_payment(call: CallbackQuery):
    lang = current_lang.get()

    # لینک تستی (در نسخه واقعی، از API بگیر)
    paypal_link = "https://www.paypal.me/testuser/3"

    await call.message.edit_text(
        t("paypal_payment_link", lang).format(link=paypal_link),
        parse_mode="Markdown"
    )
    await call.answer()
