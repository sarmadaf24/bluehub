# 📁 vpn_bot/services/user_service.py

from sqlalchemy import select
from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.user import User
import logging
from typing import List
from vpn_bot.db.models.plan import Plan   # ← مدل اشتراک
logger = logging.getLogger(__name__)

# ✅ ایجاد یا بروزرسانی کاربر


async def upsert_user(user_id: int, username: str = None, lang: str = None):
    async with AsyncSessionLocal() as session:
        result = await session.execute(select(User).where(User.user_id == user_id))
        user = result.scalar_one_or_none()

        if user:
            if username:
                user.username = username
            if lang:
                user.lang = lang
            logger.info(f"[UPDATE] User {user_id} updated.")
        else:
            user = User(user_id=user_id, username=username, lang=lang or "fa")
            session.add(user)
            logger.info(f"[INSERT] New user {user_id} added.")

        await session.commit()
        return user


# ✅ گرفتن کاربر
async def get_user_by_id(user_id: int) -> User | None:
    async with AsyncSessionLocal() as session:
        return await session.get(User, user_id)


# ✅ چک کردن اینکه یوزر ادمینه یا نه
async def is_admin(user_id: int) -> bool:
    user = await get_user_by_id(user_id)
    return user is not None and user.role == "admin"


# ✅ تغییر زبان کاربر
async def set_user_lang(user_id: int, lang: str):
    async with AsyncSessionLocal() as session:
        user = await session.get(User, user_id)
        if user:
            user.lang = lang
            await session.commit()
            logger.info(f"[LANG] Language for user {user_id} set to {lang}")


from sqlalchemy import select
from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.user import User
from vpn_bot.db.models.config import Config  # اضافه می‌کنیم
from datetime import datetime
import logging

logger = logging.getLogger(__name__)

# … توابع upsert_user, get_user_by_id، is_admin و set_user_lang


async def get_user_subscriptions(user_id: int) -> List[Plan]:
    """
    برمی‌گرداند لیست اشتراک‌های فعال کاربر.
    """
    async with AsyncSessionLocal() as session:
        result = await session.execute(
            select(Plan).where(Plan.user_id == user_id)
        )
        return result.scalars().all()


