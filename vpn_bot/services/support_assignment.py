# File: vpn_bot/services/support_assignment.py

from datetime import datetime
from sqlalchemy import select, update, func
from vpn_bot.db.models.support_agent import SupportAgent
from vpn_bot.db.core.session import AsyncSessionLocal as async_session

async def assign_agent():
    """
    Round-robin assignment: pick the active agent with oldest last_assigned_at,
    update its last_assigned_at, and return it.
    """
    async with async_session() as session:
        q = (
            select(SupportAgent)
            .where(SupportAgent.is_active.is_(True))
            .order_by(SupportAgent.last_assigned_at)
            .limit(1)
        )
        result = await session.execute(q)
        agent = result.scalars().first()
        if not agent:
            return None
        await session.execute(
            update(SupportAgent)
            .where(SupportAgent.id == agent.id)
            .values(last_assigned_at=func.now())
        )
        await session.commit()
        return agent
