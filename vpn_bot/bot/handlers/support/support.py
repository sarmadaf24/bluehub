# 📁 /root/bluehub/vpn_bot/bot/handlers/support/support.py

from aiogram import Router, F
from aiogram.types import Message, InlineKeyboardMarkup, InlineKeyboardButton
from aiogram.filters import Command
from aiogram.fsm.context import FSMContext
from datetime import datetime
import logging

from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.support import SupportTicket, SupportMessage
from config import ADMIN_CHAT_ID
from vpn_bot.utils.i18n import t

router = Router()
print("📦 support.py router loaded ✅")


# 1. Entry point: user sends /support
@router.message(Command("support"))
async def support_start(message: Message, state: FSMContext):
    await state.set_state("waiting_subject")
    await message.answer(
        "لطفاً موضوع پشتیبانی خود را ارسال کنید.",
    )

# 2. Receive the subject (any text)
@router.message(F.text, F.state == "waiting_subject")
async def process_subject(message: Message, state: FSMContext):
    await state.update_data(subject=message.text)
    await state.set_state("waiting_description")
    await message.answer(
        "حالا توضیحات مشکل را بفرستید."
    )

# 3. Receive the description and create the ticket
@router.message(F.text, F.state == "waiting_description")
async def process_description(message: Message, state: FSMContext):
    data = await state.get_data()
    subject = data["subject"]
    description = message.text

    # Persist to DB
    async with AsyncSessionLocal() as session:
        # Create ticket
        ticket = SupportTicket(
            user_id=message.from_user.id,
            status="open",
            created_at=datetime.utcnow(),
            agent_id=None,
            question=subject
        )
        session.add(ticket)
        await session.commit()
        await session.refresh(ticket)

        # Create first message
        support_msg = SupportMessage(
            user_id=message.from_user.id,
            ticket_id=ticket.id,
            from_user="user",
            content=description,
            timestamp=datetime.utcnow()
        )
        session.add(support_msg)
        await session.commit()

    # Build “reply” button for admin
    markup = InlineKeyboardMarkup(
        inline_keyboard=[
            [
                InlineKeyboardButton(
                    text="✏️ پاسخ دهید",
                    callback_data=f"support:reply:{ticket.id}"
                )
            ]
        ]
    )

    # Send notification to admin
    try:
        await message.bot.send_message(
            chat_id=ADMIN_CHAT_ID,
            text=(
                f"🆕 تیکت جدید\n"
                f"👤 کاربر: @{message.from_user.username or message.from_user.id}\n"
                f"📝 موضوع: {subject}\n"
                f"💬 توضیحات: {description}"
            ),
            reply_markup=markup
        )
    except Exception:
        logging.exception("❌ خطا در ارسال تیکت به ادمین")
        await message.answer(
            "❌ متأسفانه ارسال به پشتیبانی با خطا مواجه شد. لطفاً بعداً تلاش کنید."
        )
        await state.clear()
        return

    # Acknowledge to user
    await message.answer(f"✅ تیکت شما ثبت شد: #{ticket.id}")
    await state.clear()


