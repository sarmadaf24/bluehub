# 📁 /root/bluehub/vpn_bot/services/panel_service.py

import json
import logging
import base64
from datetime import datetime, timedelta
from urllib.parse import urljoin

import httpx
from httpx import AsyncClient
from sqlalchemy import select
from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.server import Server
from vpn_bot.db.models.plan import Plan
from vpn_bot.db.models import Inbound
from aiogram import Bot
from aiogram.client.default import DefaultBotProperties

# اضافه‌شده: اطمینان از وارد شدن پروتکل
from config import BOT_TOKEN, XUI_PANEL_HOST, XUI_USERNAME, XUI_PASSWORD

logger = logging.getLogger("panel-service")
# لاگ نقطه شروع اتصال به پنل
logger.info(f"🔌 Connecting to XUI panel at {XUI_PANEL_HOST}")

bot = Bot(token=BOT_TOKEN, default=DefaultBotProperties(parse_mode="HTML"))

# مثال استفاده از base_url در AsyncClient
async def fetch_inbounds():
    async with AsyncClient(base_url=XUI_PANEL_HOST) as client:
        # مسیریاب API
        url = urljoin(XUI_PANEL_HOST, "/api/inbounds")
        resp = await client.get(url, auth=(XUI_USERNAME, XUI_PASSWORD))
        resp.raise_for_status()
        return resp.json()



class PanelService:
    def __init__(self, base_url: str, username: str, password: str, panel_path: str = "/"):
        self.base_url = base_url.rstrip("/")
        self.username = username
        self.password = password
        self.panel_path = "/" + panel_path.strip("/") if panel_path else ""
        self.session = AsyncClient(verify=False, follow_redirects=True)
        self.session_cookie = None

    def _get_headers(self) -> dict:
        return {
            "Content-Type": "application/json",
            "Cookie":       f"3x-ui={self.session_cookie}"
        }

    def _get_url(self, path: str) -> str:
        return f"{self.base_url}{self.panel_path}/{path.lstrip('/')}"

    async def login(self) -> bool:
        url = self._get_url("login")
        data = {"username": self.username, "password": self.password}
        try:
            resp = await self.session.post(url, data=data)
            if resp.status_code == 200:
                self.session_cookie = resp.cookies.get("3x-ui") or resp.cookies.get("X-UI")
                return True
            logger.error(f"[LOGIN ERROR] Status: {resp.status_code}")
        except Exception as e:
            logger.error(f"[LOGIN ERROR] {e}")
        return False

    async def add_client_to_inbound(self, inbound_id: int, client_obj: dict) -> bool:
        """
        POST /panel/api/inbounds/addClient
        payload:
        {
          "id": inbound_id,
          "settings": "{\"clients\":[{...client object...}]}"
        }
        """
        # بسته به نوع پروتکل، client_payload را بساز
        # use "totalGB" not "transferEnable", per panel API
        if "method" in client_obj:
            # Shadowsocks
            client_payload = {
                "comment":    client_obj.get("comment", ""),
                "email":      client_obj["email"],
                "enable":     client_obj.get("enable", True),
                "expiryTime": client_obj.get("expiryTime", 0),
                "limitIp":    client_obj.get("limitIp", 0),
                "method":     client_obj["method"],
                "password":   client_obj["password"],
                "reset":      client_obj.get("reset", 0),
                "subId":      client_obj.get("subId", ""),
                "tgId":       client_obj.get("tgId", ""),
                "totalGB":    client_obj.get("totalGB", 0),
            }
        else:
            # vmess / vless / trojan
            client_payload = {
                "id":         client_obj["id"],
                "email":      client_obj["email"],
                "password":   client_obj["password"],
                "flow":       client_obj.get("flow", ""),
                "limitIp":    client_obj.get("limitIp", 0),
                "expiryTime": client_obj.get("expiryTime", 0),
                "enable":     client_obj.get("enable", True),
                "subId":      client_obj.get("subId", ""),
                "tgId":       client_obj.get("tgId", ""),
                "reset":      client_obj.get("reset", 0),
                "totalGB":    client_obj.get("totalGB", 0),
                **({"level": client_obj.get("level", 0)} if "level" in client_obj else {}),
                **({"aid":   client_obj.get("aid", 0)}   if "aid"   in client_obj else {}),
                **({"security": client_obj["security"]} if "security" in client_obj else {}),
            }

        payload = {
            "id":       inbound_id,
            "settings": json.dumps({"clients": [client_payload]})
        }
        logger.debug("🔧 add_client payload: %s", payload)

        resp = await self.session.post(
            self._get_url("panel/api/inbounds/addClient"),
            json=payload,
            headers=self._get_headers()
        )
        if resp.status_code != 200:
            logger.error(f"[ADD CLIENT ERROR] HTTP {resp.status_code}: {resp.text!r}")
            return False

        try:
            return resp.json().get("success", False)
        except ValueError:
            logger.error(f"[ADD CLIENT ERROR] invalid JSON: {resp.text!r}")
            return False

    async def update_client(
        self,
        inbound_id: int,
        client_id: str,
        settings: dict
    ) -> bool:
        """
        POST /panel/api/inbounds/{inboundId}/updateClient/{clientId}
        payload:
        {
          "id": inbound_id,
          "settings": "{\"clients\":[{...settings..., \"id\":clientId}]}"
        }
        """
        client_settings = { **settings, "id": client_id }
        payload = {
            "id":       inbound_id,
            "settings": json.dumps({"clients": [client_settings]})
        }
        logger.debug("🔧 update_client payload: %s", payload)

        url = self._get_url(f"panel/api/inbounds/{inbound_id}/updateClient/{client_id}")
        resp = await self.session.post(
            url,
            json=payload,
            headers=self._get_headers()
        )
        if resp.status_code != 200:
            logger.error(f"[UPDATE CLIENT ERROR] HTTP {resp.status_code}: {resp.text!r}")
            return False

        # پاسخ معمولاً خالی است ⇒ اعتبار بر اساس status_code
        return True

    async def get_inbounds(self) -> list[dict]:
        """
        POST /panel/api/server/getConfigJson
        (نسخه‌ای که قبلاً بدون مشکل کار می‌کرد)
        """
        try:
            url = self._get_url("panel/api/server/getConfigJson")
            resp = await self.session.post(url, headers=self._get_headers())
            logger.debug(f"[INBOUNDS RAW] {resp.text!r}")
            data = resp.json()
            logger.info(f"[INBOUNDS JSON] {data}")
            return data.get("data") or data.get("inbounds") or []
        except Exception as e:
            logger.error(f"[INBOUNDS ERROR] {e}")
            return []

    async def get_client_config(self, inbound_id: int, client_id: str) -> str | None:
        inbounds = await self.get_inbounds()
        for ib in inbounds:
            if ib.get("id") == inbound_id:
                for c in ib.get("clients", []):
                    if str(c.get("id")) == client_id:
                        return c.get("config")
        return None

    def generate_v2ray_link(self, protocol: str, uuid: str, domain: str, port: int, **kwargs) -> str:
        if protocol == "vless":
            return f"vless://{uuid}@{domain}:{port}?encryption=none&security=tls&type=ws#BlueHub"
        elif protocol == "vmess":
            cfg = {
                "v": "2", "ps": "BlueHub", "add": domain, "port": str(port),
                "id": uuid, "aid": "0", "net": "ws", "type": "none",
                "host": kwargs.get("host", ""), "path": kwargs.get("path", "/"), "tls": "tls"
            }
            return "vmess://" + base64.b64encode(json.dumps(cfg).encode()).decode()
        elif protocol == "trojan":
            return f"trojan://{uuid}@{domain}:{port}?security=tls#BlueHub"
        elif protocol == "shadowsocks":
            userinfo = f"{kwargs.get('encryption')}:{kwargs.get('password')}"
            enc = base64.urlsafe_b64encode(userinfo.encode()).decode().rstrip("=")
            return f"ss://{enc}@{domain}:{port}#BlueHub"
        return "❌ Unsupported protocol"

    async def reload_panel(self) -> bool:
        try:
            resp = await self.session.post(
                self._get_url("panel/api/xui/restart"),
                headers=self._get_headers()
            )
            logger.info(f"[RESTART PANEL] status={resp.status_code}")
            return resp.status_code == 200
        except Exception as e:
            logger.error(f"[RESTART PANEL ERROR] {e}")
            return False

    async def download_client_config(
        self, inbound_id: int, client_id: str, protocol: str
    ) -> str | None:
        try:
            endpoint = (
                "panel/api/server/localShadowsocksDownload"
                if protocol == "shadowsocks"
                else "panel/api/server/localDownload"
            )
            resp = await self.session.post(
                self._get_url(endpoint),
                json={"inboundId": inbound_id, "clientId": client_id},
                headers=self._get_headers()
            )
            text = resp.text.strip()
            if resp.status_code == 200 and text:
                return text
            return await self.get_client_config(inbound_id, client_id)
        except Exception as e:
            logger.error(f"[DOWNLOAD CONFIG ERROR] {e}")
            return await self.get_client_config(inbound_id, client_id)
        
    async def get_client_traffic(self, inbound_id: int, client_id: str) -> dict:
        """
        Fetch upload/download bytes for a client.
        Endpoint: GET /panel/api/inbounds/{inboundId}/traffic
        Returns dict with keys 'upload' and 'download' (ints).
        """
        url = self._get_url(f"panel/api/inbounds/{inbound_id}/traffic")
        try:
            resp = await self.session.get(url, headers=self._get_headers())
            data = resp.json()
            d = data.get("data", {})
            return {
                "upload":   int(d.get("upload",   0)),
                "download": int(d.get("download", 0))
            }
        except Exception as e:
            logger.error(f"[TRAFFIC ERROR] {e}, body={getattr(resp, 'text', '')!r}")
            return {"upload": 0, "download": 0}


    async def close(self):
        """بستن اتصال HTTP session"""
        await self.session.aclose()


# ——— Database helpers ———

async def get_plan_by_id(plan_id: int) -> Plan | None:
    async with AsyncSessionLocal() as sess:
        return await sess.get(Plan, plan_id)

async def get_all_plans() -> list[Plan]:
    async with AsyncSessionLocal() as sess:
        res = await sess.execute(select(Plan).where(Plan.is_active == True))
        return res.scalars().all()

async def plan_exists(name: str) -> bool:
    async with AsyncSessionLocal() as sess:
        res = await sess.execute(select(Plan).where(Plan.name == name))
        return res.scalar_one_or_none() is not None

async def create_plan(name: str, duration_days: int, volume_gb: int | None, price: int) -> Plan:
    async with AsyncSessionLocal() as sess:
        pl = Plan(name=name, duration_days=duration_days, volume_gb=volume_gb, price=price)
        sess.add(pl)
        await sess.commit()
        await sess.refresh(pl)
        logger.info(f"[PLAN CREATED] {name}")
        return pl

async def delete_plan(plan_id: int) -> bool:
    async with AsyncSessionLocal() as sess:
        pl = await sess.get(Plan, plan_id)
        if not pl:
            return False
        await sess.delete(pl)
        await sess.commit()
        logger.info(f"[PLAN DELETED] ID: {plan_id}")
        return True

async def get_inbound_by_protocol(protocol: str) -> Inbound | None:
    async with AsyncSessionLocal() as sess:
        res = await sess.execute(select(Inbound).where(Inbound.protocol == protocol))
        return res.scalars().first()
