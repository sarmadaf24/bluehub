import pytest
from vpn_bot.services.plan_service import (
    get_all_plans,
    get_plan_by_id,
    plan_exists
)
from db.models import Plan
from db.core.session import AsyncSessionLocal

TEST_PLAN = {
    "name": "تست پلن ۷ روزه",
    "duration_days": 7,
    "volume_gb": 5,
    "price": 10000
}


@pytest.mark.asyncio
async def test_get_all_plans():
    plans = await get_all_plans()
    assert isinstance(plans, list)


@pytest.mark.asyncio
async def test_get_plan_by_id():
    # ابتدا پلن تستی رو ایجاد می‌کنیم
    async with AsyncSessionLocal() as session:
        plan = Plan(**TEST_PLAN)
        session.add(plan)
        await session.commit()
        await session.refresh(plan)

        # تست: بازیابی با ID
        fetched = await get_plan_by_id(plan.id)
        assert fetched is not None
        assert fetched.name == TEST_PLAN["name"]

        # پاک‌سازی
        await session.delete(plan)
        await session.commit()


@pytest.mark.asyncio
async def test_plan_exists():
    async with AsyncSessionLocal() as session:
        plan = Plan(**TEST_PLAN)
        session.add(plan)
        await session.commit()
        await session.refresh(plan)

        exists = await plan_exists(TEST_PLAN["name"])
        assert exists is True

        not_exists = await plan_exists("پلن خیالی")
        assert not_exists is False

        # پاک‌سازی
        await session.delete(plan)
        await session.commit()
