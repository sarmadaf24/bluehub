
# 📁 vpn_bot/db/models/ticket.py

from sqlalchemy import Column, BigInteger, String, ForeignKey, DateTime, func, Index, Integer, ForeignKey
from sqlalchemy.sql import text
from vpn_bot.db.core.base import Base


class Ticket(Base):
    __tablename__ = "tickets"

    ticket_id = Column(Integer, primary_key=True,
                       index=True)  # ✅ این باید باشه
    user_id = Column(BigInteger, ForeignKey("users.user_id"),
                     nullable=False)   # ✅ این باید باشه
    message = Column(String, nullable=False)
    response = Column(String, nullable=True)
    status = Column(String, default="open")  # open, closed, pending
    created_at = Column(DateTime(timezone=True), server_default=text("CURRENT_TIMESTAMP"))
    answered_at = Column(DateTime(timezone=True), nullable=True)

    # ایندکس برای سرعت گرفتن در جستجوی تیکت‌ها
    __table_args__ = (
        Index("ix_ticket_user_status", "user_id", "status"),
    )