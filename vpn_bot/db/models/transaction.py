# 📁 vpn_bot/db/models/transaction.py

from sqlalchemy import Column, Integer, BigInteger, String, ForeignKey, DateTime, func, Index
from vpn_bot.db.core.base import Base
from sqlalchemy.sql import text


class Transaction(Base):
    __tablename__ = "transactions"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(BigInteger, ForeignKey("users.user_id"), nullable=False)
    plan_id = Column(Integer, ForeignKey("plans.id"), nullable=False)

    amount = Column(Integer, nullable=False)
    currency = Column(String, default="IRT")  # IRT, USD, USDT, BTC

    # pending, paid, failed, refunded
    status = Column(String, default="pending")
    # zarinpal, paypal, mock, crypto
    gateway = Column(String, nullable=False)
    reference = Column(String, nullable=True)   # شماره پیگیری یا authority

    type = Column(String, default="buy")  # buy, renew, trial, gift
    created_at = Column(DateTime(timezone=True), server_default=text("CURRENT_TIMESTAMP"))

    __table_args__ = (
        Index("ix_transaction_user_status", "user_id", "status"),
    )