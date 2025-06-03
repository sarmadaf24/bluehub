# 📁 vpn_bot/services/order_service.py

from sqlalchemy import select
from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.order import Order
import logging
from typing import Optional

logger = logging.getLogger(__name__)


# ✅ ایجاد سفارش جدید
async def create_order(user_id: int, plan_id: int, is_manual: bool = False) -> Order:
    async with AsyncSessionLocal() as session:
        order = Order(user_id=user_id, plan_id=plan_id, is_manual=is_manual)
        session.add(order)
        await session.commit()
        await session.refresh(order)
        logger.info(f"[ORDER CREATED] user={user_id} plan={plan_id}")
        return order


# ✅ دریافت سفارش با ID
async def get_order_by_id(order_id: int) -> Optional[Order]:
    async with AsyncSessionLocal() as session:
        return await session.get(Order, order_id)


# ✅ دریافت همه سفارش‌های یک کاربر
async def get_user_orders(user_id: int) -> list[Order]:
    async with AsyncSessionLocal() as session:
        result = await session.execute(
            select(Order).where(Order.user_id == user_id)
        )
        return result.scalars().all()


# ✅ حذف سفارش (مثلاً توسط ادمین یا لغو)
async def delete_order(order_id: int) -> bool:
    async with AsyncSessionLocal() as session:
        order = await session.get(Order, order_id)
        if not order:
            return False
        await session.delete(order)
        await session.commit()
        logger.info(f"[ORDER DELETED] id={order_id}")
        return True

from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.transaction import Transaction
from datetime import datetime
from vpn_bot.services.panel_service import get_plan_by_id  # ✅ اضافه شد
import logging

logger = logging.getLogger("order-service")

async def save_card_receipt(user_id: int, plan_id: int, file_id: str, file_type: str, v2ray_type: str):
    async with AsyncSessionLocal() as session:
        # ⛏ گرفتن پلن برای استخراج مبلغ
        plan = await get_plan_by_id(plan_id)
        if not plan:
            logger.error(f"❌ Plan ID {plan_id} not found while saving receipt.")
            return

        transaction = Transaction(
            user_id=user_id,
            plan_id=plan_id,
            amount=plan.price,  # ✅ مقدار موردنیاز
            currency="toman",
            status="waiting",
            gateway="manual",
            reference=file_id,
            type=v2ray_type,
            created_at=datetime.utcnow()
        )

        session.add(transaction)
        await session.commit()
        logger.info(f"🧾 [RECEIPT SAVED] user_id={user_id} plan_id={plan_id} amount={plan.price}")
