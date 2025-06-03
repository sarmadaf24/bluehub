# 📁 vpn_bot/bot/handlers/user/account/register.py

from aiogram import Router, types, F
from aiogram.types import CallbackQuery
from vpn_bot.keyboards.language import language_keyboard
from vpn_bot.keyboards.main import main_menu_keyboard
from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.user import User
from vpn_bot.utils.i18n import t

router = Router()
print("📦 register.py router loaded ✅")

@router.message(F.text == "/start")
async def handle_start(message: types.Message):
    async with AsyncSessionLocal() as session:
        user = await session.get(User, message.from_user.id)

        if not user:
            user = User(
                user_id=message.from_user.id,
                username=message.from_user.username,
                lang="fa"
            )
            session.add(user)
            await session.commit()
            lang = "fa"
        else:
            lang = user.lang or "fa"

    # 👇 حالا lang درست تعیین شده و توی ترجمه اعمال میشه
    await message.answer(
        t("choose_language", lang),
        reply_markup=language_keyboard()
    )


@router.callback_query(F.data.startswith("lang_"))
async def handle_language_selection(callback: CallbackQuery):
    lang_code = callback.data.split("_")[1]

    async with AsyncSessionLocal() as session:
        user = await session.get(User, callback.from_user.id)
        if user:
            user.lang = lang_code
            await session.commit()

    await callback.bot.edit_message_reply_markup(
        chat_id=callback.message.chat.id,
        message_id=callback.message.message_id,
        reply_markup=None
    )

    await callback.message.answer(
        t("home_msg", lang_code),
        reply_markup=main_menu_keyboard(lang_code)
    )

    await callback.answer(t("language_set", lang_code))
