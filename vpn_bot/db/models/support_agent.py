# File: vpn_bot/db/models/support_agent.py

from sqlalchemy import Column, Integer, BigInteger, Boolean, DateTime, func
from sqlalchemy.orm import relationship
from vpn_bot.db.core.base import Base

class SupportAgent(Base):
    __tablename__ = "support_agents"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(BigInteger, nullable=False, unique=True, index=True)
    is_active = Column(Boolean, default=True, nullable=False)
    last_assigned_at = Column(
        DateTime,
        nullable=False,
        server_default=func.now()
    )

    # 🔗 رابطه با تیکت‌ها
    tickets = relationship(
        "SupportTicket",
        back_populates="agent",
        cascade="all, delete-orphan"
    )
