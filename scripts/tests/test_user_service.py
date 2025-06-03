# tests/test_user_service.py

import pytest
from vpn_bot.services.user_service import upsert_user
from db.core.session import AsyncSessionLocal
from db.models.user import User

TEST_USER_ID = 99999999

@pytest.mark.asyncio
async def test_upsert_user_create():
    await upsert_user(TEST_USER_ID, username="tester", lang="fa")

    async with AsyncSessionLocal() as session:
        user = await session.get(User, TEST_USER_ID)
        assert user is not None
        assert user.username == "tester"
        assert user.lang == "fa"

@pytest.mark.asyncio
async def test_upsert_user_update():
    await upsert_user(TEST_USER_ID, username="old", lang="fa")
    await upsert_user(TEST_USER_ID, username="updated", lang="en")

    async with AsyncSessionLocal() as session:
        user = await session.get(User, TEST_USER_ID)
        assert user.username == "updated"
        assert user.lang == "en"
