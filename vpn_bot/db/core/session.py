# 📁 vpn_bot/db/core/session.py

import os
from dotenv import load_dotenv
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from sqlalchemy.orm import sessionmaker
from sqlalchemy import create_engine

# بارگذاری .env
load_dotenv()

# گرفتن آدرس دیتابیس
DATABASE_URL = os.getenv("DATABASE_URL")
if not DATABASE_URL:
    raise ValueError("❌ DATABASE_URL not found in .env file.")

# ===============================
# ✅ نسخه Async
# ===============================
engine = create_async_engine(DATABASE_URL, echo=True)

AsyncSessionLocal = sessionmaker(
    bind=engine,
    class_=AsyncSession,
    expire_on_commit=False
)

# ===============================
# ✅ نسخه Sync
# ===============================
sync_engine = create_engine(
    DATABASE_URL.replace("asyncpg", "psycopg2")  # فقط برای PostgreSQL
)

SessionLocal = sessionmaker(
    autocommit=False,
    autoflush=False,
    bind=sync_engine
)

# ⛏ اگر خواستی یک helper هم اضافه کن


def get_sync_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
# ===============================
# ✅ نسخه AsyncSession
# ===============================

from typing import AsyncGenerator
from sqlalchemy.ext.asyncio import AsyncSession

async def get_async_session() -> AsyncGenerator[AsyncSession, None]:
    """
    Dependency for FastAPI routes: yields an AsyncSession and closes it after use.
    """
    async with AsyncSessionLocal() as session:
        try:
            yield session
        finally:
            await session.close()
