# vpn_bot/db/models/parental_control.py

from sqlalchemy import (
    Column, Integer, BigInteger, String,
    DateTime, Boolean, JSON, text, func, Index
)
from sqlalchemy.orm import relationship
from vpn_bot.db.core.base import Base

class Parent(Base):
    __tablename__ = "parents"

    id       = Column(Integer, primary_key=True, index=True)
    user_id  = Column(BigInteger, unique=True, nullable=False, index=True)
    children = relationship("Child", back_populates="parent", cascade="all, delete-orphan")


class ParentalControl(Base):
    __tablename__ = "parental_controls"
    __table_args__ = (
        Index("ix_parental_controls_parent_id", "parent_id"),
        Index("ix_parental_controls_child_id",  "child_id"),
    )

    id           = Column(Integer, primary_key=True, index=True)
    parent_id    = Column(BigInteger, nullable=False, comment="شناسه کاربری والد")
    child_id     = Column(BigInteger, nullable=False, comment="شناسه کاربری فرزند")
    control_type = Column(String(50), nullable=False,
                          comment="نوع کنترل: time_limit، bandwidth_limit، block_sites، ...")
    settings     = Column(JSON, nullable=False,
                          server_default=text("'{}'::jsonb"),
                          comment="پارامترهای کنترل به صورت JSON")
    is_active    = Column(Boolean, nullable=False,
                          server_default=text("true"),
                          comment="کنترل فعال است؟")
    created_at   = Column(DateTime(timezone=True),
                          server_default=func.now(), nullable=False)
    updated_at   = Column(DateTime(timezone=True),
                          server_default=func.now(),
                          onupdate=func.now(), nullable=False)

    reports      = relationship(
        "ParentalReport",
        back_populates="control",
        cascade="all, delete-orphan"
    )


class Child(Base):
    __tablename__ = "children"

    id            = Column(Integer, primary_key=True, index=True)
    parent_id     = Column(Integer,
                           ForeignKey("parents.id", ondelete="CASCADE"),
                           nullable=False, index=True)
    child_user_id = Column(BigInteger, unique=True, nullable=False, index=True)
    alias         = Column(String(50), nullable=True)
    created_at    = Column(DateTime(timezone=True),
                           server_default=func.now(), nullable=False)

    parent        = relationship("Parent", back_populates="children")
    usage_reports = relationship("ChildUsageReport", back_populates="child",
                                 cascade="all, delete-orphan")


class ChildUsageReport(Base):
    __tablename__ = "child_usage_reports"

    id         = Column(Integer, primary_key=True, index=True)
    child_id   = Column(Integer,
                         ForeignKey("children.id", ondelete="CASCADE"),
                         nullable=False, index=True)
    timestamp  = Column(DateTime(timezone=True),
                         server_default=func.now(), nullable=False)
    used_bytes = Column(BigInteger, nullable=False)
    note       = Column(Text, nullable=True)

    child      = relationship("Child", back_populates="usage_reports")
