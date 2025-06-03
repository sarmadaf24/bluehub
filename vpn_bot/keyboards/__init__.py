# 📁 vpn_bot/keyboards/__init__.py
# ——— کیبورد منوی اصلی ———
from .main import main_menu_keyboard

# ——— کیبورد انتخاب پروتکل و پرداخت ———
from .buy import (
    protocol_selection_keyboard,
    payment_type_keyboard,
    v2ray_type_keyboard,
)

# ——— کیبورد انتخاب ارز ———
from .currency import currency_selector_keyboard

# ——— کیبورد انتخاب کوین کریپتو ———
from .crypto import get_crypto_coin_keyboard

# ——— کیبورد زبان ———
from .language import (
    language_keyboard,
    top_inline_main_menu,   # در صورت استفاده در جای دیگر
)

