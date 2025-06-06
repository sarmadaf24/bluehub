"""Celery job to predict ticket categories and alert admin."""
import asyncio
import joblib
from celery import Celery
from sqlalchemy import select

from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.ticket import Ticket
from vpn_bot.bot_instance import bot
from config import ADMIN_CHAT_ID

app = Celery('predictor', broker='redis://localhost:6379/0')

@app.task
def detect_trending():
    asyncio.run(_detect())

async def _detect():
    model = joblib.load('ticket_predictor.pkl')
    async with AsyncSessionLocal() as session:
        result = await session.execute(select(Ticket.message))
        msgs = [r[0] for r in result.all()]
    preds = model.predict(msgs)
    # naive frequency check
    from collections import Counter
    cnt = Counter(preds)
    common, freq = cnt.most_common(1)[0]
    if freq > 5:
        await bot.send_message(ADMIN_CHAT_ID, f'هشدار: تکرار زیاد {common}')
