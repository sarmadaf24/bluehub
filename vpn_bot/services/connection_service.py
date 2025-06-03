#/root/bluehub/vpn_bot/services/connection_service.py

import qrcode
import io
import base64
import json
import logging
from html import escape
from aiogram import Bot
from aiogram.types import BufferedInputFile, InputFile
from aiogram.exceptions import TelegramBadRequest
from aiogram.client.default import DefaultBotProperties
from config import BOT_TOKEN
from vpn_bot.utils.i18n import t

logger = logging.getLogger("connection-service")

bot = Bot(
    token=BOT_TOKEN,
    default=DefaultBotProperties(parse_mode="HTML")
)

# 🔗 لینک‌ساز براساس پروتکل
def generate_connection_link(
    protocol: str,
    uuid: str,
    domain: str,
    port: int,
    host: str = "",
    path: str = "",
    encryption: str | None = None,
    password: str | None = None,
) -> str:
    """
    ساخت لینک‌ اتصال برای پروتکل‌های VLESS, VMess, Trojan, Shadowsocks
    پارامترها:
      - protocol: "vless" | "vmess" | "trojan" | "shadowsocks"
      - uuid: شناسه کلاینت
      - domain, port: آدرس و پورت سرور
      - host, path: برای WebSocket (پروتکل‌های VLESS/VMess)
      - encryption, password: فقط برای Shadowsocks
    """
    if protocol == "vless":
        qs = {
            "encryption": "none",
            "security": "tls",
            "type": "ws",
            **({"host": host} if host else {}),
            **({"path": path} if path else {}),
        }
        return f"vless://{uuid}@{domain}:{port}?{urlencode(qs)}#BlueHub"

    if protocol == "vmess":
        cfg = {
            "v": "2",
            "ps": "BlueHub",
            "add": domain,
            "port": str(port),
            "id": uuid,
            "aid": "0",
            "net": "ws",
            "type": "none",
            "host": host,
            "path": path,
            "tls": "tls"
        }
        b = base64.b64encode(json.dumps(cfg, separators=(",", ":")).encode()).decode()
        return f"vmess://{b}"

    if protocol == "trojan":
        return f"trojan://{uuid}@{domain}:{port}?security=tls#BlueHub"

    if protocol == "shadowsocks":
        if not (encryption and password):
            return "⚠️ Shadowsocks config not found"
        userinfo = f"{encryption}:{password}"
        b64 = base64.urlsafe_b64encode(userinfo.encode()).decode().rstrip("=")
        return f"ss://{b64}@{domain}:{port}#BlueHub"

    return "❌ Unsupported protocol"

# 🖼️ تولید QR به صورت عکس (برای ارسال تلگرام)
def generate_qr_image(link: str) -> BufferedInputFile:
    img = qrcode.make(link)
    bio = io.BytesIO()
    try:
        img.save(bio, format="PNG")
    except TypeError:
        # PyPNGImage.save doesn’t accept format keyword
        img.save(bio)
    bio.seek(0)
    return BufferedInputFile(bio.read(), filename="config_qr.png")

# 📡 تولید QR به صورت Base64 (برای API یا نمایش در سایت)
def generate_qr_base64(link: str) -> str:
    img = qrcode.make(link)
    buffered = io.BytesIO()
    try:
        img.save(buffered, format="PNG")
    except TypeError:
        buffered = io.BytesIO()
        img.save(buffered)
    return "data:image/png;base64," + base64.b64encode(buffered.getvalue()).decode()


# 📨 ارسال پیام امن + QR به کاربر
async def send_config_message(user_id: int, config: object, lang: str = "fa"):
    link = generate_connection_link(config)
    config_name = escape(str(getattr(config, "config_name", "-")))
    protocol = escape(str(getattr(config, "protocol", "")).upper())
    domain = escape(str(getattr(config, "domain", "-")))
    expiration = escape(str(getattr(config, "expiration_date", "-")))
    link_escaped = escape(link)

    message = (
        f"✅ <b>{t('payment_success', lang)}</b>\n\n"
        f"📦 <b>{t('plan', lang)}:</b> {config_name}\n"
        f"🔌 <b>{t('protocol', lang)}:</b> {protocol}\n"
        f"🌐 <b>{t('server', lang)}:</b> {domain}\n"
        f"📅 <b>{t('expires_at', lang)}:</b> {expiration}\n\n"
        f"🔗 <b>{t('connection_link', lang)}:</b>\n<code>{link_escaped}</code>\n\n"
        f"📲 {t('scan_qr_code', lang)}"
    )

    try:
        qr = generate_qr_image(link)
        logger.info(f"📤 Sending config to user {user_id}")
        await bot.send_photo(chat_id=user_id, photo=qr, caption=message, parse_mode="HTML")
    except TelegramBadRequest as e:
        logger.warning(f"⚠️ Telegram fallback: {str(e)}")
        await bot.send_message(chat_id=user_id, text=f"{t('connection_link', lang)}:\n{link}", parse_mode="HTML")

async def send_config_to_user(user_id: int, config: object, link: str, lang: str = "fa"):
    """
    📦 ارسال پیام + QR به کاربر با HTML escape و fallback امن.
    """
    try:
        config_name = escape(str(getattr(config, "config_name", "-")))
        protocol = escape(str(getattr(config, "protocol", "")).upper())
        domain = escape(str(getattr(config, "domain", "-")))
        expiration = escape(str(getattr(config, "expiration_date", "-")))
        link_escaped = escape(link)

        message = (
            f"✅ <b>{t('payment_success', lang)}</b>\n\n"
            f"📦 <b>{t('plan', lang)}:</b> {config_name}\n"
            f"🔌 <b>{t('protocol', lang)}:</b> {protocol}\n"
            f"🌐 <b>{t('server', lang)}:</b> {domain}\n"
            f"📅 <b>{t('expires_at', lang)}:</b> {expiration}\n\n"
            f"🔗 <b>{t('connection_link', lang)}:</b>\n<code>{link_escaped}</code>\n\n"
            f"📲 {t('scan_qr_code', lang)}"
        )

        qr = generate_qr_image(link)
        logger.info(f"📤 Sending config to user {user_id}")

        await bot.send_photo(
            chat_id=user_id,
            photo=qr,
            caption=message,
            parse_mode="HTML"
        )

    except TelegramBadRequest as e:
        logger.warning(f"⚠️ Fallback to text due to TelegramBadRequest: {str(e)}")
        await bot.send_message(
            chat_id=user_id,
            text=f"{t('connection_link', lang)}:\n{link}",
            parse_mode="HTML"
        )
