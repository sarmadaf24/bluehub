# 📁 /root/bluehub/main.py

import os
import sys
import asyncio
import logging

# 📦 افزودن مسیر پروژه
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '../../../')))

# =======================
# 🧩 Middleware
# =======================
from aiogram import BaseMiddleware
from vpn_bot.middleware.language import LanguageMiddleware
from vpn_bot.middleware.debug_middleware import DebugMiddleware
from vpn_bot.middleware.antibreak import AntiBreakMiddleware
# =======================
# 🔧 Core Imports
# =======================
from vpn_bot.services.payment.scheduler import start_scheduler
from config import LOG_LEVEL, ENVIRONMENT
from vpn_bot.bot_instance import bot, dp
from vpn_bot.bot.core import register_handlers
from vpn_bot.bot.startup import register as register_startup
# =======================
# 🚀 راه‌اندازی ربات
# =======================
async def main():
    # — تنظیم لاگینگ
    logging.basicConfig(
        level=logging.DEBUG,
        format="🔧 [%(asctime)s] [%(levelname)s] %(name)s: %(message)s",
    )
    logging.getLogger("aiogram").setLevel(logging.DEBUG)
    logging.getLogger("asyncio").setLevel(logging.INFO)


    # ثبت Middleware‌ها
    dp.update.middleware(DebugMiddleware())
    dp.message.middleware(DebugMiddleware())
    dp.message.middleware(LanguageMiddleware())
    dp.callback_query.middleware(LanguageMiddleware())
    dp.message.middleware(AntiBreakMiddleware())
    dp.callback_query.middleware(AntiBreakMiddleware())
    # — ثبت هندلرها و
    register_handlers(dp)
    register_startup(dp)
      # — اجرای Scheduler در پس‌زمینه
    asyncio.create_task(start_scheduler())

    try:
        # — حذف وبهوک‌های قبلی و پاک‌سازی آپدیت‌ها
        await bot.delete_webhook(drop_pending_updates=True)

        # — شروع Polling (یک‌بار)
        await dp.start_polling(bot)
    finally:
        # — بستن جلسه‌ی aiohttp
        # در Aiogram 3.3+:
        await bot.close()
        # اگر نسخه‌ی قدیمی‌تر دارید:
        # await bot.session.close()
# =======================
# ⏹ نقطه ورود برنامه
# =======================
if __name__ == "__main__":
    try:
        asyncio.run(main())
    except (KeyboardInterrupt, SystemExit):
        logging.info("❌ Bot stopped by user.")
