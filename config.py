# 📁 /root/bluehub/config.py

import os
from dotenv import load_dotenv

# بارگذاری متغیرهای محیطی از .env
load_dotenv()

def getenv(key: str, default=None, required=False, cast_type=str):
    value = os.getenv(key, default)
    if required and not value:
        raise ValueError(f"❌ ENV key missing: {key}")
    if cast_type and value is not None:
        try:
            return cast_type(value)
        except Exception:
            raise ValueError(f"❌ ENV key '{key}' must be {cast_type}")
    return value

# ========================
# 🤖 Telegram Bot Settings
# ========================
BOT_TOKEN = getenv("BOT_TOKEN", required=True)
# از python-dotenv برای بارگذاری ADMIN_IDS استفاده می‌کنیم
ADMIN_IDS = [
    int(x)
    for x in os.getenv("ADMIN_IDS", "").split(",")
    if x.strip().isdigit()
]
ADMIN_CHAT_ID = int(os.getenv("ADMIN_CHAT_ID", 0))

# ====================
# 🛢️ Database Settings
# ====================
DATABASE_URL = getenv("DATABASE_URL", required=True)
ALEMBIC_DATABASE_URL = getenv("ALEMBIC_DATABASE_URL", default=DATABASE_URL)

# ====================
# 💳 Payment Gateways
# ====================
CARD_NUMBER      = getenv("CARD_NUMBER", required=True)
CARD_HOLDER      = getenv("CARD_HOLDER", required=True)
CARD_BANK_NAME   = getenv("CARD_BANK_NAME", required=True)
ZARINPAL_MERCHANT_ID = getenv("ZARINPAL_MERCHANT_ID")

#NOWPAYMENTS
NOWPAYMENTS_API_KEY  = getenv("NOWPAYMENTS_API_KEY", required=True)

# Nobitex
NOBITEX_API_KEY     = getenv("NOBITEX_API_KEY", required=True)
NOBITEX_API_SECRET  = getenv("NOBITEX_API_SECRET", required=True)
NOBITEX_BASE_URL    = getenv("NOBITEX_BASE_URL", default="https://api.nobitex.ir")

# Wallex
WALLEX_API_KEY      = getenv("WALLEX_API_KEY", required=True)
WALLEX_BASE_URL     = getenv("WALLEX_BASE_URL", default="https://api.wallex.ir")

# Exir
EXIR_API_KEY        = getenv("EXIR_API_KEY", required=True)
EXIR_BASE_URL       = getenv("EXIR_BASE_URL", default="https://api.exir.io")
EXIR_API_SECRET     = getenv("EXIR_API_SECRET", required=True)
# ======================
# ⚙️ General Application
# ======================
ENVIRONMENT = getenv("ENV", default="development")
LOG_LEVEL   = getenv("LOG_LEVEL", default="INFO")
PARSE_MODE  = getenv("PARSE_MODE", default="HTML").upper()

# ========================
# ✅ Local Debug (Optional)
# ========================
if __name__ == "__main__":
    print("🔐 TEST ENV VARS")
    print("BOT_TOKEN          =", BOT_TOKEN[:10] + "..." if BOT_TOKEN else "❌ NOT SET")
    print("DATABASE_URL       =", DATABASE_URL)
    print("ALEMBIC_DATABASE_URL =", ALEMBIC_DATABASE_URL)
    print("NOWPAYMENTS_API_KEY =", NOWPAYMENTS_API_KEY)

# ==========================
# 🌐 XUI Panel Access
# ==========================
XUI_PANEL_HOST = getenv("XUI_PANEL_HOST", required=True).strip()
if not XUI_PANEL_HOST.startswith(("http://", "https://")):
    XUI_PANEL_HOST = "https://" + XUI_PANEL_HOST

XUI_USERNAME   = getenv("XUI_USERNAME", required=True)
XUI_PASSWORD   = getenv("XUI_PASSWORD", required=True)

# ==========================
# 📧 Email & Trial Settings
# ==========================
SMTP_HOST     = getenv("SMTP_HOST",     required=True)
SMTP_PORT     = getenv("SMTP_PORT",     default=587,    cast_type=int)
SMTP_USER     = getenv("SMTP_USER",     required=True)
SMTP_PASS     = getenv("SMTP_PASS",     required=True)
EMAIL_FROM    = getenv("EMAIL_FROM",    required=True)
# برای سازگاری با email_service.py:
SMTP_SENDER   = EMAIL_FROM

# آدرس front-end برای لینک تأیید ایمیل
FRONTEND_URL  = getenv("FRONTEND_URL",  required=True)

# بقیه تنظیمات…
WEBHOOK_URL   = getenv("WEBHOOK_URL",   required=True)
SECRET_KEY    = getenv("SECRET_KEY",    required=True)
ADMIN_CHAT_ID = getenv("ADMIN_CHAT_ID", required=True, cast_type=int)
# ==========================
# 🔧 XUI Panel Test Access
# ==========================
TEST_XUI_PANEL_HOST = getenv("TEST_XUI_PANEL_HOST", required=True).strip()
if not TEST_XUI_PANEL_HOST.startswith(("http://", "https://")):
    TEST_XUI_PANEL_HOST = "https://" + TEST_XUI_PANEL_HOST

TEST_XUI_USERNAME   = getenv("TEST_XUI_USERNAME",     required=True)
TEST_XUI_PASSWORD   = getenv("TEST_XUI_PASSWORD",     required=True)

# ==========================
# 🔍 Trial Inbound Override
# ==========================
TEST_TRIAL_INBOUND_ID = getenv(
    "TEST_TRIAL_INBOUND_ID",
    default=None,
    cast_type=lambda v: int(v) if v is not None else None
)
