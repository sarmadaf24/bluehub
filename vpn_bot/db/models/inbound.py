# 📁 vpn_bot/db/models/inbound.py

from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship, Mapped
from typing import List
from vpn_bot.db.core.base import Base


class Inbound(Base):
    __tablename__ = "inbounds"

    id = Column(Integer, primary_key=True)
    server = Column(String, nullable=False)
    port = Column(Integer, nullable=False)
    protocol = Column(String, nullable=False)
    network = Column(String, nullable=True)  # مثال: tcp, ws
    path = Column(String, nullable=True)     # برای ws یا h2
    host = Column(String, nullable=True)     # برای SNI یا Host header
    sni = Column(String, nullable=True)      # برای TLS handshake
    # 🧬 فقط برای Shadowsocks
    encryption = Column(String, nullable=True)  # مثال: 2022-blake3-aes-256-gcm
    password = Column(String, nullable=True)    # رمزگذاری‌شده


