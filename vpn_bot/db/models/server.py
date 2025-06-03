# vpn_bot/db/models/server.py
from sqlalchemy import (
    Column,
    Integer,
    String,
    Boolean,
    DateTime,
    JSON,               
    func,
    ForeignKey,         
    UniqueConstraint,   
    Index               
)
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()


Base = declarative_base()

class Server(Base):
    __tablename__ = "servers"

    id              = Column(Integer, primary_key=True)
    name            = Column(String(100), nullable=False, unique=True)
    ip              = Column(String(45),  nullable=False)
    port            = Column(Integer,   nullable=False)
    protocol        = Column(String(20), nullable=False)
    domain          = Column(String(200), nullable=True)     
    panel_path      = Column(String(200), nullable=True)     
    is_active       = Column(Boolean, default=True, nullable=False)
    current_clients = Column(Integer, default=0, nullable=False)  
    max_clients     = Column(Integer, default=0, nullable=False)  
    panel_username  = Column(String(100), nullable=True)      
    panel_password  = Column(String(100), nullable=True)      
    created_at      = Column(DateTime(timezone=True),
                              server_default=func.now(),
                              nullable=False)
    updated_at      = Column(DateTime(timezone=True),
                              server_default=func.now(),
                              onupdate=func.now(),
                              nullable=False)

    plans   = relationship("Plan", back_populates="server", cascade="all, delete-orphan")
    metrics = relationship("ServerMetric", back_populates="server", cascade="all, delete-orphan")

    __table_args__ = (
        # اگر ایندکس یا کانستِرینت دیگه‌ای لازمه اینجا اضافه کن
    )


class Plan(Base):
    __tablename__ = "plans"

    id            = Column(Integer, primary_key=True)
    server_id     = Column(Integer, ForeignKey("servers.id"), nullable=False, index=True)
    name          = Column(String(50), nullable=False)
    quota         = Column(JSON,     nullable=False)      # {"upload": bytes, "download": bytes}
    price         = Column(Integer,  nullable=False)
    duration_days = Column(Integer,  default=30, nullable=False)
    is_active     = Column(Boolean,  default=True, nullable=False)
    created_at    = Column(DateTime(timezone=True),
                           server_default=func.now(),
                           nullable=False)

    server        = relationship("Server", back_populates="plans")
    __table_args__ = (
        UniqueConstraint("server_id", "name", name="uq_plans_server_name"),
    )

class ServerMetric(Base):
    __tablename__ = "server_metrics"

    id             = Column(Integer, primary_key=True)
    server_id      = Column(Integer, ForeignKey("servers.id"), nullable=False, index=True)
    timestamp      = Column(DateTime(timezone=True),
                            server_default=func.now(),
                            nullable=False)
    online_clients = Column(Integer, default=0, nullable=False)
    cpu_usage      = Column(Integer, default=0, nullable=False)
    memory_usage   = Column(Integer, default=0, nullable=False)

    server         = relationship("Server", back_populates="metrics")
    __table_args__ = (
        Index("ix_metrics_server_timestamp", "server_id", "timestamp"),
    )
