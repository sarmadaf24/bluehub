# 📁 vpn_bot/db/models/order.py

from sqlalchemy import Column, BigInteger, String, ForeignKey, DateTime, Boolean, Integer, text, Index
from vpn_bot.db.core.base import Base

class Order(Base):
    __tablename__ = "orders"

    id             = Column(Integer, primary_key=True, index=True)
    user_id        = Column(BigInteger, ForeignKey("users.user_id"), nullable=False, index=True)
    plan_id        = Column(Integer, ForeignKey("plans.id"), nullable=False, index=True)

    status         = Column(String, default="pending")   # pending, paid, failed, canceled
    is_manual      = Column(Boolean, default=False)

    # ← این‌ها فیلدهای جدید
    deposit_amount = Column(Integer, nullable=True, comment="مبلغ ودیعه/پیش‌پرداخت (تومان/دلار)")
    trial_days     = Column(Integer, nullable=True, comment="مدت تریال (روز)")
    trial_volume   = Column(Integer, nullable=True, comment="حجم تریال (بایت)")

    created_at     = Column(DateTime(timezone=True), server_default=text("CURRENT_TIMESTAMP"))
    description    = Column(String, nullable=True)

    __table_args__ = (
        Index("ix_order_user_plan", "user_id", "plan_id"),
    )
