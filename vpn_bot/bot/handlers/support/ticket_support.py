from aiogram import Router, F
from aiogram.types import Message
from aiogram.filters import Command
from aiogram.fsm.context import FSMContext
from aiogram.types import ReplyKeyboardRemove

from vpn_bot.bot.states import SupportStates
from vpn_bot.services.support_service import (
    save_ticket,
    assign_ticket,
    get_active_ticket_for_operator,
    get_user_for_ticket,
)
from vpn_bot.bot_instance import bot
from vpn_bot.support_settings import get_next_operator, OPERATORS
import logging

router = Router()
logger = logging.getLogger(__name__)

@router.message(Command("support"))
@router.message(lambda m: m.text == "پشتیبانی")
async def enter_support(message: Message, state: FSMContext):
    await message.answer("لطفاً موضوع تیکت را وارد کنید:", reply_markup=ReplyKeyboardRemove())
    await state.set_state(SupportStates.waiting_for_subject)


@router.message(SupportStates.waiting_for_subject)
async def got_subject(message: Message, state: FSMContext):
    await state.update_data(subject=message.text)
    await message.answer("لطفاً توضیحات خود را وارد کنید:")
    await state.set_state(SupportStates.waiting_for_description)


@router.message(SupportStates.waiting_for_description)
async def got_description(message: Message, state: FSMContext):
    data = await state.get_data()
    subject = data.get("subject", "")
    description = message.text
    user_id = message.from_user.id

    ticket_id = await save_ticket(user_id=user_id, subject=subject, description=description)

    operator_id = get_next_operator()
    if operator_id is not None:
        await assign_ticket(ticket_id, operator_id)
        try:
            await bot.send_message(
                operator_id,
                f"تیکت جدید #{ticket_id}\nموضوع: {subject}\n{description}\nکاربر: {user_id}"
            )
        except Exception as e:
            logger.error("خطا در ارسال پیام به اپراتور %s: %s", operator_id, e)
    else:
        logger.error("هیچ اپراتوری تعریف نشده است")

    await message.answer(f"تیکت شما ثبت شد. شناسه: {ticket_id}")
    await state.clear()


@router.message(lambda m: m.from_user.id in OPERATORS)
async def operator_message(message: Message):
    operator_id = message.from_user.id
    ticket_id = await get_active_ticket_for_operator(operator_id)
    if not ticket_id:
        return
    user_id = await get_user_for_ticket(ticket_id)
    if not user_id:
        return
    try:
        await bot.send_message(user_id, message.text)
    except Exception as e:
        logger.error("خطا در ارسال پیام اپراتور %s به کاربر %s: %s", operator_id, user_id, e)
