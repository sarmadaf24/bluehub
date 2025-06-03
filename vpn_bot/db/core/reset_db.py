# 📁 vpn_bot/db/core/reset_db.py

import asyncio
from vpn_bot.db.core.session import engine
from vpn_bot.db.core.base import Base


async def drop_and_create():
    async with engine.begin() as conn:
        print("⚠️ Dropping all tables...")
        await conn.run_sync(Base.metadata.drop_all)
        print("✅ Dropped.")
        print("🛠️ Creating all tables...")
        await conn.run_sync(Base.metadata.create_all)
        print("✅ Created.")

if __name__ == "__main__":
    asyncio.run(drop_and_create())
