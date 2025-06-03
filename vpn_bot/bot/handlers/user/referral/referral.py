# 📁 /root/bluehub/vpn_bot/bot/handlers/user/referral/referral.py

from aiogram import Router, F
from aiogram.types import CallbackQuery, InlineKeyboardMarkup, InlineKeyboardButton
from aiogram.fsm.context import FSMContext

from vpn_bot.services.referral_service import get_referral_stats
from vpn_bot.utils.i18n import t
from vpn_bot.keyboards.main import main_menu_inline

router = Router()
print("📦 referral.py router loaded ✅")

@router.callback_query(F.data == "main:referral")
async def submenu_referral(callback: CallbackQuery, state: FSMContext):
    lang = (await state.get_data()).get("lang", "fa")
    user_id = callback.from_user.id

    count, total_bonus = await get_referral_stats(user_id)
    link = f"https://t.me/{{YOUR_BOT_USERNAME}}?start={user_id}"

    text = (
        f"👥 <b>{t('submenu_referral', lang)}</b>\n\n"
        f"{t('referral_count', lang)}: {count}\n"
        f"{t('referral_bonus_total', lang)}: {total_bonus:,} {t('currency_unit', lang)}\n\n"
        f"{t('referral_link', lang)}:\n<code>{link}</code>"
    )

    kb = InlineKeyboardMarkup(inline_keyboard=[
        [InlineKeyboardButton(text=t("back_to_main", lang), callback_data="go:main")]
    ])

    await callback.message.edit_text(text, reply_markup=kb, parse_mode="HTML")
    await callback.answer()

