
# 📁 vpn_bot/db/models/protocols/config_l2tp.py
# 🔷 models/config_l2tp.py

from sqlalchemy import Column, String, BigInteger, ForeignKey, DateTime
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from vpn_bot.db.core.base import Base
from sqlalchemy.sql import text

class L2TPConfig(Base):
    __tablename__ = "config_l2tp"

    id = Column(BigInteger, primary_key=True)
    config_id = Column(BigInteger, ForeignKey(
        "configs.id", ondelete="CASCADE"), nullable=False)

    username = Column(String)
    password = Column(String)
    shared_secret = Column(String)
    created_at = Column(DateTime, server_default=text("CURRENT_TIMESTAMP"))

    config = relationship("Config", back_populates="l2tp")