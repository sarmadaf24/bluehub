#vpn_bot/services/payment/exir.py

import httpx, logging
from config import EXIR_API_KEY, EXIR_BASE_URL

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
