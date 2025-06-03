# vpn_bot/services/user_trial_service.py

import logging
from uuid import uuid4
from datetime import datetime, timedelta, timezone
from aiogram import Bot
from sqlalchemy import update

from config import (
    TEST_XUI_PANEL_HOST,
    TEST_XUI_USERNAME,
    TEST_XUI_PASSWORD,
    TEST_TRIAL_INBOUND_ID,
)
from vpn_bot.services.test_panel_service import TestPanelService
from vpn_bot.services.trial_config_builder import save_trial_config
from vpn_bot.services.connection_service import send_config_to_user
from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.user import User

logger = logging.getLogger("user-trial")


async def create_and_send_trial_config(user_id: int, bot: Bot):
    logger.info(f"[TRIAL] آغاز فرآیند تریال برای کاربر: {user_id}")
    # تنظیمات تریال
    days = 1
    bytes_limit = 600 * 1024**2    
    protocol = "vless"
    lang = "fa"

    # 1) لاگین به پنل تست
    panel = TestPanelService(
        TEST_XUI_PANEL_HOST,
        TEST_XUI_USERNAME,
        TEST_XUI_PASSWORD,
    )
    if not await panel.login():
        logger.error("[TRIAL] ورود به پنل تست ناموفق")
        raise RuntimeError("Panel login failed")
    logger.info("[TRIAL] ورود به پنل تست موفق")

    # 2) دریافت لیست inbounds
    inbounds = await panel.get_inbounds()
    logger.info("[TRIAL] inbounds دریافتی: %s", inbounds)
    if TEST_TRIAL_INBOUND_ID:
        inbound = next((i for i in inbounds if i.get("id") == TEST_TRIAL_INBOUND_ID), None)
    else:
        inbound = next((i for i in inbounds if i.get("protocol") == protocol), None)
    if not inbound:
        logger.error(f"[TRIAL] inbound مناسب پیدا نشد (protocol={protocol}, id={TEST_TRIAL_INBOUND_ID})")
        await panel.close()
        raise RuntimeError("No suitable inbound for trial")
    logger.info(f"[TRIAL] inbound انتخاب‌شده: {inbound}")

    panel_id = inbound["id"]
    server = inbound.get("server")
    port = inbound.get("port")
    encryption = inbound.get("encryption")
    host = inbound.get("host")
    path = inbound.get("path", "")

    # 3) اضافه کردن کلاینت به inbound
    expiry_ms = int((datetime.utcnow() + timedelta(days=days))
                    .replace(tzinfo=timezone.utc).timestamp() * 1000)
    client_id = str(uuid4())
    payload = {
        "id": client_id,
        "email": client_id,
        "password": client_id,
        "flow": "",
        "security": "tls",
        "limitIp": 0,
        "enable": True,
        "subId": str(uuid4()),
        "tgId": "",
        "reset": 0,
        "expiryTime": expiry_ms,
        "totalGB": bytes_limit,
    }
    if not await panel.add_client_to_inbound(panel_id, payload):
        logger.error("[TRIAL] افزودن کاربر به inbound ناموفق")
        await panel.close()
        raise RuntimeError("add_client_to_inbound failed")
    logger.info("[TRIAL] کاربر به inbound اضافه شد")

    await panel.reload_panel()
    await panel.update_client(panel_id, client_id, payload)
    await panel.reload_panel()
    logger.info("[TRIAL] اطلاعات client به‌روزرسانی شد")

    # 4) تولید لینک
    link = panel.generate_v2ray_link(
        protocol=protocol,
        uuid=client_id,
        domain=server,
        port=port,
        encryption=encryption,
        password=client_id,
        host=host,
        path=path,
    )
    logger.info(f"[TRIAL] لینک تولید شد: {link}")

    # 5) ذخیره در دیتابیس
    cfg = await save_trial_config(
        user_id=user_id,
        client_id=client_id,
        server=server,
        port=port,
        domain=server,
        bytes_limit=bytes_limit,
        days=days,
        plan_type="trial",
        is_trial=True
    )
    logger.info("💾 [TRIAL] Trial config saved (id=%s)", cfg.id)

    # 6) ارسال کانفیگ به کاربر
    await send_config_to_user(
        user_id=user_id,
        config=cfg,
        link=link,
        lang=lang
    )
    logger.info("📤 [TRIAL] Trial config sent to user %s", user_id)

    # ۷) علامت‌گذاری استفاده از تریال
    async with AsyncSessionLocal() as session:
        await session.execute(
            update(User)
            .where(User.user_id == user_id)
            .values(trial_used=True)
        )
        await session.commit()
    logger.info("[TRIAL] flag trial_used برای user %s ست شد", user_id)

    await panel.close()
    logger.info("[TRIAL] پنل تست بسته شد")
