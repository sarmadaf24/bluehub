# vpn_bot/services/email_service.py

import logging
import uuid
import smtplib
from itsdangerous import URLSafeTimedSerializer, BadSignature, SignatureExpired
from datetime import datetime, timezone
from email.mime.text import MIMEText
from sqlalchemy import insert, select, update

from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.email_token import EmailToken
from vpn_bot.db.models.user import User
from config import SECRET_KEY, SMTP_HOST, SMTP_PORT, SMTP_USER, SMTP_PASS, SMTP_SENDER, FRONTEND_URL

logger = logging.getLogger("email-service")

# Serializer با salt ثابت
serializer = URLSafeTimedSerializer(SECRET_KEY, salt="email-confirm-salt")


class TokenNotFound(Exception):
    """توکن نامعتبر یا منقضی."""
    pass


class TokenExpired(TokenNotFound):
    pass


class TokenInvalid(TokenNotFound):
    pass


from sqlalchemy import update

async def generate_email_token(user_id: int) -> str:
    token = serializer.dumps(str(user_id))
    async with AsyncSessionLocal() as sess:
        # ۱) غیرفعال کردن توکن‌های قبلی
        await sess.execute(
            update(EmailToken)
            .where(EmailToken.user_id == user_id, EmailToken.used == False)
            .values(used=True)
        )
        # ۲) درج توکن جدید
        await sess.execute(
            insert(EmailToken).values(
                id=str(uuid.uuid4()),
                user_id=user_id,
                token=token,
                created_at=datetime.now(timezone.utc),
                used=False
            )
        )
        await sess.commit()
    logger.info(f"[DEBUG] Generated email token for user {user_id}: {token}")
    return token

async def send_verification_email(to_email: str, token: str):
    link = f"{FRONTEND_URL}/api/verify_email/{token}"
    subject = "فعال‌سازی ایمیل برای تست رایگان"
    body = (
        f"برای دریافت تست رایگان لطفاً روی لینک زیر کلیک کنید:\n\n"
        f"{link}\n"
        "اگر ایمیل را دریافت نکردید، پوشه‌ی اسپم را چک کنید."
    )
    msg = MIMEText(body, _charset="utf-8")
    msg["Subject"] = subject
    msg["From"] = SMTP_SENDER
    msg["To"] = to_email

    logger.info(f"[EMAIL] در حال ارسال ایمیل به {to_email}")
    with smtplib.SMTP(SMTP_HOST, SMTP_PORT) as smtp:
        smtp.ehlo()
        smtp.starttls()
        smtp.login(SMTP_USER, SMTP_PASS)
        smtp.sendmail(SMTP_SENDER, [to_email], msg.as_string())
    logger.info(f"[EMAIL] ایمیل تأیید به {to_email} ارسال شد")


async def confirm_email_token(token: str) -> int:
    # ۱) اعتبارسنجی ساختاری و انقضا
    try:
        user_id_str = serializer.loads(token, max_age=86400)
        logger.info(f"[EMAIL] Token load OK, user_id={user_id_str}")
    except SignatureExpired:
        logger.warning(f"[EMAIL] توکن منقضی شده: {token}")
        raise TokenExpired()
    except BadSignature:
        logger.warning(f"[EMAIL] توکن نامعتبر: {token}")
        raise TokenInvalid()

    # ۲) بررسی در DB و علامت‌گذاری استفاده‌شده
    async with AsyncSessionLocal() as sess:
        q = select(EmailToken).where(
            EmailToken.token == token,
            EmailToken.used == False,
        )
        result = await sess.execute(q)
        et = result.scalar_one_or_none()
        if not et:
            logger.warning(f"[EMAIL] Token not found or already used in DB: {token}")
            raise TokenNotFound()

        await sess.execute(
            update(EmailToken)
            .where(EmailToken.id == et.id)
            .values(used=True)
        )
        await sess.execute(
            update(User)
            .where(User.user_id == int(user_id_str))
            .values(email_verified_at=datetime.now(timezone.utc))
        )
        await sess.commit()
    logger.info(f"[EMAIL] Token marked as used and email_verified_at updated for user {user_id_str}")
    return int(user_id_str)
