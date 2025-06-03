# 🔧 test_add_client.py
import asyncio
from vpn_bot.services.panel_client import PanelService

async def test_add():
    panel = PanelService()
    await panel.login()
    ok = await panel.add_client_to_inbound(2, {
        "clients": [{
            "id": "123e4567-e89b-12d3-a456-426614174000",
            "email": "test@bot"
        }]
    })
    print("✅ Success" if ok else "❌ Failed")

asyncio.run(test_add())
