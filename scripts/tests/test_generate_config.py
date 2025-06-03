# 📁 test_generate_config.py

import os
import asyncio

# 🔐 تنظیم ENV ها
os.environ["PANEL_URL"] = "https://bluehub1.varzeshnews24.online:54322/aOQyy6wVYyI7M9T"
os.environ["PANEL_USERNAME"] = "C1kt5SJPdF"
os.environ["PANEL_PASSWORD"] = "MTJzS5Opyt"

from vpn_bot.services.config_service import generate_config_for_user

async def main():
    user_id = 6727220793  # 🧪 آیدی تستی
    protocol = "vless"     # 🔄 پروتکل تستی

    config = await generate_config_for_user(user_id=user_id, protocol=protocol)
    if config:
        print("✅ Config generated successfully:")
        print("📡 Server:", config.server)
        print("🔌 Port:", config.port)
        print("🆔 UUID:", config.uuid)
        print("📦 Protocol:", config.protocol)
        print("⏳ Expiration:", config.expiration_date)
    else:
        print("❌ Failed to generate config")

asyncio.run(main())
