import logging
from aiogram import Bot, Dispatcher
from config import ADMIN_IDS

logger = logging.getLogger(__name__)

async def notify_admins(bot: Bot) -> None:
    for admin_id in ADMIN_IDS:
        try:
            await bot.send_message(chat_id=admin_id, text="✅ تست اتصال به ادمین موفق بود.")
        except Exception as e:
            logger.error(f"خطا در ارسال پیام تست به {admin_id}: {e}")
            raise


def register(dp: Dispatcher) -> None:
    dp.startup.register(notify_admins)
