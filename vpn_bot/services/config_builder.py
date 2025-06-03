# File: vpn_bot/services/config_builder.py

import json
import uuid
import logging
from datetime import datetime, timedelta

from sqlalchemy import select
from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.server import Server
from vpn_bot.db.models.config import Config
from vpn_bot.services.panel_service import PanelService, get_plan_by_id
from vpn_bot.services.connection_service import generate_connection_link

logger = logging.getLogger("config-builder")


from datetime import datetime, timedelta
from vpn_bot.db.models.config import Config

async def save_config_for_user(
    user_id: int,
    plan_id: int,
    uuid: str,
    server_id: int,
    v2ray_type: str,
    raw_link: str,
    port: int
) -> Config | None:
    # ۱) بارگذاری پلن
    plan = await get_plan_by_id(plan_id)
    if not plan:
        logger.error(f"[SAVE_CONFIG] Plan {plan_id} not found")
        return None

    # ۲) محاسبه انقضا و حجم
    expiration = datetime.utcnow() + timedelta(days=plan.duration_days)
    transfer_bytes = plan.volume_gb * 1024**3 if plan.volume_gb is not None else None

    # ۳) ایجاد Config با plan_type و is_trial
    cfg = Config(
        user_id=user_id,
        protocol=v2ray_type,
        name=f"{v2ray_type.upper()}-{user_id}-{int(datetime.utcnow().timestamp())}",
        created_at=datetime.utcnow(),
        expiration_date=expiration,
        port=port,
        uuid=uuid,
        domain=raw_link,
        config_name=f"Plan-{plan_id}",
        transfer_enable=transfer_bytes,
        plan_type=plan.plan_type,
        is_trial=(plan.plan_type == "trial")
    )
    async with AsyncSessionLocal() as session:
        session.add(cfg)
        await session.commit()
        await session.refresh(cfg)
        logger.info(f"[SAVE_CONFIG] saved config id={cfg.id} for user={user_id}")
        return cfg


async def create_config(
    user_id: int,
    plan_id: int,
    protocol: str
) -> Config | None:
    """
    جریان کامل ساخت Config:
      1) انتخاب سرور مناسب
      2) لاگین به پنل
      3) افزودن کلاینت با محدودیت پلن
      4) دریافت لینک اتصال (یا کانفیگ SS)
      5) ذخیرهٔ رکورد در DB
      6) بازگرداندن شیٔ Config
    """
    # ۱) pick server
    async with AsyncSessionLocal() as sess:
        q = (
            select(Server)
            .where(
                Server.protocol == protocol,
                Server.is_active.is_(True),
                Server.current_clients < Server.max_clients
            )
            .order_by(Server.current_clients.asc())
        )
        server = (await sess.execute(q)).scalars().first()
    if not server:
        logger.error(f"[CREATE_CONFIG] No server for protocol {protocol}")
        return None

    # ۲) login
    panel = PanelService(
        base_url=f"https://{server.domain}:{server.port}",
        username=server.panel_username,
        password=server.panel_password,
        panel_path=server.panel_path
    )
    if not await panel.login():
        logger.error("[CREATE_CONFIG] Panel login failed")
        return None

    # ۳) add client
    client_id = str(uuid.uuid4())
    plan = await get_plan_by_id(plan_id)
    expiry_ms = int((datetime.utcnow() + timedelta(days=plan.duration_days)).timestamp() * 1000)
    transfer_bytes = plan.volume_gb * 1024**3 if plan.volume_gb is not None else None

    client_payload = {
        "id":             client_id,
        "email":          f"{user_id}@{protocol}",
        "password":       client_id,
        "aid":            0,
        "flow":           "",
        "security":       "auto",
        "limitIp":        0,
        "enable":         True,
        "subId":          uuid.uuid4().hex[:16],
        "tgId":           "",
        "reset":          0,
        **({"expiryTime":     expiry_ms}     if expiry_ms else {}),
        **({"transferEnable": transfer_bytes} if transfer_bytes is not None else {}),
    }
    if not await panel.add_client_to_inbound(server.id, client_payload):
        logger.error("[CREATE_CONFIG] Failed to add client")
        await panel.close()
        return None

    # ۴) generate connection link
    if protocol == "shadowsocks":
        # استفاده از API X-UI برای SS
        link = await panel.download_client_config(server.id, client_id, protocol)
    else:
        link = generate_connection_link(
            protocol=protocol,
            uuid=client_id,
            domain=server.domain,
            port=server.port,
            host=server.path if protocol in ("vless", "vmess") else None,
            path=server.path if protocol in ("vless", "vmess") else None,
            encryption=server.encryption
        )

    await panel.reload_panel()
    await panel.close()

    # ۵) save to DB
    config = await save_config_for_user(
        user_id=user_id,
        plan_id=plan_id,
        client_id=client_id,
        server_domain=server.domain,
        port=server.port,
        protocol=protocol
    )
    return config

# aliases for backward compatibility
build_user_config        = create_config
generate_config_for_user = create_config
