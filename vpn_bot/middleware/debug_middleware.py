# 📁 vpn_bot/middleware/debug_middleware.py
import logging
from aiogram import BaseMiddleware
from aiogram.types import TelegramObject
from aiogram.dispatcher.router import Router

class DebugMiddleware(BaseMiddleware):
    """
    Middleware for logging all incoming updates and events.
    """

    async def __call__(self,
                       handler: callable,
                       event: TelegramObject,
                       data: dict):
        # لاگ کامل شیء دریافت‌شده
        logging.debug(f"🔍 DebugMiddleware received event: {event!r}")
        # می‌توانید دیتای بیشتری هم لاگ کنید:
        if data.get("state"):
            logging.debug(f"📌 FSM state: {data['state']!r}")
        # اجرای هِندلر اصلی
        return await handler(event, data)
