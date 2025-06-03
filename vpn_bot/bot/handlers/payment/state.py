# 📁 vpn_bot/bot/handlers/payment/state.py

from aiogram.fsm.state import StatesGroup, State
from vpn_bot.services.config_builder import generate_config_for_user

class CryptoPaymentStates(StatesGroup):
    waiting_for_payment_code = State()


class CardPaymentStates(StatesGroup):
    waiting_for_receipt = State()
