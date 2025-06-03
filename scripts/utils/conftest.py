import pytest
from aiogram import Bot, Dispatcher
from aiogram.fsm.storage.memory import MemoryStorage
from unittest.mock import AsyncMock
from aiogram.types import Message, User, Chat

@pytest.fixture
def bot():
    bot = AsyncMock(Bot)
    bot.id = 123456
    bot.username = "test_bot"
    return bot

@pytest.fixture
def dispatcher():
    dp = Dispatcher(storage=MemoryStorage())
    return dp

@pytest.fixture
def mocked_user():
    return User(id=99999999, is_bot=False, first_name="Test", language_code="en")

@pytest.fixture
def mocked_chat():
    return Chat(id=99999999, type="private")

@pytest.fixture
def mocked_message(mocked_user, mocked_chat):
    def _factory(text="/start"):
        msg = AsyncMock(spec=Message)
        msg.text = text
        msg.from_user = mocked_user
        msg.chat = mocked_chat
        msg.message_id = 1
        msg.date = None
        return msg
    return _factory
