import pytest
from sqlalchemy import delete
from db.models import Order, User, Plan
from db.core.session import AsyncSessionLocal
from vpn_bot.services.order_service import (
    create_order, get_order_by_id, get_user_orders
)

TEST_USER_ID = 88888888
TEST_PLAN_ID = 9999

@pytest.mark.asyncio
async def setup_user_and_plan():
    async with AsyncSessionLocal() as session:
        await session.execute(delete(Order).where(Order.user_id == TEST_USER_ID))
        await session.execute(delete(User).where(User.user_id == TEST_USER_ID))
        await session.execute(delete(Plan).where(Plan.id == TEST_PLAN_ID))

        user = User(user_id=TEST_USER_ID, username="test_user")
        plan = Plan(id=TEST_PLAN_ID, name="تست", duration_days=30, price=10000, volume_gb=10)

        session.add_all([user, plan])
        await session.commit()

@pytest.mark.asyncio
async def test_create_order():
    await setup_user_and_plan()
    order = await create_order(TEST_USER_ID, TEST_PLAN_ID, is_manual=True)
    assert order.user_id == TEST_USER_ID
    assert order.plan_id == TEST_PLAN_ID

@pytest.mark.asyncio
async def test_get_order_by_id():
    await setup_user_and_plan()
    new_order = await create_order(TEST_USER_ID, TEST_PLAN_ID)
    fetched_order = await get_order_by_id(new_order.id)
    assert fetched_order is not None
    assert fetched_order.id == new_order.id

@pytest.mark.asyncio
async def test_get_user_orders():
    await setup_user_and_plan()
    await create_order(TEST_USER_ID, TEST_PLAN_ID)
    orders = await get_user_orders(TEST_USER_ID)
    assert isinstance(orders, list)
    assert all(order.user_id == TEST_USER_ID for order in orders)
