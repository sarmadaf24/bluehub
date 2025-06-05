from aiogram import Router, F
from aiogram.types import CallbackQuery
from sqlalchemy import select
import asyncio

from vpn_bot.context.lang_context import current_lang
from vpn_bot.utils.i18n import t
from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.transaction import Transaction

from vpn_bot.services.payment.nowpayments import check_payment_status as np_check
from vpn_bot.services.payment.nobitex import check_payment_status as nb_check
from vpn_bot.services.payment.wallex import check_payment_status as wx_check
from vpn_bot.services.payment.exir import check_payment_status as ex_check

router = Router()

_CHECKERS = {
    "nowpayments": np_check,
    "nobitex": nb_check,
    "wallex": wx_check,
    "exir": ex_check,
}

_SUCCESS_STATUSES = {"finished", "paid", "success", "done"}
_PENDING_STATUSES = {"waiting", "pending", "confirming"}

@router.callback_query(F.data.startswith("check_payment:"))
async def handle_check_payment(cb: CallbackQuery):
    lang = current_lang.get()
    gateway = cb.data.split(":", 1)[1]
    check_func = _CHECKERS.get(gateway)
    if not check_func:
        await cb.answer()
        return await cb.message.answer("❌ Unknown gateway")

    async with AsyncSessionLocal() as session:
        result = await session.execute(
            select(Transaction)
            .where(
                Transaction.user_id == cb.from_user.id,
                Transaction.gateway == gateway,
                Transaction.status.in_(list(_PENDING_STATUSES))
            )
            .order_by(Transaction.id.desc())
        )
        tx = result.scalars().first()
        if not tx:
            await cb.message.answer("❌ Transaction not found")
            await cb.answer()
            return

        payment_id = tx.reference
        await cb.message.answer(t("checking_payment", lang))

        if asyncio.iscoroutinefunction(check_func):
            status = await check_func(payment_id)
        else:
            status = await asyncio.to_thread(check_func, payment_id)

        if not status:
            await cb.message.answer("❗ " + t("unknown_error", lang))
            await cb.answer()
            return

        if status in _SUCCESS_STATUSES:
            tx.status = "paid"
            msg = t("payment_success", lang).format(ref_id=payment_id)
        elif status in _PENDING_STATUSES:
            tx.status = status
            if status == "confirming":
                msg = "🔄 " + t("payment_confirming", lang)
            else:
                msg = "⏳ " + t("payment_still_waiting", lang)
        elif status == "expired":
            tx.status = status
            msg = "⛔ " + t("payment_expired", lang)
        else:
            tx.status = status
            msg = "❌ " + t("payment_failed", lang)

        session.add(tx)
        await session.commit()

    await cb.message.answer(msg, parse_mode="HTML")
    await cb.answer()
