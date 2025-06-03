# 📁 vpn_bot/services/payment/nowpayments.py
# 📄 File: vpn_bot/services/payment/nowpayments.py

import httpx
import logging
from typing import Optional

from vpn_bot.services.connection_service import generate_qr_base64
from config import getenv

logger = logging.getLogger("nowpayments")

# 🔑 بارگذاری کلید از .env
NOWPAYMENTS_API_KEY = getenv("NOWPAYMENTS_API_KEY", required=True)
NOWPAYMENTS_BASE_URL = "https://api.nowpayments.io/v1"

HEADERS = {
    "x-api-key": NOWPAYMENTS_API_KEY,
    "Content-Type": "application/json"
}


async def create_payment(
    price_amount: float,
    price_currency: str,
    pay_currency: str,
    order_id: str,
    description: Optional[str] = None,
    network: Optional[str] = None
) -> Optional[dict]:
    """
    💸 ایجاد پرداخت جدید در NowPayments
    """
    payload = {
        "price_amount": price_amount,
        "price_currency": price_currency,
        "pay_currency": pay_currency,
        "order_id": order_id,
        "order_description": description or f"💸 پرداخت با {pay_currency.upper()}",
    }

    if network:
        payload["network"] = network

    logger.info(f"[NowPayments] Creating payment: {payload}")

    try:
        async with httpx.AsyncClient() as client:
            response = await client.post(
                f"{NOWPAYMENTS_BASE_URL}/payment",
                json=payload,
                headers=HEADERS,
                timeout=15
            )
            response.raise_for_status()
            data = response.json()

            logger.info(f"[NowPayments] Payment created successfully: {data}")

            # 🧠 تولید QR Code
            data["qrcode_base64"] = generate_qr_base64(data["pay_address"])
            return data

    except httpx.HTTPStatusError as e:
        logger.error(f"[NowPayments] Failed to create payment: {e}")
    except Exception as e:
        logger.exception(
            f"[NowPayments] Unexpected error in create_payment: {e}")

    return None


async def check_payment_status(payment_id: str) -> Optional[str]:
    """
    🧾 بررسی وضعیت پرداخت با شناسه پرداخت
    """
    if not payment_id.isdigit():
        logger.warning(
            f"[NowPayments] Skipping non-numeric payment_id: {payment_id}")
        return None

    url = f"{NOWPAYMENTS_BASE_URL}/payment/{payment_id}"

    try:
        async with httpx.AsyncClient() as client:
            res = await client.get(url, headers=HEADERS, timeout=10)
            res.raise_for_status()
            data = res.json()
            status = data.get("payment_status")
            logger.info(f"[NowPayments] Payment {payment_id} status: {status}")
            return status

    except httpx.HTTPStatusError as e:
        logger.error(f"[NowPayments] Error checking status: {e}")
    except Exception as e:
        logger.exception(
            f"[NowPayments] Unexpected error in check_payment_status: {e}")

    return None

async def create_invoice(
    price_amount: float,
    price_currency: str,
    pay_currency: str,
    order_id: str,
    description: Optional[str] = None,
    ipn_callback_url: Optional[str] = None,
    success_url: Optional[str] = None,
    cancel_url: Optional[str] = None
) -> Optional[dict]:
    """
    ایجاد لینک پرداخت میزبانی‌شده (Hosted Invoice) در NowPayments
    """
    payload = {
        "price_amount":      price_amount,
        "price_currency":    price_currency,
        "pay_currency":      pay_currency,
        "order_id":          order_id,
        "order_description": description or f"💸 پرداخت با {pay_currency.upper()}",
    }
    if ipn_callback_url:
        payload["ipn_callback_url"] = ipn_callback_url
    if success_url:
        payload["success_url"] = success_url
    if cancel_url:
        payload["cancel_url"] = cancel_url

    logger.info(f"[NowPayments] Creating invoice: {payload}")
    try:
        async with httpx.AsyncClient() as client:
            response = await client.post(
                f"{NOWPAYMENTS_BASE_URL}/invoice",
                json=payload,
                headers=HEADERS,
                timeout=15
            )
            response.raise_for_status()
            data = response.json()
            logger.info(f"[NowPayments] Invoice created successfully: {data}")
            return data
    except httpx.HTTPStatusError as e:
        logger.error(f"[NowPayments] Failed to create invoice: {e}")
    except Exception as e:
        logger.exception(f"[NowPayments] Unexpected error in create_invoice: {e}")
    return None
