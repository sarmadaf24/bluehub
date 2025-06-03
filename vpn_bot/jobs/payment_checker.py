# vpn_bot/jobs/payment_checker.py

import logging
import asyncio

from sqlalchemy import select
from aiogram import Bot
from aiogram.types import BufferedInputFile
from apscheduler.triggers.interval import IntervalTrigger

from vpn_bot.utils.i18n import t
from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.transaction import Transaction
from vpn_bot.services.payment.nowpayments import check_payment_status
from vpn_bot.services.payment.scheduler import fetch_pending_transactions
from vpn_bot.services.config_builder import generate_config_for_user
from vpn_bot.services.connection_service import (
    send_config_to_user,
    generate_connection_link,
    generate_qr_image,
)

logger = logging.getLogger("payment-checker")

async def check_pending_payments(bot: Bot):
    # واکشی pending‌ها
    pending = await fetch_pending_transactions()
    for tx in pending:
        await bot.send_message(tx.user_id, "پرداخت شما در حال بررسی است")

    async with AsyncSessionLocal() as session:
        result = await session.execute(
            select(Transaction).where(Transaction.status == "pending")
        )
        pending_transactions = result.scalars().all()
        logger.info(f"📦 Found {len(pending_transactions)} pending transactions.")

        for tx in pending_transactions:
            logger.info(f"🔄 Checking payment_id={tx.reference} for user {tx.user_id}")

            try:
                status = await check_payment_status(tx.reference)
                logger.info(f"🧾 Status for {tx.reference}: {status}")

                if status == "finished":
                    logger.info(f"✅ Payment complete. Generating config for user={tx.user_id}")

                    config = await generate_config_for_user(user_id=tx.user_id, protocol=tx.type)
                    if not config:
                        logger.error(f"❌ Failed to generate config for user={tx.user_id}")
                        continue

                    connection_link = generate_connection_link(config)
                    await send_config_to_user(
                        user_id=tx.user_id,
                        config=config,
                        link=connection_link,
                        lang="fa"
                    )

                    tx.status = "paid"
                    await session.merge(tx)
                    await session.commit()

                    logger.info(f"🚀 Config sent to user {tx.user_id}")

                elif status in ["expired", "failed"]:
                    logger.warning(f"⛔ Payment {tx.reference} failed or expired. Updating status...")
                    tx.status = status
                    await session.merge(tx)
                    await session.commit()

                else:
                    logger.info(f"⏳ Payment {tx.reference} still pending...")

            except Exception as e:
                logger.exception(f"❌ Exception while checking payment {tx.reference} for user {tx.user_id}: {e}")
