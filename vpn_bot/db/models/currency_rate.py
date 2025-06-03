#vpn_bot/db/models/currency_rate.py

from sqlalchemy import Column, BigInteger, Float, String, DateTime, JSON, text
from vpn_bot.db.core.base import Base

class CurrencyRate(Base):
    __tablename__ = "currency_rates"

    id           = Column(BigInteger, primary_key=True)
    currency     = Column(String,  nullable=False, unique=True)        # کد ارز (مثلاً "USD", "EUR")
    base_currency= Column(String,  nullable=False, server_default="USD", comment="ارز مبنا") 
    rate         = Column(Float,   nullable=False)                     # نرخ تبدیل
    provider     = Column(String,  nullable=False, server_default="exchangerate-api", comment="سرویس دهنده") 
    fetched_at   = Column(DateTime(timezone=True), server_default=text("CURRENT_TIMESTAMP"), nullable=False)
    expires_at   = Column(DateTime(timezone=True), nullable=False, comment="تا کی معتبر است")
    raw_response = Column(JSON,    nullable=True, server_default=text("'{}'"), comment="پاسخ کامل API")

    # اگر لازم است ایندکس بگذاری:
    # __table_args__ = (Index("ix_currency_rates_currency", "currency"),)
