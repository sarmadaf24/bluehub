
# 📁 vpn_bot/db/models/protocols/config_ikev2.py
# 🔷 models/config_ikev2.py

from sqlalchemy import Column, String, BigInteger, ForeignKey, DateTime
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from vpn_bot.db.core.base import Base
from sqlalchemy.sql import text

class IKEv2Config(Base):
    __tablename__ = "config_ikev2"

    id = Column(BigInteger, primary_key=True)
    config_id = Column(BigInteger, ForeignKey(
        "configs.id", ondelete="CASCADE"), nullable=False)

    username = Column(String)
    password = Column(String)
    certificate = Column(String)
    private_key = Column(String)
    created_at = Column(DateTime, server_default=text("CURRENT_TIMESTAMP"))

    config = relationship("Config", back_populates="ikev2")