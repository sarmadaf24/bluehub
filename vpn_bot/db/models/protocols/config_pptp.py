# 📁 vpn_bot/db/models/protocols/config_pptp.py
# 🔷 models/config_pptp.py

from sqlalchemy import Column, String, BigInteger, ForeignKey, DateTime
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from vpn_bot.db.core.base import Base
from sqlalchemy.sql import text


class PPTPConfig(Base):
    __tablename__ = "config_pptp"

    id = Column(BigInteger, primary_key=True)
    config_id = Column(BigInteger, ForeignKey(
        "configs.id", ondelete="CASCADE"), nullable=False)

    username = Column(String)
    password = Column(String)
    mppe_enabled = Column(String)  # Optional encryption settings
    created_at = Column(DateTime, server_default=text("CURRENT_TIMESTAMP"))

    config = relationship("Config", back_populates="pptp")