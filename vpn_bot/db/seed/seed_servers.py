# 📁 vpn_bot/db/seed/seed_servers.py

from vpn_bot.db.models.server import Server
from vpn_bot.db.models.inbound import Inbound
from vpn_bot.db.core.session import AsyncSessionLocal
from sqlalchemy import select
import asyncio
import sys
import os
sys.path.append(os.path.abspath(os.path.join(
    os.path.dirname(__file__), "../../..")))


servers = [
    {
        "name": "VLESS",
        "ip": "157.180.44.242",
        "port": 443,
        "protocol": "vless",
        "panel_path": "/aOQyy6wVYyI7M9T",
        "domain": "bluehub1.varzeshnews24.online",
        "max_clients": 100
    },
    {
        "name": "VMESS",
        "ip": "157.180.44.242",
        "port": 8080,
        "protocol": "vmess",
        "panel_path": "/aOQyy6wVYyI7M9T",
        "domain": "bluehub1.varzeshnews24.online",
        "max_clients": 100
    },
    {
        "name": "TROJAN",
        "ip": "157.180.44.242",
        "port": 2052,
        "protocol": "trojan",
        "panel_path": "/aOQyy6wVYyI7M9T",
        "domain": "bluehub1.varzeshnews24.online",
        "max_clients": 100
    },
    {
        "name": "SHADOWSOCKS",
        "ip": "157.180.44.242",
        "port": 80,
        "protocol": "shadowsocks",
        "panel_path": "/aOQyy6wVYyI7M9T",
        "domain": "bluehub1.varzeshnews24.online",
        "max_clients": 100
    }
]


async def seed_servers():
    async with AsyncSessionLocal() as session:
        for srv in servers:
            # ✅ ساخت Server
            server = Server(
                name=srv["name"],
                ip=srv["ip"],
                port=srv["port"],
                protocol=srv["protocol"],
                panel_path=srv["panel_path"],
                domain=srv["domain"],
                max_clients=srv["max_clients"],
                current_clients=0,
                is_active=True
            )
            session.add(server)

            # ✅ ساخت Inbound اگر قبلاً وجود نداشت
            existing = await session.execute(
                select(Inbound).where(
                    Inbound.port == srv["port"],
                    Inbound.protocol == srv["protocol"]
                )
            )
            if not existing.scalar_one_or_none():
                session.add(Inbound(
                    server=srv["ip"],
                    port=srv["port"],
                    protocol=srv["protocol"]
                ))

        await session.commit()
        print("✅ Servers + Inbounds seeded successfully.")


if __name__ == "__main__":
    asyncio.run(seed_servers())

run = seed_servers
