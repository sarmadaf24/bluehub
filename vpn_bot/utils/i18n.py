# 📁 vpn_bot/utils/i18n.py

import os
import json
import logging
from functools import lru_cache
from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.user import User
from vpn_bot.context.lang_context import current_lang

logger = logging.getLogger("i18n")

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
LANG_DIR = os.path.join(BASE_DIR, "../langs")

SUPPORTED_LANGUAGES = ["fa", "en", "ar", "tr", "ur", "ru", "fr", "de", "es"]
DEFAULT_LANG = "en"


# ✅ گرفتن زبان ذخیره‌شده کاربر از دیتابیس
async def get_user_lang(user_id: int) -> str:
    async with AsyncSessionLocal() as session:
        user = await session.get(User, user_id)
    return user.lang.strip().lower() if user and user.lang else DEFAULT_LANG


# ✅ کش کردن فایل JSON زبان
@lru_cache(maxsize=20)
def load_lang(lang: str) -> dict:
    path = os.path.join(LANG_DIR, f"{lang}.json")
    try:
        with open(path, "r", encoding="utf-8") as f:
            return json.load(f)
    except FileNotFoundError:
        logger.warning(f"[LANG FILE] Not found: {path}")
        if lang != DEFAULT_LANG:
            return load_lang(DEFAULT_LANG)
        return {}


# ✅ ترجمه کلید
def t(key: str, lang: str = None) -> str:
    lang = (lang or current_lang.get()).lower()
    data = load_lang(lang)

    if key in data:
        return data[key]

    # fallback به انگلیسی
    if lang != DEFAULT_LANG:
        return load_lang(DEFAULT_LANG).get(key, key)

    return f"[{key}]"


# ✅ بررسی مطابقت رشته با ترجمه کلید
def match_key_by_text(key: str, user_text: str) -> bool:
    if not isinstance(user_text, str):
        return False
    user_text = user_text.strip()
    return any(t(key, lang).strip() == user_text for lang in SUPPORTED_LANGUAGES)
