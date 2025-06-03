# 📁 test_insert_transaction.py
import asyncio
from db.core.session import AsyncSessionLocal
from db.models.transaction import Transaction
from datetime import datetime

async def insert_tx():
    async with AsyncSessionLocal() as session:
        tx = Transaction(
            user_id=6727220793,
            plan_id=1,
            amount=100000,
            currency="IRT",
            status="pending",
            gateway="nowpayments",
            reference="test-payment-123",
            type="crypto",
            created_at=datetime.utcnow()
        )
        session.add(tx)
        await session.commit()
        print("✅ Test transaction inserted.")

asyncio.run(insert_tx())
