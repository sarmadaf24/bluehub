# 📁 vpn_bot/bot/handlers/user/buy/buy_flow.py

from aiogram import Router, F
from aiogram.types import Message, CallbackQuery, InlineKeyboardMarkup, InlineKeyboardButton
from aiogram.fsm.context import FSMContext

from vpn_bot.bot.handlers.payment.state import CardPaymentStates
from vpn_bot.utils.i18n import t, match_key_by_text
from vpn_bot.context.lang_context import current_lang
from vpn_bot.services.panel_service import get_all_plans
from vpn_bot.services.payment.exchange_service import get_exchange_rates
from vpn_bot.services.payment.price import calculate_price
from vpn_bot.keyboards.currency import currency_selector_keyboard
from vpn_bot.services.config_builder import generate_config_for_user
from vpn_bot.services.connection_service import send_config_to_user
from vpn_bot.bot.handlers.user.buy.states import PlanPaymentStates

from vpn_bot.keyboards.buy import (
    protocol_selection_keyboard,
    v2ray_type_keyboard,
    payment_type_keyboard,
)

router = Router()

print("📦 buy_flow.py router loaded ✅")
# ─────────────────────────────


@router.message(lambda msg: match_key_by_text("buy_config", msg.text))
async def start_buy(message: Message):
    lang = current_lang.get()
    await message.answer(
        t("choose_protocol"),
        reply_markup=protocol_selection_keyboard(lang)
    )

# ─────────────────────────────


@router.callback_query(F.data.startswith("proto_"))
async def choose_protocol(callback: CallbackQuery):
    lang = current_lang.get()
    protocol = callback.data.split("_")[1]

    if protocol == "v2ray":
        await callback.message.edit_text(
            t("choose_v2ray_type"),
            reply_markup=v2ray_type_keyboard(lang)
        )
    else:
        await callback.answer(t("coming_soon"), show_alert=True)

# ─────────────────────────────

@router.callback_query(F.data.startswith("v2ray:"))
async def choose_v2ray_type(callback: CallbackQuery, state: FSMContext):
    data = await state.get_data()
    lang = data.get("lang", "fa")
    v2ray_type = callback.data.split(":",1)[1]
    await state.update_data(v2ray_type=v2ray_type)

    keyboard = await get_plan_keyboard(lang, v2ray_type, state)
    await callback.message.edit_text(
        t("choose_plan", lang).format(type=v2ray_type),
        reply_markup=keyboard
    )
    await state.set_state(PlanPaymentStates.choosing_plan)
    await callback.answer()

# ─────────────────────────────


async def get_plan_keyboard(lang: str, v2ray_type: str, state: FSMContext) -> InlineKeyboardMarkup:
    print("🌐 get_plan_keyboard → current_lang.get() =", current_lang.get())
    lang = current_lang.get()
    data = await state.get_data()
    currency = data.get("currency", "toman")

    rates = await get_exchange_rates()
    rate = rates.get(currency, 1)

    plans = await get_all_plans()
    buttons = []

    if not plans:
        buttons.append([
            InlineKeyboardButton(text=t("no_plans"), callback_data="no_plan")
        ])
    else:
        for plan in plans:
            if plan.volume_gb is None:
                buttons.append([
                    InlineKeyboardButton(
                        text=f"💎 {t('plan_unlimited')} ({
                            t('buy_via_ticket')})",
                        callback_data="contact_support_unlimited"
                    )
                ])
                continue

            price_toman = calculate_price(plan.duration_days, plan.volume_gb)
            if currency == "toman":
                price_converted = price_toman
            else:
                price_rial = price_toman * 10
                price_converted = int(price_rial / rate / 10)

            price_str = f"{price_converted:,} {currency.upper()}"
            volume_str = f"{plan.volume_gb} GB"
            days_suffix = t("days_suffix")
            title = f"📦 {plan.duration_days} {
                days_suffix} | {volume_str} | 💰 {price_str}"

            buttons.append([
                InlineKeyboardButton(
                    text=title,
                    callback_data=f"plan:{plan.id}:{v2ray_type}"
                )
            ])

    # دکمه‌های ارز
    currency_buttons = currency_selector_keyboard(
        current_currency=currency, lang=lang).inline_keyboard
    buttons += currency_buttons

    # دکمه برگشت
    buttons.append([
        InlineKeyboardButton(text=t("back"), callback_data="go:v2ray")
    ])

    return InlineKeyboardMarkup(inline_keyboard=buttons)

# ─────────────────────────────
# 📦 هندلر انتخاب پلن


@router.callback_query(F.data.startswith("plan:"))
async def handle_plan_selection(callback: CallbackQuery, state: FSMContext):
    lang = current_lang.get()
    data = callback.data.split(":")
    plan_id = int(data[1])
    v2ray_type = data[2]

    # 🔁 گرفتن قیمت پلن و تبدیل به دلار
    from vpn_bot.services.panel_service import get_plan_by_id
    from vpn_bot.services.payment.exchange_service import get_exchange_rates
    from vpn_bot.services.payment.price import calculate_price

    plan = await get_plan_by_id(plan_id)
    price_toman = calculate_price(plan.duration_days, plan.volume_gb)

    rates = await get_exchange_rates()
    usd_rate = rates.get("usd", 60000)  # ← مثال نرخ

    price_usd = round((price_toman * 10) / usd_rate, 2)

    # 💾 ذخیره در state
    await state.update_data(
        plan_id=plan_id,
        v2ray_type=v2ray_type,
        amount_usd=price_usd
    )

    await callback.message.edit_text(
        t("choose_payment_type", lang),
        reply_markup=payment_type_keyboard(lang, v2ray_type)
    )
    await callback.answer()
