# 📁 vpn_bot/bot_instance.py

import pkgutil
import importlib
from aiogram import Bot, Dispatcher
from config import BOT_TOKEN

bot = Bot(token=BOT_TOKEN)
dp = Dispatcher() 

# اینجا بسته‌ی handlers رو اتوماتیک اسکن می‌کنیم:
def autodiscover_handlers(package_name: str):
    pkg = importlib.import_module(package_name)
    for finder, name, ispkg in pkgutil.iter_modules(pkg.__path__, pkg.__name__ + "."):
        module = importlib.import_module(name)
        # اگر ماژول یک متغیر router داشته باشه، اون رو رجیستر کن
        router = getattr(module, "router", None)
        if router:
            dp.include_router(router)

# فراخوانیِ اتودیسکاور برای زیردایرکتوری support, user, admin و ...
autodiscover_handlers("vpn_bot.bot.handlers")
autodiscover_handlers("vpn_bot.bot.handlers.payment")

if __name__ == "__main__":
    import asyncio
    from aiogram import executor
    executor.start_polling(dp, skip_updates=True)

# ─── ایمپورت و رجیستر کردن routerهای جدید ─────────────────────
from vpn_bot.bot.handlers.user.trial.trial_deposit import router as trial_deposit_router
from vpn_bot.bot.handlers.user.trial.trial_email   import router as trial_email_router
from vpn_bot.bot.handlers.user.trial.trial import router as trial_router


dp.include_router(trial_router)
dp.include_router(trial_deposit_router)
dp.include_router(trial_email_router)
# ───────────────────────────────────────────────────────────────

