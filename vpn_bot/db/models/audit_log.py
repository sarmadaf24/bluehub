# vpn_bot/db/models/audit_log.py

from sqlalchemy import Column, BigInteger, String, DateTime, JSON, text
from vpn_bot.db.core.base import Base

class AuditLog(Base):
    __tablename__ = "audit_logs"

    id         = Column(BigInteger, primary_key=True)
    user_id    = Column(BigInteger, nullable=True, comment="شناسه کاربری (اختیاری)")
    action     = Column(String,    nullable=False, comment="عنوان یا نوع عملیات")
    metadata   = Column(JSON,      nullable=False, server_default=text("'{}'"), comment="اطلاعات جانبی (JSON)")
    created_at = Column(DateTime(timezone=True), nullable=False, server_default=text("CURRENT_TIMESTAMP"), comment="زمان رخداد")
