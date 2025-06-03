# 📁 scripts/seed_user.py
import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

import asyncio
from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.user import User

async def seed_user():
    async with AsyncSessionLocal() as session:
        user = User(
            user_id=123456789,
            full_name="Test User",
            username="testuser"
        )
        session.add(user)
        await session.commit()
        print("✅ User inserted!")

if __name__ == "__main__":
    asyncio.run(seed_user())
