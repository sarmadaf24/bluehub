from aiogram import Router
from aiogram.filters import Text
from aiogram.types import CallbackQuery, InlineKeyboardMarkup, InlineKeyboardButton
from aiogram.enums import ParseMode

from vpn_bot.services.payment.wallex import create_payment_order
from vpn_bot.db.core import SessionLocal
from vpn_bot.db.models.transaction import Transaction

import time

router = Router()

@router.callback_query(Text(equals="wallex"))
async def handle_wallex(callback: CallbackQuery):
    order = create_payment_order(amount_usd=10.0, order_id=f"{callback.from_user.id}_{int(time.time())}")
    payment_url = order.get("payment_url")

    db = SessionLocal()
    try:
        txn = Transaction(
            user_id=callback.from_user.id,
            plan_id=0,
            amount=10,
            currency="USD",
            status="pending",
            gateway="wallex",
            reference=str(order.get("id")),
            type="buy",
        )
        db.add(txn)
        db.commit()
    finally:
        db.close()

    kb = InlineKeyboardMarkup(
        inline_keyboard=[[InlineKeyboardButton(text="🔗 پرداخت", url=payment_url)]]
    )
    await callback.message.answer(
        "<b>لینک پرداخت شما آماده است.</b>",
        reply_markup=kb,
        parse_mode=ParseMode.HTML,
    )
    await callback.answer()
