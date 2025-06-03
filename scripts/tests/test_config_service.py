import pytest
from vpn_bot.services.config_service import get_user_config_message
from db.core.session import AsyncSessionLocal
from db.models import Config, User

TEST_USER_ID = 123456789

@pytest.mark.asyncio
async def test_get_user_config_message_with_config():
    async with AsyncSessionLocal() as session:
        user = User(user_id=TEST_USER_ID, username="tester", lang="fa")
        config = Config(
            user_id=TEST_USER_ID,
            server="test.server",
            port=443,
            uuid="test-uuid",
            protocol="vless",
        )
        session.add_all([user, config])
        await session.commit()

    msg = await get_user_config_message(TEST_USER_ID, "fa")
    assert "test.server" in msg and "vless" in msg

@pytest.mark.asyncio
async def test_get_user_config_message_without_config():
    async with AsyncSessionLocal() as session:
        await session.execute(Config.__table__.delete().where(Config.user_id == TEST_USER_ID))
        await session.execute(User.__table__.delete().where(User.user_id == TEST_USER_ID))
        await session.commit()

    msg = await get_user_config_message(TEST_USER_ID, "fa")
    assert msg == "⛔️ پیکربندی یافت نشد"  # یا متن واقعی ترجمه‌شده
