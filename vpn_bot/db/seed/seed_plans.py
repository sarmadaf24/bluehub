# vpn_bot/db/seed/seed_plans.py

import asyncio
from sqlalchemy import text
from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.plan import Plan

PLANS = [
    {"name":"Plan-30-1",      "duration_days":30,  "volume_gb":30,  "price":60000},
    {"name":"Plan-50-1",      "duration_days":30,  "volume_gb":50,  "price":90000},
    {"name":"Plan-80-1",      "duration_days":30,  "volume_gb":80,  "price":130000},
    {"name":"Plan-140-3",     "duration_days":90,  "volume_gb":140, "price":180000},
    {"name":"Plan-220-3",     "duration_days":90,  "volume_gb":220, "price":260000},
    {"name":"Plan-250-6",     "duration_days":180, "volume_gb":250, "price":290000},
    {"name":"Plan-400-6",     "duration_days":180, "volume_gb":400, "price":430000},
    {"name":"Plan-600-12",    "duration_days":365, "volume_gb":600, "price":590000},
    {"name":"Plan-750-12",    "duration_days":365, "volume_gb":750, "price":690000},
    {"name":"Plan-Unlimited", "duration_days":365, "volume_gb":None,"price":0},
]

async def run():
    async with AsyncSessionLocal() as session:
        # 1) پاک‌کردن همه رکوردها و ریست آیدی
        await session.execute(text("TRUNCATE TABLE plans RESTART IDENTITY CASCADE;"))
        # 2) درج به ترتیب
        for p in PLANS:
            plan = Plan(
                name=p["name"],
                duration_days=p["duration_days"],
                volume_gb=p["volume_gb"],
                price=p["price"]
            )
            session.add(plan)
        await session.commit()
        print("✅ Seeded plans 1–10")

if __name__ == "__main__":
    asyncio.run(run())
