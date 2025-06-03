# vpn_bot/services/test_panel_service.py

import logging
from urllib.parse import urlparse
from vpn_bot.services.panel_service import PanelService

class TestPanelService(PanelService):
    def __init__(self, panel_url: str, username: str, password: str):
        parsed = urlparse(panel_url)
        base = f"{parsed.scheme}://{parsed.netloc}"
        path = parsed.path or ""
        super().__init__(
            base_url   = base,
            username   = username,
            password   = password,
            panel_path = path
        )
        self.logger = logging.getLogger("test-panel")

    async def login(self) -> bool:
        self.logger.info(f"🔧 [TEST PANEL] Trying login → {self.base_url}{self.panel_path}/login")
        ok = await super().login()
        if ok:
            self.logger.info(f"🔧 [TEST PANEL] login successful, cookie={self.session_cookie!r}")
        else:
            self.logger.error("🔧 [TEST PANEL] login failed")
        return ok

    async def get_inbounds(self) -> list[dict]:
        """
        فقط از endpoint اینباند لیست بگیرد و فیلد 'obj' را برگرداند.
        """
        resp = await self.session.get(
            self._get_url("panel/api/inbounds/list"),
            headers=self._get_headers()
        )
        data = resp.json()
        inbounds = data.get("obj", [])
        self.logger.info(f"🔧 [TEST PANEL] available inbounds IDs: {[i.get('id') for i in inbounds]}")
        return inbounds
    

