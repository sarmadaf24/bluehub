# 📁 vpn_bot/db/models/email_token.py

from sqlalchemy import (
    Column, String, BigInteger, DateTime, Boolean, ForeignKey, text
)
from sqlalchemy.orm import relationship
from vpn_bot.db.core.base import Base

class EmailToken(Base):
    __tablename__ = "email_tokens"

    id = Column(
        String,
        primary_key=True,
        nullable=False,
        comment="UUID for this token"
    )
    user_id = Column(
        BigInteger,                         # ← حتما BigInteger
        ForeignKey("users.user_id", ondelete="CASCADE"),
        nullable=False,
        index=True,
        comment="Reference to users.user_id"
    )
    token = Column(
        String,
        nullable=False,
        unique=True,
        comment="Signed token"
    )
    created_at = Column(
        DateTime(timezone=True),
        server_default=text("CURRENT_TIMESTAMP"),
        nullable=False
    )
    used = Column(
        Boolean,
        server_default=text("false"),
        nullable=False
    )

    user = relationship("User", back_populates="email_tokens")
