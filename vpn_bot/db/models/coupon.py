# vpn_bot/db/models/coupon.py

from sqlalchemy import (
    Column, String, Integer,
    DateTime, Boolean, text
)
from vpn_bot.db.core.base import Base

class Coupon(Base):
    __tablename__ = "coupons"

    code        = Column(
        String, primary_key=True,
        comment="کد تخفیف یکتا (مثلاً ABC123)"
    )
    discount    = Column(
        Integer, nullable=False,
        comment="درصد تخفیف (0–100) یا مبلغ ثابت (مثلاً 5000)"
    )
    valid_from  = Column(
        DateTime(timezone=True),
        nullable=False,
        server_default=text("CURRENT_TIMESTAMP"),
        comment="شروع اعتبار"
    )
    valid_until = Column(
        DateTime(timezone=True),
        nullable=False,
        comment="پایان اعتبار"
    )
    used        = Column(
        Boolean, nullable=False,
        server_default=text("false"),
        comment="آیا کد یک‌بار مصرف مصرف شده؟"
    )
    created_at  = Column(
        DateTime(timezone=True),
        nullable=False,
        server_default=text("CURRENT_TIMESTAMP"),
        comment="زمان ایجاد کد"
    )
