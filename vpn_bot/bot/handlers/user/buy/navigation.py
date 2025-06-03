# 📁 vpn_bot/bot/handlers/user/buy/navigation.py

from aiogram import Router, F
from aiogram.types import CallbackQuery
from aiogram.fsm.context import FSMContext

from vpn_bot.keyboards.buy import protocol_selection_keyboard, v2ray_type_keyboard
from vpn_bot.utils.i18n import t
from vpn_bot.utils.i18n import get_user_lang
from vpn_bot.bot.handlers.user.buy.buy_flow import get_plan_keyboard
from vpn_bot.services.config_builder import generate_config_for_user

router = Router()
print("📦 navigation.py router loaded ✅")

@router.callback_query(F.data.startswith("go:"))
async def handle_navigation(call: CallbackQuery, state: FSMContext):
    route = call.data.split(":")[1]
    lang = await get_user_lang(call.from_user.id)

    if route == "protocols":
        await call.message.edit_text(
            t("choose_protocol", lang),
            reply_markup=protocol_selection_keyboard(lang)
        )

    elif route == "v2ray":
        await call.message.edit_text(
            t("choose_v2ray_type", lang),
            reply_markup=v2ray_type_keyboard(lang)
        )

    elif route == "plans":
        data = await state.get_data()
        v2ray_type = data.get("v2ray_type", "vmess")
        # چون get_plan_keyboard هنوز async است، باید آن را await کنیم
        keyboard = await get_plan_keyboard(lang, v2ray_type, state)
        await call.message.edit_text(
            t("choose_plan", lang),
            reply_markup=keyboard
        )

    elif route == "main":
        await call.message.edit_text(
            t("home_msg", lang)
        )

    await call.answer()
