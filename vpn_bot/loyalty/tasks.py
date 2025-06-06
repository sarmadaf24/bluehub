"""Celery tasks for loyalty broadcast."""

import asyncio
import logging
from datetime import datetime, timedelta

from celery import Celery
from sqlalchemy import select

from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.user import User
from vpn_bot.db.models.coupon import Coupon
from vpn_bot.bot_instance import bot

app = Celery('loyalty', broker='redis://localhost:6379/0')
logger = logging.getLogger('loyalty')

@app.task
def broadcast_loyalty_messages():
    """Send categorized broadcast messages with personal discount codes."""
    asyncio.run(_broadcast())

async def _broadcast():
    async with AsyncSessionLocal() as session:
        result = await session.execute(select(User))
        users = result.scalars().all()
        for user in users:
            code = f"L{user.user_id}{int(datetime.utcnow().timestamp())}"[:10]
            coupon = Coupon(code=code, discount=20,
                            valid_until=datetime.utcnow()+timedelta(days=7))
            session.add(coupon)
            try:
                await bot.send_message(user.user_id,
                                       f"کد تخفیف ویژه شما: {code}")
            except Exception as e:
                logger.exception("Send failed for %s: %s", user.user_id, e)
        await session.commit()
