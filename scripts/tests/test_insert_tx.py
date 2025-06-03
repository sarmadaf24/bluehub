# 📁 test_insert_tx.py
import asyncio
from datetime import datetime
from db.core.session import AsyncSessionLocal
from db.models.transaction import Transaction

async def seed_tx():
    async with AsyncSessionLocal() as session:
        tx = Transaction(
            user_id=6727220793,
            plan_id=1,
            amount=100000,
            currency="IRT",
            status="pending",
            gateway="nowpayments",
            reference="manual-test-001",
            type="crypto",
            created_at=datetime.utcnow()
        )
        session.add(tx)
        await session.commit()
        print("✅ Test transaction added.")

asyncio.run(seed_tx())
