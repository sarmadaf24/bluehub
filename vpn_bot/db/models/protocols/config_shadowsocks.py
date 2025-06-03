# 📁 vpn_bot/db/models/protocols/config_shadowsocks.py

from sqlalchemy import Column, Integer, String, ForeignKey, DateTime
from datetime import datetime
from vpn_bot.db.core.base import Base

class ShadowsocksConfig(Base):
    __tablename__ = "config_shadowsocks"

    id = Column(Integer, primary_key=True)
    config_id = Column(Integer, ForeignKey("configs.id"))
    address = Column(String, nullable=False)
    port = Column(Integer, nullable=False)
    encryption = Column(String, nullable=False)
    password = Column(String, nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow)

