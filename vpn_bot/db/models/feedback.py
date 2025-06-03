from sqlalchemy import Column, Integer, BigInteger, Boolean, String, DateTime, ForeignKey, text
from sqlalchemy.orm import relationship
from vpn_bot.db.core.base import Base

class Feedback(Base):
    __tablename__ = "feedbacks"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(BigInteger, ForeignKey("users.user_id"), nullable=False, index=True)
    config_id = Column(Integer, ForeignKey("configs.id"), nullable=False, index=True)

    is_satisfied = Column(Boolean, nullable=False, comment="آیا کاربر راضی بود؟")
    feedback_text = Column(String, nullable=True, comment="متن بازخورد کاربر")
    created_at = Column(DateTime(timezone=True), server_default=text("CURRENT_TIMESTAMP"))

    # روابط اختیاری
    user = relationship("User", backref="feedbacks", lazy="joined")
    config = relationship("Config", backref="feedbacks", lazy="joined")
