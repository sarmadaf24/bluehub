# 📁 vpn_bot/bot/handlers/user/buy/plans.py
# 📁 vpn_bot/bot/handlers/user/buy/plans.py

from aiogram import Router, F
from aiogram.types import CallbackQuery, InlineKeyboardMarkup, InlineKeyboardButton
from aiogram.fsm.context import FSMContext

from vpn_bot.utils.i18n import get_user_lang
from vpn_bot.utils.i18n import t
from vpn_bot.services.payment.price import calculate_price
from vpn_bot.keyboards.currency import currency_selector_keyboard
from vpn_bot.keyboards.buy import v2ray_type_keyboard
from vpn_bot.services.payment.exchange_service import get_exchange_rates
from vpn_bot.services.panel_service import get_all_plans
from vpn_bot.services.config_builder import generate_config_for_user

router = Router()
print("📦 plans.py router loaded ✅")


@router.callback_query(F.data.startswith("v2ray:"))
async def show_plan_list(callback: CallbackQuery, state: FSMContext):
    lang = await get_user_lang(callback.from_user.id)
    v2ray_type = callback.data.split(":")[1]

    # ذخیره نوع v2ray انتخاب شده
    await state.update_data(v2ray_type=v2ray_type)

    # نرخ ارز
    data = await state.get_data()
    currency = data.get("currency", "toman")
    rates = await get_exchange_rates()
    rate = rates.get(currency, 1)

    plans = await get_all_plans()
    buttons = []

    if not plans:
        return await callback.message.edit_text(
            t("no_plans", lang),
            reply_markup=v2ray_type_keyboard(lang)
        )

    for plan in plans:
        price_toman = calculate_price(plan.duration_days, plan.volume_gb)
        price = int(price_toman / rate)
        text = f"{plan.duration_days} روز - {plan.volume_gb or t(
            'plan_unlimited', lang)} گیگ - {price:,} {currency.upper()}"

        buttons.append([InlineKeyboardButton(
            text=text,
            callback_data=f"plan:{plan.id}:{v2ray_type}"
        )])

    # ↓ دکمه انتخاب ارز
    buttons += currency_selector_keyboard(currency, lang).inline_keyboard

    # ↓ دکمه برگشت به انتخاب v2ray
    buttons.append([InlineKeyboardButton(
        text=t("back", lang), callback_data="go:v2ray")])

    await callback.message.edit_text(
        t("plans_title", lang),
        reply_markup=InlineKeyboardMarkup(inline_keyboard=buttons)
    )

# @router.callback_query(F.data.startswith("currency:"))
# async def set_currency(callback: CallbackQuery, state: FSMContext):
   # new_currency = callback.data.split(":")[1]
   # await state.update_data(currency=new_currency)

    # بازخوانی مرحله با ارز جدید
    data = await state.get_data()
    v2ray_type = data.get("v2ray_type")

    if not v2ray_type:
        return await callback.answer("❌ لطفاً ابتدا نوع V2Ray را انتخاب کنید.")

    return await show_plan_list(callback, state)
