# vpn_bot/db/models/plan.py

from sqlalchemy import Column, Integer, String, Boolean, DateTime, text
from datetime import datetime
from vpn_bot.db.core.base import Base

class Plan(Base):
    __tablename__ = "plans"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False, comment="نام پلن")
    duration_days = Column(Integer, nullable=False, comment="مدت زمان به روز")
    volume_gb = Column(Integer, nullable=True, comment="حجم به گیگابایت؛ None = نامحدود")
    price = Column(Integer, nullable=False, comment="قیمت (به تومان)")
    description = Column(String, nullable=True, comment="توضیحات اختیاری")
    is_active = Column(Boolean, nullable=False, server_default=text("true"), comment="آیا پلن فعال است؟")
    created_at = Column(DateTime(timezone=True), nullable=False, server_default=text("CURRENT_TIMESTAMP"))

    # نوع پلن: monthly, unlimited, trial
    plan_type = Column(
        "type",
        String,
        nullable=False,
        server_default="monthly",
        comment="نوع پلن: monthly/unlimited/trial"
    )
