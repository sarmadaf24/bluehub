# /root/bluehub/vpn_bot/jobs/main.py
import sys
import os
import logging

# تا پروژه رو بشناسه
sys.path.append(
    os.path.abspath(os.path.join(os.path.dirname(__file__), "../../.."))
)

from fastapi import FastAPI
from aiogram import Bot
from apscheduler.schedulers.asyncio import AsyncIOScheduler
from apscheduler.triggers.interval import IntervalTrigger
from apscheduler.triggers.cron import CronTrigger
from apscheduler.schedulers.base import SchedulerAlreadyRunningError

from config import BOT_TOKEN
from vpn_bot.services.payment.scheduler import monitor_crypto_payments
from vpn_bot.jobs.payment_checker import check_pending_payments
from vpn_bot.jobs.cleanup import cleanup_and_request_feedback

# —————— ایجاد و پیکربندی اپ اصلی ——————
app = FastAPI(title="BlueHub Cron & API Service", version="1.0")

# —————— ثبت (mount) روت‌های API ——————
from vpn_bot.api.routes.email_verification import router as email_router
from vpn_bot.api.routes.server             import router as server_router

app.include_router(email_router, prefix="/api",       tags=["email"])
app.include_router(server_router, prefix="/api/servers", tags=["servers"])
# ————————————————————————————————

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("cron-worker")

# Instantiate Bot and Scheduler at module level
bot = Bot(token=BOT_TOKEN)
scheduler = AsyncIOScheduler()


def setup_jobs():
    # Crypto payment monitor every minute
    scheduler.add_job(
        monitor_crypto_payments,
        trigger=IntervalTrigger(minutes=1),
        args=[bot],
        id="monitor_crypto",
        replace_existing=True
    )
    # Pending payment checker every minute
    scheduler.add_job(
        check_pending_payments,
        trigger=IntervalTrigger(minutes=1),
        args=[bot],
        id="check_pending",
        replace_existing=True
    )
    # Daily cleanup and feedback at 02:00
    scheduler.add_job(
        cleanup_and_request_feedback,
        trigger=CronTrigger(hour=2, minute=0),
        args=[bot],
        id="cleanup_feedback",
        replace_existing=True
    )


@app.on_event("startup")
async def on_startup():
    setup_jobs()
    try:
        scheduler.start()
    except SchedulerAlreadyRunningError:
        logger.warning("Scheduler already running—skip starting again")
    logger.info("✅ Scheduler started")


@app.on_event("shutdown")
async def on_shutdown():
    # Shutdown scheduler safely
    try:
        scheduler.shutdown(wait=True)
        logger.info("✅ Scheduler shutdown complete")
    except Exception:
        logger.exception("⚠️ Scheduler shutdown failed")
    # Close bot session safely
    try:
        await bot.session.close()
        logger.info("✅ Bot session closed")
    except Exception:
        logger.exception("⚠️ Bot session close failed")
