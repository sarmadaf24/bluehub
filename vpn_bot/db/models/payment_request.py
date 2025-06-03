#vpn_bot/db/models/payment_request.py

from sqlalchemy import Column, BigInteger, Integer, String, DateTime, text, ForeignKey
from vpn_bot.db.core.base import Base

class PaymentRequest(Base):
    __tablename__ = "payment_requests"

    id         = Column(BigInteger, primary_key=True)
    user_id    = Column(BigInteger, ForeignKey("users.user_id"), nullable=False)
    plan_id    = Column(Integer, ForeignKey("plans.id"), nullable=False)
    amount     = Column(Integer, nullable=False)
    currency   = Column(String, nullable=False)
    gateway    = Column(String, nullable=False, comment="zarinpal/paypal/crypto")
    status     = Column(String, nullable=False, server_default="pending", comment="pending/paid/failed")
    created_at = Column(DateTime(timezone=True), nullable=False, server_default=text("CURRENT_TIMESTAMP"))
