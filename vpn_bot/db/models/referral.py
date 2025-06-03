# vpn_bot/db/models/referral.py

from sqlalchemy import (
    Column, BigInteger, Integer, String,
    DateTime, Boolean, JSON, text, ForeignKey
)
from vpn_bot.db.core.base import Base

class Referral(Base):
    __tablename__ = "referrals"

    id            = Column(BigInteger, primary_key=True)
    referrer_id   = Column(BigInteger, ForeignKey("users.user_id"), nullable=False)
    referee_id    = Column(BigInteger, ForeignKey("users.user_id"), nullable=False)
    code          = Column(String, nullable=False, unique=True, comment="کد ارجاع یکتا") 
    bonus         = Column(Integer, nullable=False, default=0, comment="مقدار بونوس (تومان یا واحد پول)")
    status        = Column(
        String, nullable=False, server_default="pending",
        comment="وضعیت: pending/earned/used"
    )
    used          = Column(Boolean, nullable=False, server_default=text("false"), comment="آیا بونوس اعمال شده؟")
    used_at       = Column(DateTime(timezone=True), nullable=True, comment="زمان اعمال بونوس")
    metadata      = Column(
        JSON, nullable=False, server_default=text("'{}'"),
        comment="اطلاعات اضافی (مثلاً شرایط خاص)"
    )
    created_at    = Column(
        DateTime(timezone=True),
        nullable=False,
        server_default=text("CURRENT_TIMESTAMP"),
        comment="زمان ثبت ارجاع"
    )
