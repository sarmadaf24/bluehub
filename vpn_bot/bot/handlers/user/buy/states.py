# 📁 vpn_bot/bot/handlers/user/buy/states.py

from aiogram.fsm.state import StatesGroup, State

class ProtocolStates(StatesGroup):
    choosing_protocol = State()

class V2RayTypeStates(StatesGroup):
    choosing_v2ray = State()

class PlanPaymentStates(StatesGroup):
    choosing_plan   = State()
    confirming_plan = State()

class CryptoPaymentStates(StatesGroup):
    choosing_provider        = State()
    choosing_coin            = State()
    waiting_for_manual_receipt= State()
    waiting_for_payment_code = State()
    waiting_for_txid = State()

class CardPaymentStates(StatesGroup):
    waiting_for_receipt = State()
