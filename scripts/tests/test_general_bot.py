import pytest
from unittest.mock import AsyncMock
from aiogram.types import Message, CallbackQuery
from aiogram.fsm.context import FSMContext

# هندلرها
from vpn_bot.bot.handlers.common.start import start_command
from vpn_bot.bot.handlers.help import help_command
from vpn_bot.bot.handlers.callbacks import handle_buy_callback  # یا هر کال‌بکی که استفاده می‌کنی


@pytest.mark.asyncio
async def test_start_handler():
    message = AsyncMock(spec=Message)
    message.text = "/start"
    message.from_user.id = 123
    state = AsyncMock(spec=FSMContext)

    await start_command(message, state)

    message.answer.assert_called_once()
    args, _ = message.answer.call_args
    assert "خوش" in args[0] or "welcome" in args[0].lower()


@pytest.mark.asyncio
async def test_help_handler():
    message = AsyncMock(spec=Message)
    message.text = "/help"
    message.from_user.id = 123

    await help_command(message)

    message.answer.assert_called_once()
    args, _ = message.answer.call_args
    assert "راهنما" in args[0] or "help" in args[0].lower()


@pytest.mark.asyncio
async def test_callback_buy():
    callback = AsyncMock(spec=CallbackQuery)
    callback.data = "buy"
    callback.from_user.id = 123

    await handle_buy_callback(callback)

    callback.answer.assert_called_once()
    args, _ = callback.answer.call_args
    assert "خرید" in args[0] or "buy" in args[0].lower()
