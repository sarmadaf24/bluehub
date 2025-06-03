import asyncio
from sqlalchemy.future import select
from sqlalchemy.orm import selectinload
from db.core.session import AsyncSessionLocal
from db.models.plan import Plan

async def test_orm_relationship():
    async with AsyncSessionLocal() as session:
        result = await session.execute(
            select(Plan).options(selectinload(Plan.inbound)).limit(5)
        )
        plans = result.scalars().all()
        for plan in plans:
            print(f"📦 Plan: {plan.name}")
            if plan.inbound:
                print(f"✅ Linked to inbound ID: {plan.inbound_id}")
                print(f"   ↳ Server: {plan.inbound.server}, Port: {plan.inbound.port}, Protocol: {plan.inbound.protocol}")
            else:
                print("❌ No inbound linked.")

asyncio.run(test_orm_relationship())
