"""Celery task to send survey links when tickets close."""
from datetime import datetime
import asyncio
from celery import Celery
from sqlalchemy import select

from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.ticket import Ticket
from vpn_bot.bot_instance import bot

app = Celery('survey', broker='redis://localhost:6379/0')

@app.task
def send_surveys():
    asyncio.run(_send())

async def _send():
    async with AsyncSessionLocal() as session:
        result = await session.execute(select(Ticket).where(Ticket.status=='closed', Ticket.answered_at != None))
        tickets = result.scalars().all()
        for t in tickets:
            try:
                await bot.send_message(t.user_id, 'لطفاً نظر خود را در مورد پشتیبانی ثبت کنید: https://example.com/survey')
            except Exception:
                pass
