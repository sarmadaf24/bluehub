# vpn_bot/api/routes/email_verification.py

import os
import logging
from fastapi import APIRouter, HTTPException
from fastapi.responses import HTMLResponse
from vpn_bot.services.email_service import confirm_email_token, TokenNotFound
from vpn_bot.services.user_trial_service import create_and_send_trial_config
from aiogram import Bot
from config import BOT_TOKEN

router = APIRouter()
logger = logging.getLogger("email-verif2")

@router.get("/verify_email/{token}", response_class=HTMLResponse)
async def verify_email(token: str):
    logger.info("شروع تأیید ایمیل؛ token=%s", token)
    try:
        user_id = await confirm_email_token(token)
        logger.info("توکن معتبر؛ user_id=%s", user_id)
    except TokenNotFound:
        logger.warning("توکن نامعتبر یا منقضی: %s", token)
        raise HTTPException(404, "Invalid or expired token")

    bot = Bot(token=BOT_TOKEN)
    try:
        await create_and_send_trial_config(user_id, bot)
        logger.info("کانفیگ تست ارسال شد برای user_id=%s", user_id)
    except Exception as e:
        logger.error("خطا در ارسال کانفیگ تست: %s", e, exc_info=True)
        raise HTTPException(500, "خطای داخلی")
    finally:
        await bot.session.close()

    return HTMLResponse(
        "<html><body>"
        "<h1>ایمیل تأیید شد!</h1>"
        "<p>کانفیگ تست ارسال گردید.</p>"
        "</body></html>"
    )
