# 📁 vpn_bot/bot/handlers/user/trial.py


from aiogram import Router, F
from aiogram.types import CallbackQuery, InlineKeyboardMarkup, InlineKeyboardButton
from aiogram.fsm.context import FSMContext

from vpn_bot.utils.i18n import t
from vpn_bot.keyboards.main import main_menu_inline


router = Router()
print("📦 trial.py router loaded ✅")

@router.callback_query(F.data == "main:trial")
async def show_trial_menu(callback: CallbackQuery, state: FSMContext):
    lang = (await state.get_data()).get("lang", "fa")
    text = t("trial_intro", lang)  # 🔒 برای جلوگیری از سوءاستفاده...
    kb = InlineKeyboardMarkup(inline_keyboard=[
        [
            InlineKeyboardButton(
                text=t("trial_deposit_button", lang),  # تست 2 روزه با یک گیگ بیعانه ناچیز
                callback_data="trial_deposit"
            )
        ],
        [
            InlineKeyboardButton(
                text=t("trial_email_button", lang),    # تست 1 روزه با 600 مگا بیت با ایمیل
                callback_data="trial_email"
            )
        ],
        [
            InlineKeyboardButton(
                text=t("back_to_main", lang),
                callback_data="go:main"
            )
        ],
    ])
    await callback.message.edit_text(text, reply_markup=kb)
    await callback.answer()
