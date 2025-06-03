# 📁 vpn_bot/bot/handlers/common/menu.py


from aiogram import Router, F
from aiogram.types import CallbackQuery
from vpn_bot.utils.i18n import get_user_lang
from vpn_bot.utils.i18n import t
from vpn_bot.keyboards.buy import protocol_selection_keyboard

router = Router()
print("📦 menu.py router loaded ✅")

@router.callback_query(F.data == "main:buy")
async def handle_main_buy(call: CallbackQuery):
    lang = await get_user_lang(call.from_user.id)
    await call.message.edit_text(
        t("choose_protocol", lang),
        reply_markup=protocol_selection_keyboard(lang)
    )


@router.callback_query(F.data == "main:support")
async def handle_main_support(call: CallbackQuery):
    lang = await get_user_lang(call.from_user.id)
    await call.message.answer(t("send_support_msg", lang))
    await call.answer()
