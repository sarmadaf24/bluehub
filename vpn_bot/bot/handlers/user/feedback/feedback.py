# 📁 vpn_bot/bot/handlers/user/feedback.py

from aiogram import Router, F
from aiogram.types import CallbackQuery, InlineKeyboardButton, InlineKeyboardMarkup, Message
from aiogram.fsm.context import FSMContext
from aiogram.fsm.state import StatesGroup, State

from vpn_bot.utils.i18n import t

router = Router()
print("📦 feedback.py router loaded ✅")

class FeedbackStates(StatesGroup):
    rating      = State()  # امتیاز 1–5
    feature     = State()  # بهترین ویژگی
    improvement = State()  # چه چیزی نیاز به بهبود دارد
    comment     = State()  # پیام آزاد
    finished    = State()  # پایان

# ─── شروع بازخورد ──────────────────────────────────────────────────────────────
@router.callback_query(F.data == "trigger_feedback")
async def feedback_start(cb: CallbackQuery, state: FSMContext):
    # پیام اول: امتیاز
    kb = InlineKeyboardMarkup(inline_keyboard=[
        [InlineKeyboardButton("⭐☆☆☆☆", callback_data="feedback:rating:1")],
        [InlineKeyboardButton("⭐⭐☆☆☆", callback_data="feedback:rating:2")],
        [InlineKeyboardButton("⭐⭐⭐☆☆", callback_data="feedback:rating:3")],
        [InlineKeyboardButton("⭐⭐⭐⭐☆", callback_data="feedback:rating:4")],
        [InlineKeyboardButton("⭐⭐⭐⭐⭐", callback_data="feedback:rating:5")],
    ])
    await state.set_state(FeedbackStates.rating)
    await cb.message.answer(
        text="لطفاً به سرویس ما از 1 تا 5 ستاره امتیاز بدهید:",
        reply_markup=kb
    )
    await cb.answer()

# ─── دریافت امتیاز و پرسش ویژگی جذاب ─────────────────────────────────────────
@router.callback_query(F.data.startswith("feedback:rating:"))
async def feedback_rating(cb: CallbackQuery, state: FSMContext):
    rating = int(cb.data.split(":")[-1])
    await state.update_data(rating=rating)

    kb = InlineKeyboardMarkup(inline_keyboard=[
        [InlineKeyboardButton("🎯 سرعت",        callback_data="feedback:feature:speed")],
        [InlineKeyboardButton("🔒 امنیت",       callback_data="feedback:feature:security")],
        [InlineKeyboardButton("📱 سادگی",       callback_data="feedback:feature:usability")],
        [InlineKeyboardButton("💸 قیمت مناسب",  callback_data="feedback:feature:price")],
    ])
    await state.set_state(FeedbackStates.feature)
    await cb.message.answer(
        text="کدام یک از این ویژگی‌ها برایتان مهم‌تر بود؟",
        reply_markup=kb
    )
    await cb.answer()

# ─── دریافت بهترین ویژگی و پرسش نقاط ضعف ─────────────────────────────────────
@router.callback_query(F.data.startswith("feedback:feature:"))
async def feedback_feature(cb: CallbackQuery, state: FSMContext):
    feature = cb.data.split(":")[-1]
    await state.update_data(feature=feature)

    kb = InlineKeyboardMarkup(inline_keyboard=[
        [InlineKeyboardButton("🐌 کندی سرعت",      callback_data="feedback:improve:slow")],
        [InlineKeyboardButton("⚠️ قطعی اتصال",   callback_data="feedback:improve:disconnect")],
        [InlineKeyboardButton("🙋 پشتیبانی",      callback_data="feedback:improve:support")],
        [InlineKeyboardButton("💲 قیمت",           callback_data="feedback:improve:price")],
    ])
    await state.set_state(FeedbackStates.improvement)
    await cb.message.answer(
        text="کدام‌یک از این موارد نیاز به بهبود بیشتر دارد؟",
        reply_markup=kb
    )
    await cb.answer()

# ─── دریافت نقطه ضعف و درخواست کامنت آزاد ──────────────────────────────────
@router.callback_query(F.data.startswith("feedback:improve:"))
async def feedback_improve(cb: CallbackQuery, state: FSMContext):
    improvement = cb.data.split(":")[-1]
    await state.update_data(improvement=improvement)

    await state.set_state(FeedbackStates.comment)
    await cb.message.answer("لطفاً یک جمله کوتاه در مورد تجربه‌تان بنویسید:")
    await cb.answer()

# ─── دریافت کامنت آزاد و پایان با کد تخفیف ───────────────────────────────────
@router.message(FeedbackStates.comment)
async def feedback_comment(msg: Message, state: FSMContext):
    await state.update_data(comment=msg.text)

    data = await state.get_data()
    # اینجا معمولاً داده‌ها را در DB ذخیره می‌کنیم...
    # save_feedback(user_id=msg.from_user.id, **data)

    # ارسال کد تخفیف به کاربر
    await msg.answer(
        "🎉 متشکریم از بازخورد شما!\n"
        "کد تخفیف ۱۰٪ شما:\n\n"
        "`BLUEHUB10`\n\n"
        "برای خرید بعدی استفاده کنید.",
        parse_mode="Markdown"
    )

    await state.clear()

# دستۀ فیلتر callback نادیده‌افتاده
@router.message()
async def catch_all(msg: Message):
    # هر واکنش نامربوط را رد کنیم یا توضیح دهیم
    return
