from sqlalchemy import Column, Integer, BigInteger, String, Text, DateTime, ForeignKey, func
from sqlalchemy.orm import relationship
from vpn_bot.db.core.base import Base

class SupportTicket(Base):
    __tablename__ = "support_tickets"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(BigInteger, nullable=False, index=True)
    username   = Column(String,     nullable=True) 
    status = Column(String(20), default="open", nullable=False, index=True)
    created_at = Column(
        DateTime,
        nullable=False,
        server_default=func.now()
    )
    agent_id = Column(
        Integer,
        ForeignKey("support_agents.id", ondelete="SET NULL"),
        nullable=True,
        index=True
    )

    # ← ستونِ سوال اصلی (در صورتی که می‌خواهیم جداگانه ذخیره‌اش کنیم)
    question = Column(
        Text,
        nullable=False,
        default="",
        server_default=text("''")
    )

    # 🔗 رابطه با پیام‌ها و با کارشناس
    messages = relationship(
        "SupportMessage",
        back_populates="ticket",
        cascade="all, delete-orphan"
    )
    agent = relationship(
        "SupportAgent",
        back_populates="tickets"
    )
