from sqlalchemy import Column, Integer, Text, DateTime, ForeignKey, text
from sqlalchemy.orm import relationship
from vpn_bot.db.core.base import Base

class SupportMessage(Base):
    __tablename__ = "support_messages"

    id         = Column(Integer, primary_key=True)
    ticket_id  = Column(Integer, ForeignKey("support_tickets.id", ondelete="CASCADE"), nullable=False)
    from_user  = Column(String(5), nullable=False)  # "user" یا "admin"
    content    = Column(Text, nullable=False)
    timestamp  = Column(DateTime, server_default=text("now()"), nullable=False)

    ticket     = relationship("SupportTicket", back_populates="messages")
