# File: vpn_bot/db/models/support.py

from sqlalchemy import Column, Integer, BigInteger, String, Text, DateTime, ForeignKey, Boolean, text
from sqlalchemy.orm import relationship
from vpn_bot.db.core.base import Base  # مسیر ممکن است در پروژه‌تان متفاوت باشد

class SupportAgent(Base):
    __tablename__ = "support_agents"

    id = Column(Integer, primary_key=True)
    is_active = Column(Boolean, default=True, nullable=False)
    last_assigned_at = Column(
        DateTime,
        server_default=text("now()"),
        nullable=False
    )

class SupportTicket(Base):
    __tablename__ = "support_tickets"

    id = Column(Integer, primary_key=True)
    user_id = Column(BigInteger, nullable=False)
    sender_id  = Column(BigInteger, nullable=False)
    status = Column(String(20), default="open", nullable=False)
    created_at = Column(
        DateTime,
        server_default=text("now()"),
        nullable=False
    )
    agent_id = Column(Integer, ForeignKey("support_agents.id"), nullable=True)

    # ← ستونِ question
    question = Column(
        Text,
        nullable=False,
        server_default=text("''")  # فقط برای همسان‌سازی existing rows
    )

    # رابطه به پیام‌ها
    messages = relationship(
        "SupportMessage",
        back_populates="ticket",
        cascade="all, delete-orphan"
    )

class SupportMessage(Base):
    __tablename__ = "support_messages"

    id = Column(Integer, primary_key=True)
    user_id = Column(BigInteger, unique=True, nullable=False)
    ticket_id = Column(
        Integer,
        ForeignKey("support_tickets.id", ondelete="CASCADE"),
        nullable=False
    )
    from_user = Column(String(5), nullable=False)  # "user" یا "admin"
    content = Column(Text, nullable=False)
    timestamp = Column(
        DateTime,
        server_default=text("now()"),
        nullable=False
    )

    # رابطه به تیکت
    ticket = relationship("SupportTicket", back_populates="messages")
