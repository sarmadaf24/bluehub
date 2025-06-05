#vpn_bot/services/payment/wallex.py

import httpx, logging
import requests
from config import WALLEX_API_KEY, WALLEX_BASE_URL

logger = logging.getLogger("wallex")

async def create_wallex_transaction(amount_usd: float, order_id: str) -> dict:
    """
    طبق مستندات:
      - endpoint: POST {WALLEX_BASE_URL}/v1/transactions
      - هِدر X-API-KEY: <API_KEY>
    """
    payload = {
        "amount": amount_usd,
        "currency": "USD",
        "reference": order_id,
        # TODO: سایر فیلدها طبق doc
    }
    headers = {"X-API-KEY": WALLEX_API_KEY}
    async with httpx.AsyncClient() as client:
        resp = await client.post(f"{WALLEX_BASE_URL}/v1/transactions", json=payload, headers=headers, timeout=15)
        resp.raise_for_status()
        data = resp.json()
        logger.info(f"[Wallex] Transaction created: {data}")
        return data

async def check_wallex_status(payment_id: str) -> str:
    async with httpx.AsyncClient() as client:
        resp = await client.get(f"{WALLEX_BASE_URL}/v1/transactions/{payment_id}", headers={"X-API-KEY": WALLEX_API_KEY}, timeout=15)
        resp.raise_for_status()
        return resp.json().get("status")

# =======================
# Synchronous helpers
# =======================


def create_payment_order(amount_usd: float, order_id: str) -> dict:
    payload = {
        "amount": amount_usd,
        "currency": "USD",
        "reference": order_id,
    }
    headers = {"Authorization": f"Bearer {WALLEX_API_KEY}"}

    resp = requests.post(
        f"{WALLEX_BASE_URL}/v1/transactions",
        json=payload,
        headers=headers,
        timeout=15,
    )
    resp.raise_for_status()
    data = resp.json()
    if data.get("code") != 0:
        raise Exception(f"Wallex API error: {data}")
    return data


def check_payment_status(payment_id: str) -> str:
    headers = {"Authorization": f"Bearer {WALLEX_API_KEY}"}
    resp = requests.get(
        f"{WALLEX_BASE_URL}/v1/transactions/{payment_id}",
        headers=headers,
        timeout=15,
    )
    resp.raise_for_status()
    data = resp.json()
    if data.get("code") != 0:
        raise Exception(f"Wallex API error: {data}")
    return data.get("data", {}).get("status") or data.get("status")
