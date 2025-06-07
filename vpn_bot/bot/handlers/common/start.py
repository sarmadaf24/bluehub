from aiogram import Router
from aiogram.filters import Command
from aiogram.types import Message
from aiogram.fsm.context import FSMContext

from config import ADMIN_IDS

router = Router()


@router.message(Command("start"))
async def start_command(message: Message, state: FSMContext) -> None:
    """Simple /start handler using Aiogram v3."""
    user_id = message.from_user.id
    if user_id in ADMIN_IDS:
        await message.answer("بات آماده به‌کار است.")
    else:
        await message.answer("شما دسترسی ادمین ندارید.")

# سازگاری با نسخه‌های قدیمی‌تر
cmd_start = start_command
