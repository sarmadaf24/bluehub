import pytest
from unittest.mock import AsyncMock
from aiogram.types import Message, User
from vpn_bot.bot.handlers.common import start as start_module


@pytest.mark.asyncio
async def test_start_for_admin(monkeypatch):
    monkeypatch.setattr(start_module, "ADMIN_IDS", [42])
    message = AsyncMock(spec=Message)
    message.from_user = User(id=42, is_bot=False, first_name="Admin")

    await start_module.start_command(message, AsyncMock())

    message.answer.assert_called_once_with("بات آماده به‌کار است.")


@pytest.mark.asyncio
async def test_start_for_non_admin(monkeypatch):
    monkeypatch.setattr(start_module, "ADMIN_IDS", [42])
    message = AsyncMock(spec=Message)
    message.from_user = User(id=7, is_bot=False, first_name="User")

    await start_module.start_command(message, AsyncMock())

    message.answer.assert_called_once_with("شما دسترسی ادمین ندارید.")
