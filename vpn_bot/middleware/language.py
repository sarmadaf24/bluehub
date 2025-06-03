# 📁 vpn_bot/middleware/language.py
from aiogram import BaseMiddleware
from typing import Callable, Awaitable, Dict, Any
from vpn_bot.utils.i18n import get_user_lang
from vpn_bot.context.lang_context import current_lang


class LanguageMiddleware(BaseMiddleware):
    async def __call__(
        self,
        handler: Callable[[Any, Dict[str, Any]], Awaitable[Any]],
        event: Any,
        data: Dict[str, Any],
    ) -> Any:
        user = data.get("event_from_user")
        if user:
            lang = await get_user_lang(user.id)
            current_lang.set(lang)

            # 🧠 ذخیره توی FSMContext برای دسترسی در callback ها
            state = data.get("state")
            if state:
                await state.update_data(lang=lang)

        return await handler(event, data)
