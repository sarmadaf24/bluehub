# 📁 test_seed_plan.py

import asyncio
from datetime import datetime
from db.core.session import AsyncSessionLocal
from db.models.plan import Plan

async def seed_plan():
    async with AsyncSessionLocal() as session:
        plan = Plan(
            id=1,
            name="🔥 30 روزه VLESS",
            duration_days=30,
            volume_gb=100,
            price=100000,
            description="پلان تستی برای تراکنش",
            is_active=True,
            created_at=datetime.utcnow()
        )
        session.add(plan)
        await session.commit()
        print("✅ Test plan inserted.")

asyncio.run(seed_plan())
