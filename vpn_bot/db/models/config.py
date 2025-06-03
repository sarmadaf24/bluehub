# 📁 vpn_bot/db/models/config.py

from vpn_bot.db.models.protocols.config_v2ray import V2RayConfig
from sqlalchemy import Column, Integer, BigInteger, String, DateTime, Boolean, ForeignKey, text
from vpn_bot.db.core.base import Base
from sqlalchemy.orm import relationship
from sqlalchemy.sql import text
from sqlalchemy import Interval
from sqlalchemy.dialects.postgresql import JSONB

class Config(Base):
    __tablename__ = "configs"

    id = Column(BigInteger, primary_key=True)
    user_id = Column(BigInteger, ForeignKey(
        "users.user_id"))  # ✅ همین خط حیاتیه

    protocol = Column(String, nullable=False)
    name = Column(String)
    created_at = Column(DateTime(timezone=True), server_default=text("CURRENT_TIMESTAMP"))
    expiration_date = Column(DateTime)
    config_name = Column(String, nullable=True)
    domain = Column(String)  # به جای server
    port = Column(Integer)
    uuid = Column(String)
    expiration_date = Column(DateTime)
    active = Column(Boolean, default=True)
    user = relationship("User", back_populates="configs")  # ✅ این هم که بود
    # حجم مجاز (بایت) طبق پلن؛ None یعنی نامحدود
    transfer_enable = Column(BigInteger, nullable=True, comment="حجم کل به بایت")
    feedback_requested = Column(
        Boolean,
        nullable=False,
        server_default=text("false"),
        comment="آیا برای این کانفیگ فیدبک درخواست شده؟"
    )
    # ----- ترافیک -----
    transfer_enable   = Column(BigInteger, nullable=True, comment="حجم کل مجاز (بایت); None=infinite")
    used_bytes        = Column(BigInteger, default=0,   comment="حجم مصرف‌شده تاکنون")
    reset_period      = Column(Interval,  nullable=True, comment="فاصله دوره‌ای ری‌ست ترافیک (مثلاً ماهانه)")
    last_reset_at     = Column(DateTime, nullable=True,  comment="آخرین زمان ری‌ست")

    # ----- دسته‌بندی پلن و تست -----
    plan_type         = Column(String,   nullable=False, comment="monthly/unlimited/trial")
    is_trial          = Column(Boolean,  default=False)

    # ----- ابر‌داده برای آینده‌نگری -----
    extra_metadata    = Column(
        "extra_metadata", JSONB,
        nullable=False,
        server_default=text("'{}'::jsonb"),
        comment="ابر‌داده برای توسعه‌های آینده"
    )
    
    # روابط با جداول پروتکل
    v2ray = relationship("V2RayConfig", back_populates="config", uselist=False)
    wireguard = relationship(
        "WireGuardConfig", back_populates="config", uselist=False)
    openvpn = relationship(
        "OpenVPNConfig", back_populates="config", uselist=False)
    l2tp = relationship("L2TPConfig", back_populates="config", uselist=False)
    ikev2 = relationship("IKEv2Config", back_populates="config", uselist=False)
    sstp = relationship("SSTPConfig", back_populates="config", uselist=False)
    cisco = relationship("CiscoConfig", back_populates="config", uselist=False)
    ipsec = relationship("IPSecConfig", back_populates="config", uselist=False)
    pptp = relationship("PPTPConfig", back_populates="config", uselist=False)