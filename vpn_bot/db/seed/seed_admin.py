# 📁 vpn_bot/db/seed/seed_admin.py

import os
from dotenv import load_dotenv
from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.user import User

load_dotenv()

def get_admins():
    admin_ids = os.getenv("ADMINS", "")
    return [
        {
            "user_id": int(admin_id.strip()),
            "first_name": "Admin",
            "last_name": "User",
            "username": f"admin{admin_id.strip()}",
            "language_code": "fa"
        }
        for admin_id in admin_ids.split(",") if admin_id.strip()
    ]

async def run(user_id=None):
    async with AsyncSessionLocal() as session:
        admins = get_admins()
        if user_id:
            admins = [admin for admin in admins if admin["user_id"] == user_id]
        for admin in admins:
            user = await session.get(User, admin["user_id"])
            if user:
                user.role = "admin"
                user.language_code = admin["language_code"]
                print(f"🔁 ادمین موجود به‌روز شد: {user.user_id}")
            else:
                new_admin = User(
                    user_id=admin["user_id"],
                    first_name=admin["first_name"],
                    last_name=admin["last_name"],
                    username=admin["username"],
                    language_code=admin["language_code"],
                    is_blocked=False,
                    is_premium=True,
                    role="admin"
                )
                session.add(new_admin)
                print(f"✅ ادمین جدید ساخته شد: {admin['user_id']}")
        await session.commit()