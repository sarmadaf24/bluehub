# /root/bluehub/vpn_bot/bot/handlers/user/panel/wallet.py

from aiogram import Router, F
from aiogram.types import CallbackQuery, InlineKeyboardMarkup, InlineKeyboardButton
from vpn_bot.utils.i18n import t
from vpn_bot.context.lang_context import current_lang
from vpn_bot.bot.handlers.payment.order_service import create_order_and_transaction

router = Router()
print("📦 wallet.py router loaded ✅")

@router.callback_query(F.data.startswith("user:wallet_"))
async def submenu_wallet(callback: CallbackQuery, state):
    lang = current_lang.get() or "fa"
    cfg_id = int(callback.data.split("_")[-1])

    # بارگذاری کاربر
    user_id = callback.from_user.id
    # فرضاً از دیتابیس فیلد balance بخونیم:
    from vpn_bot.db.core.session import AsyncSessionLocal
    from vpn_bot.db.models.user import User

    async with AsyncSessionLocal() as sess:
        user = await sess.get(User, user_id)

    balance = user.balance if user else 0

    # نمایش موجودی در یک پیام زیبا
    text = (
        f"💳 <b>{t('submenu_wallet', lang)}</b>\n\n"
        f"🔋 موجودی شما: <code>{balance:,}</code> {t('currency_unit', lang)}\n\n"
        f"{t('wallet_instructions', lang)}"
    )

    # دکمه «شارژ کیف‌پول»
    kb = InlineKeyboardMarkup(inline_keyboard=[[
        InlineKeyboardButton(
            text=t("wallet_recharge", lang),
            callback_data=f"user:recharge_{user_id}"
        )
    ], [
        InlineKeyboardButton(
            text=t("back_to_main", lang),
            callback_data="go:main"
        )
    ]])

    await callback.message.edit_text(text, reply_markup=kb, parse_mode="HTML")
    await callback.answer()
