# 📁 vpn_bot/middleware/antibreak.py

from aiogram import BaseMiddleware
from aiogram.exceptions import TelegramBadRequest
from typing import Callable, Awaitable, Dict, Any
import logging

logger = logging.getLogger(__name__)

class AntiBreakMiddleware(BaseMiddleware):
    async def __call__(
        self,
        handler: Callable[[Any, Dict[str, Any]], Awaitable[Any]],
        event: Any,
        data: Dict[str, Any],
    ) -> Any:
        try:
            return await handler(event, data)
        except TelegramBadRequest as e:
            logger.warning(f"💥 TelegramBadRequest ignored: {e}")
            event_type = getattr(event, "event_type", "unknown")
            # اگر callback_query باشه، یک پاسخ بده تا از timeout جلوگیری بشه
            cb = getattr(event, "callback_query", None)
            if cb:
                await cb.answer("⛔️ عملیات روی پیام ممکن نیست.")
            return None
