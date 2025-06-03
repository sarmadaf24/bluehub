# test_panel.py
import asyncio, logging
from urllib.parse import urlparse
from vpn_bot.services.panel_service import PanelService, get_inbound_by_protocol
from config import TEST_XUI_PANEL_HOST, TEST_XUI_USERNAME, TEST_XUI_PASSWORD

logging.basicConfig(level=logging.INFO)

async def main():
    parsed = urlparse(TEST_XUI_PANEL_HOST)
    panel = PanelService(
        base_url=f"{parsed.scheme}://{parsed.netloc}",
        username=TEST_XUI_USERNAME,
        password=TEST_XUI_PASSWORD,
        panel_path=parsed.path or "/panel"
    )
    ok = await panel.login()
    print("Login OK?", ok)
    if not ok:
        return
    lst = await panel.list_inbounds()
    print("Inbounds:", lst)

asyncio.run(main())
