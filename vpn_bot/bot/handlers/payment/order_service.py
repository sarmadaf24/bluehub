# 📁 vpn_bot/services/payment/order_service.py

# vpn_bot/services/payment/order_service.py

from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.order import Order
from vpn_bot.db.models.transaction import Transaction

async def create_order_and_transaction(
    user_id: int,
    plan_id: int | None = None,
    *,
    deposit_amount: int | None = None,
    trial_days: int | None = None,
    trial_volume: int | None = None,
    gateway: str,
    currency: str,
    amount: int,
    txn_type: str  # "deposit" یا "trial"
) -> tuple[Order, Transaction]:
    """
    یک Order و یک Transaction جدید می‌سازد و در دیتابیس ذخیره می‌کند.
    """
    async with AsyncSessionLocal() as sess:
        # ۱) Order
        order = Order(
            user_id=user_id,
            plan_id=plan_id or 0,
            deposit_amount=deposit_amount,
            trial_days=trial_days,
            trial_volume=trial_volume,
            status="pending",
            is_manual=False,
            description=None
        )
        sess.add(order)
        await sess.flush()  # تا order.id مقدار بگیرد

        # ۲) Transaction
        txn = Transaction(
            user_id=user_id,
            plan_id=plan_id or 0,
            amount=amount,
            currency=currency,
            status="pending",
            gateway=gateway,
            type=txn_type,
            reference=None
        )
        sess.add(txn)

        await sess.commit()
        return order, txn
