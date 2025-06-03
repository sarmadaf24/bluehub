# vpn_bot/bot/handlers/user/trial_email.py

import re
import logging
from datetime import datetime, timezone

from aiogram import Router, F, Bot
from aiogram.filters.command import Command
from aiogram.types import Message, CallbackQuery, InlineKeyboardMarkup, InlineKeyboardButton
from aiogram.fsm.context import FSMContext
from sqlalchemy import select, desc, update
from sqlalchemy.exc import NoResultFound

from vpn_bot.bot.states import TrialStates
from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.user import User
from vpn_bot.db.models.email_token import EmailToken
from vpn_bot.services.email_service import generate_email_token, send_verification_email
from vpn_bot.services.user_trial_service import create_and_send_trial_config
from vpn_bot.keyboards import main_menu_keyboard
from config import BOT_TOKEN


logger = logging.getLogger("trial-email")

router = Router(name="trial_email")
print("📦 trial_email.py router loaded ✅")

EMAIL_RE = re.compile(r"[^@]+@[^@]+\.[^@]+")


@router.callback_query(F.data == "trial_email")
async def enter_trial_email(cb: CallbackQuery, state: FSMContext):
    logger.info("[TRIAL-EMAIL] کاربر وارد مرحله وارد کردن ایمیل شد: %s", cb.from_user.id)
    await state.clear()
    await cb.message.edit_text("📧 لطفا ایمیل خود را وارد کنید:", reply_markup=None)
    await state.set_state(TrialStates.waiting_for_email)
    await cb.answer()


@router.message(Command("test"))
async def cmd_test(message: Message, state: FSMContext):
    logger.info("[TRIAL-EMAIL] دستور /test دریافت شد از کاربر: %s", message.from_user.id)
    await state.clear()
    await message.answer("📧 لطفا ایمیل خود را وارد کنید:", reply_markup=None)
    await state.set_state(TrialStates.waiting_for_email)


@router.message(TrialStates.waiting_for_email)
async def process_email(message: Message, state: FSMContext):
    user_id = message.from_user.id
    # ➊ اگر قبلاً تست دریافت کرده، درخواست جدید نده
    async with AsyncSessionLocal() as sess:
        usr = await sess.get(User, user_id)
    if usr and usr.trial_used:
        await message.answer("⚠️ شما قبلاً از تست رایگان استفاده کرده‌اید.")
        await state.clear()
        return
    email = message.text.strip()
    logger.info("[TRIAL-EMAIL] ایمیل دریافتی از کاربر %s: %s", user_id, email)

    if not EMAIL_RE.fullmatch(email):
        logger.warning("[TRIAL-EMAIL] ایمیل نامعتبر: %s", email)
        await message.answer("❌ ایمیل وارد شده معتبر نیست، لطفا دوباره وارد کنید:")
        return

    # ۱) باز کردن سشن و بررسی وجود توکن قبلی
    async with AsyncSessionLocal() as sess:
        result = await sess.execute(
            select(EmailToken)
            .where(
                EmailToken.user_id == user_id,
                EmailToken.used == False
            )
            .order_by(desc(EmailToken.created_at))  # جدیدترین اول
            .limit(1)                              # فقط یک ردیف
        )
        existing = result.scalar_one_or_none()

    # ۲) اگر توکن قبلی هنوز مصرف نشده
    if existing:
        logger.info("[TRIAL-EMAIL] توکن قبلی هنوز مصرف نشده برای کاربر %s: %s", user_id, existing.token)
        await message.answer(
            "🔔 شما قبلاً لینک تأیید ایمیل دریافت کرده‌اید.\n"
            "لطفاً ابتدا ایمیل را با لینک ارسالی تأیید کنید، سپس دوباره روی دریافت تست کلیک کنید."
        )
        return

    # ۳) تولید و ارسال توکن جدید
    token = await generate_email_token(user_id)
    logger.info("[TRIAL-EMAIL] توکن جدید برای %s تولید شد: %s", user_id, token)
    await send_verification_email(email, token)
    logger.info("[TRIAL-EMAIL] ایمیل تأیید برای %s ارسال شد به %s", user_id, email)

    kb = InlineKeyboardMarkup(inline_keyboard=[[
        InlineKeyboardButton(text="📨 دریافت تست رایگان", callback_data="get_trial_email")
    ]])
    await message.answer(
        "✅ لینک فعال‌سازی به ایمیل شما ارسال شد.\n"
        "لطفا صندوق ورودی (و پوشه spam) را بررسی کنید و سپس روی دکمه زیر کلیک کنید.",
        reply_markup=kb
    )
    await state.clear()


@router.callback_query(F.data == "get_trial_email")
async def handle_get_trial_email(cb: CallbackQuery):
    user_id = cb.from_user.id
    logger.info("[TRIAL-EMAIL] درخواست دریافت تست برای کاربر: %s", user_id)
    await cb.answer()

    async with AsyncSessionLocal() as sess:
        user = (await sess.execute(
            select(User).where(User.user_id == user_id)
        )).scalar_one_or_none()
    logger.info("[TRIAL-EMAIL] اطلاعات کاربر در DB: %s", user)

    if not user or not user.email_verified_at:
        logger.warning("[TRIAL-EMAIL] ایمیل تأیید نشده یا کاربر پیدا نشد: %s", user_id)
        return await cb.message.answer("❌ لطفا اول ایمیل خود را تایید کنید.")
    if user.trial_used:
        logger.warning("[TRIAL-EMAIL] کاربر قبلاً از تست استفاده کرده: %s", user_id)
        return await cb.message.answer("⚠️ شما قبلاً از تست رایگان استفاده کرده‌اید.")

    bot = Bot(token=BOT_TOKEN)
    try:
        logger.info("[TRIAL-EMAIL] فراخوانی create_and_send_trial_config برای %s", user_id)
        await create_and_send_trial_config(user_id, bot)
        logger.info("[TRIAL-EMAIL] کانفیگ تست ارسال شد برای %s", user_id)
        # —————— افزودن علامت‌گذاری تست استفاده‌شده ——————
        async with AsyncSessionLocal() as sess:
            result = await sess.execute(select(User).where(User.user_id == user_id))
            usr = result.scalar_one()
            usr.trial_used = True
            sess.add(usr)
            await sess.commit()
        # —————————————————————————————————————————————
    except Exception as e:
        logger.error("[TRIAL-EMAIL] خطا هنگام create_and_send_trial_config: %s – %s", user_id, e, exc_info=True)
        await cb.message.answer("⚠️ خطا در ارسال کانفیگ تست. لطفا بعداً تلاش کنید.")
    finally:
        await bot.session.close()
        logger.info("[TRIAL-EMAIL] جلسه ربات بسته شد برای %s", user_id)

    await cb.message.edit_text(
        "✅ کانفیگ تست ۱ روزه (۶۰۰ مگابایت) ارسال شد.",
        reply_markup=main_menu_keyboard()
    )
