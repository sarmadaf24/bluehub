# 📁 test_seed_transaction.py

import asyncio
from datetime import datetime
from db.models.transaction import Transaction
from db.core.session import AsyncSessionLocal

async def seed_pending_transaction():
    async with AsyncSessionLocal() as session:
        tx = Transaction(
            user_id=6727220793,
            plan_id=5,  # مطمئن شو plan_id واقعی باشه
            amount=100000,
            currency="IRT",
            status="pending",
            gateway="nowpayments",
            reference="test-ref-123",
            type="buy",
            created_at=datetime.utcnow()
        )
        session.add(tx)
        await session.commit()
        print("✅ Test transaction inserted.")

asyncio.run(seed_pending_transaction())
