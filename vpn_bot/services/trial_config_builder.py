# 📁 vpn_bot/services/trial_config_builder.py

from datetime import datetime, timedelta
from vpn_bot.db.models.config import Config
from vpn_bot.db.core.session import AsyncSessionLocal

async def save_trial_config(
    user_id: int,
    client_id: str,
    server: str,
    port: int,
    domain: str,
    bytes_limit: int,
    days: int,
    *,                             # ← everything after این کلیدواژه-only است
    plan_type: str = "trial",      # ← اضافه کنید
    is_trial: bool = True          # ← اضافه کنید
) -> Config:
    now = datetime.utcnow()
    expiry = now + timedelta(days=days)

    cfg = Config(
        user_id=user_id,
        protocol="vless",
        name=f"trial-{user_id}-{int(now.timestamp())}",
        created_at=now,
        expiration_date=expiry,
        port=port,
        uuid=client_id,
        active=True,
        domain=domain,
        config_name=f"{days}d-{bytes_limit//(1024**3)}GB-trial",
        transfer_enable=bytes_limit,
        plan_type=plan_type,    # ← اینجا استفاده می‌شود
        is_trial=is_trial       # ← اینجا استفاده می‌شود
    )

    async with AsyncSessionLocal() as session:
        session.add(cfg)
        await session.commit()
        await session.refresh(cfg)

    return cfg
