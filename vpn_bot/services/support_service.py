from sqlalchemy import select
from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.support_ticket import SupportTicket
from vpn_bot.db.models.support_message import SupportMessage
from vpn_bot.db.models.support_agent import SupportAgent

async def save_ticket(user_id: int, subject: str, description: str) -> int:
    async with AsyncSessionLocal() as session:
        ticket = SupportTicket(user_id=user_id, question=subject, status="open")
        session.add(ticket)
        await session.flush()
        msg = SupportMessage(
            ticket_id=ticket.id,
            from_user="user",
            content=description
        )
        session.add(msg)
        await session.commit()
        return ticket.id

async def assign_ticket(ticket_id: int, operator_id: int):
    async with AsyncSessionLocal() as session:
        result = await session.execute(select(SupportAgent).where(SupportAgent.user_id == operator_id))
        agent = result.scalar_one_or_none()
        if not agent:
            agent = SupportAgent(user_id=operator_id)
            session.add(agent)
            await session.flush()
        ticket = await session.get(SupportTicket, ticket_id)
        if ticket:
            ticket.agent_id = agent.id
        await session.commit()

async def get_active_ticket_for_operator(operator_id: int) -> int | None:
    async with AsyncSessionLocal() as session:
        result = await session.execute(select(SupportAgent).where(SupportAgent.user_id == operator_id))
        agent = result.scalar_one_or_none()
        if not agent:
            return None
        result = await session.execute(
            select(SupportTicket.id)
            .where(SupportTicket.agent_id == agent.id)
            .where(SupportTicket.status == "open")
            .order_by(SupportTicket.created_at)
            .limit(1)
        )
        row = result.first()
        return row[0] if row else None

async def get_user_for_ticket(ticket_id: int) -> int | None:
    async with AsyncSessionLocal() as session:
        ticket = await session.get(SupportTicket, ticket_id)
        return ticket.user_id if ticket else None
