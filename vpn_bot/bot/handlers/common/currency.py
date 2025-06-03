# 📁 vpn_bot/bot/handlers/common/currency.py
from aiogram import Router, F
from aiogram.types import CallbackQuery
from aiogram.fsm.context import FSMContext

from vpn_bot.utils.i18n import get_user_lang
from vpn_bot.keyboards.currency import currency_selector_keyboard
from vpn_bot.utils.i18n import t
from vpn_bot.bot.handlers.user.buy.buy_flow import get_plan_keyboard  # اضافه شد

router = Router()  # 🛠️ این خط الزامی بود! تعریف router
print("📦 currency.py router loaded ✅")

@router.callback_query(F.data.startswith("currency:"))
async def handle_currency_change(callback: CallbackQuery, state: FSMContext):
    currency_code = callback.data.split(":")[1]
    await state.update_data(currency=currency_code)

    data = await state.get_data()
    lang = data.get("lang") or await get_user_lang(callback.from_user.id)
    v2ray_type = data.get("v2ray_type")

    if v2ray_type:
        reply_markup = await get_plan_keyboard(lang, v2ray_type, state)
        await callback.message.edit_reply_markup(reply_markup=reply_markup)
    else:
        await callback.message.edit_reply_markup(
            reply_markup=currency_selector_keyboard(currency_code, lang)
        )

    await callback.answer(t("success", lang))
