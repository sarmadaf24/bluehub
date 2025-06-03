# 📁 vpn_bot/db/models/protocols/config_v2ray.py

from sqlalchemy import Column, Integer, String, ForeignKey, DateTime, BigInteger
from sqlalchemy.orm import relationship
from sqlalchemy.sql import text
from vpn_bot.db.core.base import Base


class V2RayConfig(Base):
    __tablename__ = "config_v2ray"

    id = Column(BigInteger, primary_key=True)
    config_id = Column(BigInteger, ForeignKey(
        "configs.id", ondelete="CASCADE"), nullable=False)

    # ✅ اینا اضافه شدن تا از ارور خلاص بشیم
    server = Column(String)
    port = Column(Integer)
    uuid = Column(String)
    encryption = Column(String)  # 🧬 فقط برای Shadowsocks، اما گاهی لازمه
    password = Column(String)
    address = Column(String, nullable=False)  # ✅ این خط اگه نیست باید اضافه بشه
    # V2Ray-specific fields
    alter_id = Column(Integer)
    security = Column(String)
    network = Column(String)
    path = Column(String)
    host = Column(String)
    sni = Column(String)
    created_at = Column(DateTime, server_default=text("CURRENT_TIMESTAMP"))
    # 🔁 Relation with Config
    config = relationship("Config", back_populates="v2ray")
