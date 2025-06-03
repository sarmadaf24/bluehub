# vpn_bot/api/routes/email_verification.py

from vpn_bot.db.models.user import User
from vpn_bot.db.core.session import AsyncSessionLocal
from sqlalchemy import select
import logging
from fastapi import APIRouter, HTTPException
from fastapi.responses import HTMLResponse
from aiogram import Bot

from vpn_bot.services.email_service import confirm_email_token, TokenNotFound
from vpn_bot.services.user_trial_service import create_and_send_trial_config
from config import BOT_TOKEN

router = APIRouter()
logger = logging.getLogger("email-verification")

@router.get("/verify_email/{token}", response_class=HTMLResponse)
async def verify_email(token: str):
    logger.info(f"[email-verif] start verify_email token={token}")
    try:
        user_id = await confirm_email_token(token)
        logger.info(f"[email-verif] token confirmed for user={user_id}")
    except TokenNotFound:
        logger.warning(f"[email-verif] invalid token={token}")
        raise HTTPException(404, "Invalid or expired token")

    # ———— ➊ بررسی استفاده قبلی از تست ————
    async with AsyncSessionLocal() as sess:
        result = await sess.execute(select(User).where(User.user_id == user_id))
        user = result.scalar_one()
        if user.trial_used:
            return HTMLResponse("<html>⚠️ شما قبلاً از تست رایگان استفاده کرده‌اید.</html>")

    bot = Bot(token=BOT_TOKEN)
    try:
        await create_and_send_trial_config(user_id, bot)
        logger.info(f"[email-verif] trial config created & sent for user={user_id}")
        # ———— ➋ علامت‌گذاری استفاده از تست ————
        async with AsyncSessionLocal() as sess:
            result = await sess.execute(select(User).where(User.user_id == user_id))
            user = result.scalar_one()
            user.trial_used = True
            sess.add(user)
            await sess.commit()
    except Exception as e:
        logger.exception(f"[email-verif] FAILED to build/send trial config for user={user_id}")
        raise HTTPException(500, f"خطای داخلی: {e}")
    finally:
        await bot.session.close()

    return HTMLResponse(
        "<html>…کانفیگ تست از طریق ربات ارسال گردید.</html>"
    )
