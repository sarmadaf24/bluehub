import asyncio
from vpn_bot.services.panel_client import PanelService

async def test():
    client = PanelService(
        "https://bluehub1.varzeshnews24.online:54322",
        "admin",
        "admin123",
        "/aOQyy6wVYyI7M9T"
    )
    if await client.login():
        inbounds = await client.get_inbounds()
        print("✅ Inbounds:", inbounds)
    else:
        print("❌ Login failed")

asyncio.run(test())

