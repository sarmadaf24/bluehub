# 📁 scripts/test_all_protocols.py

import asyncio
from vpn_bot.services.config_service import generate_config_for_user
from vpn_bot.db.models import Config

# 💣 پروتکل‌هایی که تست می‌شن
PROTOCOLS = ["vmess", "vless", "trojan", "shadowsocks"]
TEST_USER_ID = 123456999  # ← یک عدد تستی

async def test_all():
    print("🧪 Starting config generation test for all protocols...\n")

    for proto in PROTOCOLS:
        print(f"🔧 Testing protocol: {proto.upper()}...")
        try:
            config: Config = await generate_config_for_user(TEST_USER_ID, proto)
            if config:
                print(f"✅ SUCCESS → {proto.upper()} config generated:")
                print(f"   • UUID/PW: {config.uuid}")
                print(f"   • Server: {config.domain}:{config.port}")
                print(f"   • Exp:    {config.expiration_date}\n")
            else:
                print(f"❌ FAILED → No config returned for protocol: {proto.upper()}\n")

        except Exception as e:
            print(f"🔥 ERROR → {proto.upper()} threw an exception:")
            print(f"    → {e}\n")


if __name__ == "__main__":
    asyncio.run(test_all())
