#vpn_bot/services/payment/nobitex.py

import httpx, logging
from config import NOBITEX_API_KEY, NOBITEX_BASE_URL

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
