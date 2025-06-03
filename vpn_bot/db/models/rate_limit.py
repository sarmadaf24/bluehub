# vpn_bot/db/models/rate_limit.py

from sqlalchemy import (
    Column, BigInteger, String,
    Integer, DateTime, text
)
from vpn_bot.db.core.base import Base

class RateLimit(Base):
    __tablename__ = "rate_limits"

    id           = Column(BigInteger, primary_key=True)
    key          = Column(String,    nullable=False, index=True, comment="مثلاً user:<id> یا ip:<addr>")
    action       = Column(String,    nullable=False, comment="نوع عمل (مثلاً trial_email)")
    count        = Column(Integer,   nullable=False, server_default="0", comment="تعداد دفعات انجام شده")
    period_start = Column(
        DateTime(timezone=True),
        nullable=False,
        server_default=text("CURRENT_TIMESTAMP"),
        comment="شروع بازه‌ی شمارش"
    )
