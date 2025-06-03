from sqlalchemy import Column, Integer, BigInteger, ForeignKey, DateTime, String
from sqlalchemy.dialects.postgresql import JSONB
from datetime import datetime
from vpn_bot.db.core.base import Base
from sqlalchemy.dialects.postgresql import JSONB
from sqlalchemy.sql import text

class TrafficRecord(Base):
    __tablename__ = "traffic_records"

    id           = Column(Integer, primary_key=True)
    user_id      = Column(BigInteger, ForeignKey("users.user_id"), nullable=False)
    config_id    = Column(BigInteger, ForeignKey("configs.id"), nullable=False)
    category     = Column(String, nullable=False)        # e.g. social, youtube, other
    bytes_used   = Column(BigInteger, nullable=False)
    timestamp    = Column(DateTime, default=datetime.utcnow, index=True)
    extra_metadata = Column(
        "extra_metadata", JSONB,
        nullable=False,
        server_default=text("'{}'::jsonb"),
        comment="ابر‌داده برای توسعه‌های آینده"
    )