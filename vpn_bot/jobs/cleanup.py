# vpn_bot/tasks/cleanup.py

import asyncio
from datetime import datetime
from aiogram import Bot
from sqlalchemy import select
from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.config import Config
from vpn_bot.utils.i18n import t

async def cleanup_and_request_feedback(bot: Bot):
    async with AsyncSessionLocal() as session:
        # 1) کانفیگ‌های منقضی‌شده که هنوز feedback_requested==False هستند
        result = await session.execute(
            select(Config)
            .where(
                Config.expiration_date < datetime.utcnow(),
                Config.feedback_requested == False
            )
        )
        expired = result.scalars().all()

        for cfg in expired:
            # 2) ارسال پیام بازخورد
            msg = t("feedback_request_msg", cfg.user.lang or "fa").format(
                date=cfg.expiration_date.strftime("%Y-%m-%d")
            )
            try:
                await bot.send_message(cfg.user_id, msg)
            except Exception:
                pass

            # 3) علامت زدن تا دیگر تکرار نشود
            cfg.feedback_requested = True

        await session.commit()
