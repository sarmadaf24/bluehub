#vpn_bot/services/payment/exir.py

import httpx, logging
import requests
import time
import hmac
import hashlib
import json
from config import EXIR_API_KEY, EXIR_BASE_URL
from config import EXIR_API_KEY as EXIR_API_SECRET

logger = logging.getLogger("exir")

async def create_exir_order(amount_usd: float, order_id: str) -> dict:
    """
    طبق مستندات:
      - endpoint: POST {EXIR_BASE_URL}/orders
      - هِدر Authorization: Bearer <API_KEY>
    """
    payload = {
        "amount": amount_usd,
        "currency": "USD",
        "orderRef": order_id,
        # TODO: فیلدهای لازم از doc
    }
    headers = {"Authorization": f"Bearer {EXIR_API_KEY}"}
    async with httpx.AsyncClient() as client:
        resp = await client.post(f"{EXIR_BASE_URL}/orders", json=payload, headers=headers, timeout=15)
        resp.raise_for_status()
        data = resp.json()
        logger.info(f"[Exir] Order created: {data}")
        return data

async def check_exir_status(payment_id: str) -> str:
    async with httpx.AsyncClient() as client:
        resp = await client.get(f"{EXIR_BASE_URL}/orders/{payment_id}", headers={"Authorization": f"Bearer {EXIR_API_KEY}"}, timeout=15)
        resp.raise_for_status()
        return resp.json().get("status")

# =======================
# Synchronous helpers
# =======================


def _generate_signature(payload: dict, timestamp: str) -> str:
    message = f"{timestamp}:{json.dumps(payload, separators=(',', ':'), sort_keys=True)}"
    return hmac.new(EXIR_API_SECRET.encode(), message.encode(), hashlib.sha256).hexdigest()


def create_payment_order(amount_usd: float, order_id: str) -> dict:
    payload = {
        "amount": amount_usd,
        "currency": "USD",
        "orderRef": order_id,
    }
    timestamp = str(int(time.time()))
    signature = _generate_signature(payload, timestamp)
    headers = {
        "X-API-KEY": EXIR_API_KEY,
        "X-SIGNATURE": signature,
        "X-TIMESTAMP": timestamp,
    }
    resp = requests.post(
        f"{EXIR_BASE_URL}/orders",
        json=payload,
        headers=headers,
        timeout=15,
    )
    resp.raise_for_status()
    data = resp.json()
    if data.get("success") is False:
        raise Exception(f"Exir API error: {data}")
    return data


def check_payment_status(payment_id: str) -> str:
    timestamp = str(int(time.time()))
    payload = {"id": payment_id}
    signature = _generate_signature(payload, timestamp)
    headers = {
        "X-API-KEY": EXIR_API_KEY,
        "X-SIGNATURE": signature,
        "X-TIMESTAMP": timestamp,
    }
    resp = requests.get(
        f"{EXIR_BASE_URL}/orders/{payment_id}",
        headers=headers,
        timeout=15,
    )
    resp.raise_for_status()
    data = resp.json()
    if data.get("success") is False:
        raise Exception(f"Exir API error: {data}")
    return data.get("data", {}).get("status") or data.get("status")
