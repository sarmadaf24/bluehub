# 📁 test_get_inbounds.py

import asyncio
from vpn_bot.services.panel_client import PanelService
from dotenv import load_dotenv
load_dotenv()
async def run():
    client = PanelService()
    logged = await client.login()
    if not logged:
        print("❌ Login failed")
        return
    inbounds = await client.get_inbounds()
    print("✅ Inbounds:", inbounds)

if __name__ == "__main__":
    asyncio.run(run())
