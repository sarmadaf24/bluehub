# tests/test_handlers/test_start.py

import pytest
from unittest.mock import AsyncMock
from aiogram.types import User, Chat, Message
from vpn_bot.bot.handlers.common.start import start_command


@pytest.mark.asyncio
async def test_start_command_sends_welcome_message():
    # ساخت user mock شده
    fake_user = User(id=123, is_bot=False, first_name="Ali", username="ali_dev")
    
    # ساخت chat mock شده
    fake_chat = Chat(id=123, type="private")
    
    # ساخت پیام mock شده
    message = AsyncMock(spec=Message)
    message.from_user = fake_user
    message.chat = fake_chat
    message.text = "/start"

    await start_command(message)

    # بررسی اینکه پیام خوش‌آمدی فرستاده شده
    message.answer.assert_called_once_with("🎉 خوش اومدی!")
