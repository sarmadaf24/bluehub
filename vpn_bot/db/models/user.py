# 📁 vpn_bot/db/models/user.py

from sqlalchemy import Column, BigInteger, String, Integer, DateTime, Boolean, ForeignKey, Index, text
from vpn_bot.db.core.base import Base
from sqlalchemy.orm import relationship
from sqlalchemy.sql import text
from sqlalchemy.orm import relationship, backref


class User(Base):
    __tablename__ = "users"

    user_id = Column(BigInteger, primary_key=True)  # ✅ این خط باید باشه
    username = Column(String)
    phone = Column(String)

    balance = Column(Integer, default=0, comment="موجودی کیف‌پول کاربر (تومان/دلار)")
    referrer_id = Column(
        BigInteger,
        ForeignKey("users.user_id"),
        nullable=True,
        index=True,
        comment="کاربری که این فرد را دعوت کرده"
    )
    total_referral_bonus = Column(
        Integer,
        default=0,
        comment="مجموع بونوس‌های دریافتی از زیرمجموعه‌ها"
    )
    lang = Column(String, nullable=True, index=True)
    role = Column(String, default="user", index=True)
    full_name = Column(String, nullable=True)
    language_code = Column(String, default="fa")
    is_admin = Column(Boolean, default=False)
    created_at = Column(DateTime(timezone=True), server_default=text("CURRENT_TIMESTAMP"))
    email = Column(String, unique=True, index=True, nullable=True)
    email_verified_at = Column(DateTime(timezone=True), nullable=True)
    trial_used = Column(
    Boolean,
    server_default=text("false"),
    nullable=False,
    comment="آیا کاربر تریال را قبلاً استفاده کرده؟"
    )

    # روابط
    configs = relationship("Config", back_populates="user", lazy="selectin")
    email_tokens = relationship("EmailToken", back_populates="user", lazy="selectin")
    orders = relationship("Order", backref="user", lazy="selectin")
    tickets = relationship("Ticket", backref="user", lazy="selectin")
    referrals = relationship(
        "User",
        backref=backref("referrer", remote_side=[user_id]),
        lazy="selectin"
    )
    __table_args__ = (
        Index("ix_user_username_phone", "username", "phone"),
    )
    