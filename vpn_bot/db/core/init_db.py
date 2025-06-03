# 📁 vpn_bot/db/core/init_db.py

from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from sqlalchemy.orm import sessionmaker
from config import DATABASE_URL
from .base import Base
from .protocols.config_v2ray import V2RayConfig
from .config import Config
# تضمین ایمپورت مدل‌ها

# ایجاد Async Engine
async_engine = create_async_engine(DATABASE_URL, echo=True)

# ساخت Session Factory
AsyncSessionLocal = sessionmaker(
    bind=async_engine,
    class_=AsyncSession,
    expire_on_commit=False
)

# تابع ساخت جداول دیتابیس


async def init_db():
    async with async_engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)
    print("✅ Tables created successfully.")

    await async_engine.dispose()  # اختیاری ولی تمیزکننده

    return AsyncSessionLocal


# اجرای مستقیم (برای تست و dev)
if __name__ == "__main__":
    import asyncio
    asyncio.run(init_db())
