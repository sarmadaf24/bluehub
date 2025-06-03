# 📁 vpn_bot/db/seed/seed_servers_from_json.py

import json
import os
from vpn_bot.db.models.server import Server
from vpn_bot.db.core.session import AsyncSessionLocal

BASE_DIR = os.path.dirname(__file__)
JSON_FILE = os.path.join(BASE_DIR, "servers.json")


async def run(file_path=JSON_FILE):
    with open(file_path, "r", encoding="utf-8") as f:
        servers = json.load(f)

    async with AsyncSessionLocal() as session:
        for s in servers:
            exists = await session.execute(
                Server.__table__.select().where(Server.port == s["port"])
            )
            if exists.first():
                print(f"⚠️  Skipped (Exists): {s['name']} [{s['port']}]")
                continue

            server = Server(
                name=s["name"],
                ip=s["ip"],
                port=s["port"],
                protocol=s["protocol"],
                panel_path=s["panel_path"],
                domain=s.get("domain"),
                is_active=True,
                current_clients=0,
                max_clients=s.get("max_clients", 100)
            )
            session.add(server)
            print(f"✅ Added: {s['name']}")

        await session.commit()
        print("🎉 All new servers seeded!")
