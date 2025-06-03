# 📁 vpn_bot/bot/handlers/payment/nobitex.py

from aiogram import Router, F
from aiogram.types import CallbackQuery, InlineKeyboardMarkup, InlineKeyboardButton
from aiogram.fsm.context import FSMContext

from vpn_bot.bot.handlers.payment.crypto import CryptoPaymentStates
from vpn_bot.services.payment.nobitex import create_nobitex_invoice, check_nobitex_payment_status

router = Router()

# 1. تابع async فیلتر provider
async def is_nobitex(call: CallbackQuery, state: FSMContext) -> bool:
    data = await state.get_data()
    return data.get("selected_provider") == "nobitex"

def payment_check_kb() -> InlineKeyboardMarkup:
    return InlineKeyboardMarkup(
        inline_keyboard=[
            [InlineKeyboardButton("✅ پرداخت انجام شد", callback_data="check_nobitex")]
        ]
    )

# 2. استفاده از فیلتر در decorator
@router.callback_query(
    CryptoPaymentStates.select_coin,
    F.data.startswith("crypto_coin:"),
    is_nobitex
)
async def nobitex_coin_selected(call: CallbackQuery, state: FSMContext):
    coin = call.data.split(":", 1)[1]
    amt = (await state.get_data())["amount_usd"]
    inv = await create_nobitex_invoice(amount_usd=amt, order_id="order123")
    await state.update_data(order_id=inv["order_id"], coin=coin)
    await call.message.edit_text(
        f"پرداخت Nobitex\nکوین: {coin}\nمبلغ USD: {amt}\nلینک: {inv['payment_url']}",
        reply_markup=payment_check_kb()
    )
    await state.set_state(CryptoPaymentStates.waiting_for_payment)

@router.callback_query(
    CryptoPaymentStates.waiting_for_payment,
    F.data == "check_nobitex",
    is_nobitex
)
async def nobitex_payment_check(call: CallbackQuery, state: FSMContext):
    oid = (await state.get_data())["order_id"]
    status = await check_nobitex_payment_status(payment_id=oid)
    if status == "paid":
        await call.message.edit_text("✅ پرداخت موفق. اشتراک فعال شد.")
        await state.clear()
    else:
        await call.answer("پرداخت هنوز تایید نشده.", show_alert=True)
