# 📁 vpn_bot/services/payment/scheduler.py

import asyncio
import logging
from aiogram import Bot
from aiogram.client.default import DefaultBotProperties
from uuid import uuid4
from datetime import datetime, timedelta
from sqlalchemy import select

from config import BOT_TOKEN
from vpn_bot.utils.i18n import t
from vpn_bot.services.payment.nowpayments import check_payment_status
from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.transaction import Transaction
from vpn_bot.db.models.plan import Plan
from vpn_bot.db.models.config import Config
from vpn_bot.services.panel_service import PanelService

# هر چند ثانیه یک‌بار اجرا شود
INTERVAL_SECONDS = 60


logger = logging.getLogger("payment-scheduler")

async def fetch_pending_transactions() -> list[Transaction]:
    """
    تمام تراکنش‌های با وضعیت 'pending' را برمی‌گرداند.
    """
    async with AsyncSessionLocal() as session:
        result = await session.execute(
            select(Transaction).where(Transaction.status == "pending")
        )
        pending = result.scalars().all()
    logger.info(f"📦 fetched {len(pending)} pending transactions")
    return pending

async def monitor_crypto_payments(bot: Bot):
    logging.info("🔁 بررسی پرداخت‌های رمزارز توسط Cron Job...")
    async with AsyncSessionLocal() as session:
        rows = await session.execute(
            Transaction.__table__.select().where(
                Transaction.gateway == "nowpayments",
                Transaction.status == "waiting"
            )
        )
        waiting_tx = rows.fetchall()

        for tx in waiting_tx:
            payment_id = tx.reference
            user_id    = tx.user_id
            plan_id    = tx.plan_id
            logging.info(f"🧾 بررسی وضعیت پرداخت: {payment_id}")
            status = await check_payment_status(payment_id)

            if status == "finished":
                logging.info(f"✅ پرداخت تأیید شده: {payment_id}")
                # به‌روزرسانی وضعیت تراکنش
                tx.status = "paid"
                # (در اینجا می‌توانید منطق ساخت کانفیگ را هم اضافه کنید)
                await session.commit()

                # پیام موفقیت را به کاربر ارسال کنید
                await bot.send_message(
                    user_id,
                    f"✅ <b>{t('payment_success', 'fa')}</b>\n\n"
                    f"🔖 <b>{t('payment_id', 'fa')}:</b> {payment_id}",
                    parse_mode="HTML"
                )

            elif status in ("expired", "failed"):
                tx.status = status
                await session.commit()
                logging.warning(f"❌ پرداخت {status}: {payment_id}")

    logging.info("⏳ پایان بررسی این نوبت Cron Job")

async def start_scheduler():
    """
    فانکشنی که قرار است از خارج (مثلاً در fastAPI) import و اجرا شود.
    """
    # یک بات موقتی بسازیم تا بتوانیم پیام ارسال کنیم
    bot = Bot(token=BOT_TOKEN, default=DefaultBotProperties(parse_mode="HTML"))

    while True:
        try:
            await monitor_crypto_payments(bot)
        except Exception as e:
            logging.exception(f"❗ خطا در Cron Job: {e}")
        await asyncio.sleep(INTERVAL_SECONDS)
