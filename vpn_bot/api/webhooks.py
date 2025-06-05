# vpn_bot/api/webhooks.py

from fastapi import APIRouter, HTTPException
from sqlalchemy import select
import logging

from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.transaction import Transaction

router = APIRouter()
logger = logging.getLogger("webhooks")

async def _update_transaction(order_id: str, status: str, gateway: str):
    async with AsyncSessionLocal() as session:
        result = await session.execute(
            select(Transaction).where(
                Transaction.reference == str(order_id),
                Transaction.gateway == gateway,
            )
        )
        tx = result.scalar_one_or_none()
        if not tx:
            logger.warning(
                f"Transaction not found for gateway={gateway} order_id={order_id}"
            )
            return False
        if status:
            tx.status = status
        session.add(tx)
        await session.commit()
        return True

@router.post("/webhook/nobitex")
async def nobitex_webhook(payload: dict):
    order_id = payload.get("order_id") or payload.get("id")
    status = payload.get("status")
    if not order_id:
        raise HTTPException(400, "order_id missing")
    await _update_transaction(order_id, status, "nobitex")
    return {"ok": True}

@router.post("/webhook/wallex")
async def wallex_webhook(payload: dict):
    order_id = payload.get("order_id") or payload.get("id")
    status = payload.get("status")
    if not order_id:
        raise HTTPException(400, "order_id missing")
    await _update_transaction(order_id, status, "wallex")
    return {"ok": True}

@router.post("/webhook/exir")
async def exir_webhook(payload: dict):
    order_id = (
        payload.get("order_id")
        or payload.get("id")
        or payload.get("orderRef")
    )
    status = payload.get("status")
    if not order_id:
        raise HTTPException(400, "order_id missing")
    await _update_transaction(order_id, status, "exir")
    return {"ok": True}

