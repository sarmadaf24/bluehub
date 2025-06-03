# 📁 vpn_bot/bot/handlers/admin/admin.py

from aiogram import Router
from aiogram.types import Message
from aiogram.filters import Command
from vpn_bot.db.models.user import User
from vpn_bot.db.core.session import AsyncSessionLocal
from sqlalchemy import select
from vpn_bot.utils.i18n import t

router = Router()
print("📦 admin.py router loaded ✅")


@router.message(Command("addadmin"))
async def add_admin(message: Message):
    async with AsyncSessionLocal() as session:
        user_result = await session.execute(
            select(User).where(User.user_id == message.from_user.id)
        )
        user = user_result.scalars().first()

        lang = user.lang if user else "fa"

        if user and user.role == "admin":
            if message.reply_to_message:
                target_id = message.reply_to_message.from_user.id
                target_result = await session.execute(
                    select(User).where(User.user_id == target_id)
                )
                target = target_result.scalars().first()

                if target:
                    target.role = "admin"
                    await session.commit()
                    await message.answer(t("admin_added", lang))
                else:
                    await message.answer(t("user_not_found", lang))
            else:
                await message.answer(t("reply_to_user_required", lang))
        else:
            await message.answer(t("no_access", lang))
