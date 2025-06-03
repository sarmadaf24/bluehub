# 📁 vpn_bot/bot/handlers/common/language.py

from aiogram import Router
from aiogram.types import CallbackQuery
from aiogram.exceptions import TelegramBadRequest  # ✅ اضافه شد
from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.user import User
from vpn_bot.utils.i18n import t
from vpn_bot.keyboards.main import main_menu_inline

router = Router()
print("📦 language.py router loaded ✅")

@router.callback_query(lambda c: c.data.startswith("lang_"))
async def set_language(callback_query: CallbackQuery):
    lang = callback_query.data.split("_")[1]
    user_id = callback_query.from_user.id

    async with AsyncSessionLocal() as session:
        user = await session.get(User, user_id)
        if user:
            user.lang = lang
        else:
            user = User(user_id=user_id, lang=lang)
            session.add(user)
        await session.commit()

    await callback_query.answer(t("language_set", lang))

    try:
        await callback_query.message.edit_text(
            t("home_msg", lang),
            reply_markup=main_menu_inline(lang)
        )
    except TelegramBadRequest:
        # اگر پیام قابل ویرایش نبود، فقط پیام کوتاه به کاربر بده
        await callback_query.answer(t("home_msg", lang))
