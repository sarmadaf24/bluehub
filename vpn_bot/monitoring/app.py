"""FastAPI app exposing analytics metrics."""

from fastapi import FastAPI
from sqlalchemy import func, select

from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.ticket import Ticket
from .prometheus_middleware import PrometheusMiddleware, metrics_endpoint

app = FastAPI(title="Monitoring")
app.add_middleware(PrometheusMiddleware)
app.add_api_route('/metrics', metrics_endpoint, methods=['GET'])

@app.get('/stats/tickets')
async def ticket_count():
    async with AsyncSessionLocal() as session:
        result = await session.execute(select(func.count()).select_from(Ticket))
        count = result.scalar() or 0
        return {"total_tickets": count}
