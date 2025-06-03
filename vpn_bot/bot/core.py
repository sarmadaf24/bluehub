# 📁 /root/bluehub/vpn_bot/bot/core.py

from aiogram import Bot, Dispatcher   # ← اینجا Bot را هم ایمپورت می‌کنیم
import logging
from datetime import datetime, timedelta
from vpn_bot.utils.i18n import t
from vpn_bot.utils.introspection import auto_register as register_all
import vpn_bot.bot.handlers   # برای کشف ماژول‌های handlers

logger = logging.getLogger(__name__)

def register_handlers(dp: Dispatcher):
    """
    کشف و ثبت خودکار تمام Router‌های موجود در vpn_bot.bot.handlers
    """
    routers = register_all(vpn_bot.bot.handlers)
    for router in routers:
        if getattr(router, "parent_router", None) is None:
            dp.include_router(router)

async def send_config_to_user(
    bot: Bot,                # ← Bot حالا تعریف شده
    user_id: int,
    config,
    link: str,
    lang: str = "fa"
):
    """
    ارسال خلاصهٔ کانفیگ + لینک به کاربر
    ...
    """
    text = t("your_config", lang).format(
        link=link,
        expiry=(config.expiration_date.strftime("%Y-%m-%d %H:%M:%S")),
        volume=(f"{config.transfer_enable // (1024**3)} GB"
                if config.transfer_enable is not None
                else "نامحدود")
    )
    try:
        await bot.send_message(
            chat_id=user_id,
            text=text,
            parse_mode="HTML"
        )
    except Exception as e:
        logger.exception(f"❌ خطا در ارسال پیام کانفیگ به کاربر {user_id}: {e}")
