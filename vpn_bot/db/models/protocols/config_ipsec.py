
# 📁 vpn_bot/db/models/protocols/config_ipsec.py
# 🔷 models/config_ipsec.py

from sqlalchemy import Column, String, BigInteger, ForeignKey, DateTime
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from vpn_bot.db.core.base import Base
from sqlalchemy.sql import text

class IPSecConfig(Base):
    __tablename__ = "config_ipsec"

    id = Column(BigInteger, primary_key=True)
    config_id = Column(BigInteger, ForeignKey(
        "configs.id", ondelete="CASCADE"), nullable=False)

    ike_version = Column(String)
    username = Column(String)
    password = Column(String)
    psk = Column(String)
    created_at = Column(DateTime, server_default=text("CURRENT_TIMESTAMP"))

    config = relationship("Config", back_populates="ipsec")