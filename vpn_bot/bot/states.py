# 📁 vpn_bot/bot/states.py

from aiogram.fsm.state import State, StatesGroup

class CardPaymentStates(StatesGroup):
    waiting_for_receipt = State()  # 📤 منتظر دریافت رسید کارت به کارت

class TrialStates(StatesGroup):
    waiting_for_email = State()
