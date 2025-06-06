"""Basic live support handlers."""

from aiogram import Router, F
from aiogram.types import CallbackQuery, Message
from aiogram.filters import Command
from aiogram.fsm.context import FSMContext

from vpn_bot.bot_instance import bot
from vpn_bot.ai_support.ai import get_ai_reply, THRESHOLD

from config import ADMIN_CHAT_ID
from vpn_bot.bot.states import SupportStates

router = Router()


@router.message(Command("support"))
async def support_start(message: Message, state: FSMContext) -> None:
    """Entry point for support via command."""
    await state.set_state(SupportStates.ask_topic)
    await message.answer("لطفاً موضوع درخواست خود را وارد کنید.")


@router.callback_query(F.data == "پشتیبانی")
async def support_callback_handler(callback: CallbackQuery, state: FSMContext) -> None:
    """Entry point triggered from inline menu callback."""
    await state.set_state(SupportStates.ask_topic)
    await callback.message.answer("لطفاً موضوع درخواست خود را وارد کنید.")


@router.message(SupportStates.ask_topic, F.text)
async def support_receive_topic(message: Message, state: FSMContext) -> None:
    """Store topic and ask for description."""
    await state.update_data(topic=message.text)
    await state.set_state(SupportStates.receive_description)
    await message.answer("لطفاً توضیح مشکل خود را اعلام کنید.")


@router.message(SupportStates.receive_description, F.text)
async def support_receive_description(message: Message, state: FSMContext) -> None:
    """Forward the first message to admin and switch to live chat."""
    data = await state.get_data()
    topic = data.get("topic", "")
    try:
        await bot.send_message(
            ADMIN_CHAT_ID,
            f"🆕 تیکت جدید:\nموضوع: {topic}\nپیام: {message.text}\nاز کاربر: {message.from_user.id}"
        )
    except Exception as e:
        await message.answer(f"خطا در ارسال پیام به ادمین:\n{e}")
        return

    await state.update_data(user_id=message.from_user.id)
    await state.set_state(SupportStates.live_chat)
    await message.answer("مشکل شما ثبت شد. اکنون می‌توانید چت زنده را ادامه دهید.")


@router.message(SupportStates.live_chat, F.text)
async def user_live_chat_handler(message: Message, state: FSMContext) -> None:
    """Try AI response and forward to admin if confidence is low."""
    data = await state.get_data()
    user_id = data.get("user_id")
    if not user_id:
        return
    try:
        reply = get_ai_reply(message.text, message.from_user.language_code)
        if reply["confidence"] >= THRESHOLD and reply["answer"]:
            await message.answer(reply["answer"])
            return
        await bot.send_message(
            ADMIN_CHAT_ID,
            f"[چت زنده] از کاربر {user_id}: {message.text}"
        )
    except Exception as e:
        await message.answer(f"خطا در ارسال پیام به ادمین:\n{e}")


@router.message(F.chat.type == "private", F.from_user.id == ADMIN_CHAT_ID, F.text)
async def admin_live_chat_handler(message: Message) -> None:
    """Handle replies from admin in the format <user_id>#<answer>."""
    text = message.text
    if "#" not in text:
        await message.answer("فرمت پیام پاسخ اشتباه است؛ لطفاً از <user_id>#<پاسخ> استفاده کنید.")
        return
    parts = text.split("#", 1)
    try:
        target_id = int(parts[0].strip())
        reply_text = parts[1].strip()
    except ValueError:
        await message.answer("شناسهٔ کاربر نامعتبر است. دوباره تلاش کنید.")
        return
    try:
        await message.bot.send_message(target_id, f"[پاسخ ادمین]: {reply_text}")
    except Exception as e:
        await message.answer(f"خطا در ارسال پیام به کاربر:\n{e}")

