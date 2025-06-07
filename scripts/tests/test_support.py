import pytest
from unittest.mock import AsyncMock
from aiogram.types import Message, User
from aiogram.fsm.context import FSMContext

from vpn_bot.bot.handlers.support import support as support_module


@pytest.mark.asyncio
async def test_forward_initial_message(monkeypatch):
    state = AsyncMock(spec=FSMContext)
    state.get_data = AsyncMock(return_value={"topic": "test"})
    state.update_data = AsyncMock()
    state.set_state = AsyncMock()

    message = AsyncMock(spec=Message)
    message.text = "description"
    message.from_user = User(id=123, is_bot=False, first_name="u")

    send_mock = AsyncMock()
    monkeypatch.setattr(support_module, "bot", AsyncMock(send_message=send_mock))
    monkeypatch.setattr(support_module, "ADMIN_IDS", [99])

    await support_module.support_receive_description(message, state)

    send_mock.assert_awaited()
    assert "test" in send_mock.call_args.args[1]


@pytest.mark.asyncio
async def test_admin_reply(monkeypatch):
    message = AsyncMock(spec=Message)
    message.text = "123#ok"
    message.from_user = User(id=99, is_bot=False, first_name="admin")
    message.bot = AsyncMock()

    monkeypatch.setattr(support_module, "ADMIN_IDS", [99])

    await support_module.admin_live_chat_handler(message)

    message.bot.send_message.assert_awaited_with(123, "[پاسخ ادمین]: ok")
