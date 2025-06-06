#vpn_bot/services/payment/nobitex.py

import httpx, logging
import requests
import json
import time
import hmac
import hashlib
from config import NOBITEX_API_KEY, NOBITEX_BASE_URL
from config import NOBITEX_API_KEY as NOBITEX_API_SECRET

logger = logging.getLogger("nobitex")

async def create_nobitex_invoice(amount_usd: float, order_id: str) -> dict:
    """
    طبق مستندات:
      - endpoint: POST {NOBITEX_BASE_URL}/v2/orders
      - هِدر Authorization: Bearer <API_KEY>
      - payload: {amount, currency, order_id, ...}
    """
    payload = {
        "amount": amount_usd,
        "currency": "USD",
        "order_id": order_id,
        # TODO: فیلدهای موردنیاز دیگر طبق doc
    }
    headers = {"Authorization": f"Bearer {NOBITEX_API_KEY}"}
    async with httpx.AsyncClient() as client:
        resp = await client.post(f"{NOBITEX_BASE_URL}/v2/orders", json=payload, headers=headers, timeout=15)
        resp.raise_for_status()
        data = resp.json()
        logger.info(f"[Nobitex] Order created: {data}")
        return data

async def check_nobitex_payment_status(payment_id: str) -> str:
    async with httpx.AsyncClient() as client:
        resp = await client.get(f"{NOBITEX_BASE_URL}/v2/orders/{payment_id}", headers={"Authorization": f"Bearer {NOBITEX_API_KEY}"}, timeout=15)
        resp.raise_for_status()
        status = resp.json().get("status")
        # map کردن status به finished/waiting/expired
        return status

# =======================
# Synchronous helpers
# =======================

def _sign_payload(payload: dict) -> tuple[str, str]:
    """Generate timestamp and HMAC-SHA512 signature for Nobitex."""
    timestamp = str(int(time.time()))
    body = json.dumps(payload, separators=(",", ":"), ensure_ascii=False)
    signature = hmac.new(
        NOBITEX_API_SECRET.encode(),
        body.encode(),
        hashlib.sha512,
    ).hexdigest()
    return timestamp, signature


def create_payment_order(amount_usd: float, order_id: str) -> dict:
    payload = {
        "amount": amount_usd,
        "currency": "USD",
        "order_id": order_id,
    }
    timestamp, signature = _sign_payload(payload)
    headers = {
        "Authorization": f"Bearer {NOBITEX_API_KEY}",
        "X-SIGNATURE": signature,
        "X-TIMESTAMP": timestamp,
    }

    resp = requests.post(
        f"{NOBITEX_BASE_URL}/v2/orders",
        json=payload,
        headers=headers,
        timeout=15,
    )
    resp.raise_for_status()
    data = resp.json()
    if data.get("status") != 200:
        raise Exception(f"Nobitex API error: {data}")
    return data


def check_payment_status(payment_id: str) -> str:
    payload = {"payment_id": payment_id}
    timestamp, signature = _sign_payload(payload)
    headers = {
        "Authorization": f"Bearer {NOBITEX_API_KEY}",
        "X-SIGNATURE": signature,
        "X-TIMESTAMP": timestamp,
    }
    resp = requests.get(
        f"{NOBITEX_BASE_URL}/v2/orders/{payment_id}",
        headers=headers,
        timeout=15,
    )
    resp.raise_for_status()
    data = resp.json()
    if data.get("status") != 200:
        raise Exception(f"Nobitex API error: {data}")
    return data.get("result", {}).get("status") or data.get("status")
