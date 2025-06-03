# 📁 vpn_bot/context/lang_context.py
from contextvars import ContextVar

# زبان فعلی برای همون پیام (نه کل برنامه)
current_lang: ContextVar[str] = ContextVar("current_lang", default="fa")
