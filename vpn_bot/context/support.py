# vpn_bot/bot/context/support.py

from aiogram.fsm.state import State, StatesGroup
from vpn_bot.db.core import AsyncSessionLocal
from vpn_bot.db.models.support import SupportTicket, SupportMessage
from config import ADMIN_CHAT_ID    # ← اینجا اصلاح شد

async_session = AsyncSessionLocal


# اختیاری: اگر کدهای handler شما از async_session استفاده می‌کنند:
async_session = AsyncSessionLocal

class SupportStates(StatesGroup):
    waiting_user_question = State()
    in_chat = State()
    waiting_admin_reply = State()
