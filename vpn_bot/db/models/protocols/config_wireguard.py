# 📁 vpn_bot/db/models/protocols/config_wireguard.py
# 🔷 models/config_wireguard.py

from sqlalchemy import Column, String, BigInteger, ForeignKey, DateTime
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from vpn_bot.db.core.base import Base
from sqlalchemy.sql import text


class WireGuardConfig(Base):
    __tablename__ = "config_wireguard"

    id = Column(BigInteger, primary_key=True)
    config_id = Column(BigInteger, ForeignKey(
        "configs.id", ondelete="CASCADE"), nullable=False)

    private_key = Column(String)
    public_key = Column(String)
    preshared_key = Column(String)
    endpoint = Column(String)
    allowed_ips = Column(String)
    created_at = Column(DateTime, server_default=text("CURRENT_TIMESTAMP"))

    config = relationship("Config", back_populates="wireguard")