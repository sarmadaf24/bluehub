import asyncio
import json
from vpn_bot.services.panel_client import PanelService
from vpn_bot.link_builders.vmess import build_vmess_link
from vpn_bot.link_builders.vless import build_vless_link
from vpn_bot.link_builders.trojan import build_trojan_link
from vpn_bot.link_builders.shadowsocks import build_shadowsocks_link

PANEL_URL = "https://bluehub1.varzeshnews24.online:54322"
USERNAME = "admin"
PASSWORD = "admin123"
PANEL_PATH = "aOQyy6wVYyI7M9T"
DOMAIN = "bluehub1.varzeshnews24.online"

async def main():
    client = PanelService(PANEL_URL, USERNAME, PASSWORD, PANEL_PATH)
    if not await client.login():
        print("❌ Login failed")
        return

    config = await client.get_config()
    print("✅ Raw Config:", config)

    inbounds = config.get("inbounds", [])
    print(f"✅ Debug Inbounds: {len(inbounds)}")

    vmess_links = []
    vless_links = []
    trojan_links = []
    shadowsocks_links = []

    for inbound in inbounds:
        protocol = inbound.get("protocol")
        port = inbound.get("port")
        settings = inbound.get("settings")
        stream_settings = inbound.get("streamSettings")

        # اگر تنظیمات str باشه باید دیکود بشه
        if isinstance(settings, str):
            try:
                settings = json.loads(settings)
            except Exception as e:
                print("[ERROR] Failed to parse inbound settings:", e)
                continue

        if isinstance(stream_settings, str):
            try:
                stream_settings = json.loads(stream_settings)
            except:
                stream_settings = {}

        clients = settings.get("clients", [])
        for client_data in clients:
            try:
                if protocol == "vmess":
                    link = build_vmess_link(client_data, DOMAIN, port, stream_settings)
                    vmess_links.append(link)
                elif protocol == "vless":
                    link = build_vless_link(client_data, DOMAIN, port, stream_settings)
                    vless_links.append(link)
                elif protocol == "trojan":
                    link = build_trojan_link(client_data, DOMAIN, port, stream_settings)
                    trojan_links.append(link)
                elif protocol == "shadowsocks":
                    link = build_shadowsocks_link(client_data, DOMAIN, port, stream_settings, settings)
                    shadowsocks_links.append(link)
            except Exception as e:
                print(f"[ERROR] Failed to build link for {client_data.get('email')} ({protocol}):", e)

    print("\n🔗 VMESS LINKS:")
    for link in vmess_links:
        print(link)

    print("\n🔗 VLESS LINKS:")
    for link in vless_links:
        print(link)

    print("\n🔗 TROJAN LINKS:")
    for link in trojan_links:
        print(link)

    print("\n🔗 SHADOWSOCKS LINKS:")
    for link in shadowsocks_links:
        print(link)

if __name__ == "__main__":
    asyncio.run(main())
