import pytest
from unittest.mock import AsyncMock
from vpn_bot.bot.startup import notify_admins

@pytest.mark.asyncio
async def test_notify_admins(monkeypatch):
    bot = AsyncMock()
    monkeypatch.setattr("vpn_bot.bot.startup.ADMIN_IDS", [123])
    await notify_admins(bot)
    bot.send_message.assert_awaited_with(chat_id=123, text="✅ تست اتصال به ادمین موفق بود.")
