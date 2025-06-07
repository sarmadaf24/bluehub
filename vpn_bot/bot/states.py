# 📁 vpn_bot/bot/states.py

from aiogram.fsm.state import State, StatesGroup

class CardPaymentStates(StatesGroup):
    waiting_for_receipt = State()  # 📤 منتظر دریافت رسید کارت به کارت

class TrialStates(StatesGroup):
    waiting_for_email = State()


class SupportStates(StatesGroup):
    """States for user support ticket creation and live chat."""

    # فاز نخست پشتیبانی: دریافت موضوع و توضیح مشکل
    ask_topic = State()
    receive_description = State()
    # پس از ثبت، کاربر وارد چت زنده می‌شود
    live_chat = State()
