import os
from aiogram import types
from vpn_bot.bot_instance import dp

ADMIN_IDS = [int(x) for x in os.getenv("ADMIN_IDS", "").split(",") if x]

@dp.message_handler(commands=["start"])
async def cmd_start(message: types.Message):
    user_id = message.from_user.id
    if user_id in ADMIN_IDS:
        await message.reply("بات آماده به‌کار است.")
    else:
        await message.reply("شما دسترسی ادمین ندارید.")
