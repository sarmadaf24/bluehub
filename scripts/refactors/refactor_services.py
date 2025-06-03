#!/usr/bin/env python3
import os
import re

# 🔁 Map of old imports → new refactored paths
REFACTOR_MAP = {
    "vpn_bot.services.config_service": "vpn_bot.services.config_builder",
    "vpn_bot.services.link_generator": "vpn_bot.services.connection_service",
    "vpn_bot.services.panel_client": "vpn_bot.services.panel_service",
    "vpn_bot.services.plan_service": "vpn_bot.services.panel_service",
    "vpn_bot.services.server_capacity": "vpn_bot.services.server_service",
    "vpn_bot.services.server_selector": "vpn_bot.services.server_service",
    "vpn_bot.services.exchange_service": "vpn_bot.services.payment.exchange_service",
    "vpn_bot.services.order_service": "vpn_bot.services.payment.order_service",
    "vpn_bot.services.scheduler": "vpn_bot.services.payment.scheduler",
    # user_service is kept the same, but included for consistency
    "vpn_bot.services.user_service": "vpn_bot.services.user_service",
}

# 📁 Which folders to scan for matches
SCAN_PATH = "./vpn_bot"

def patch_file(filepath):
    with open(filepath, "r", encoding="utf-8") as f:
        content = f.read()

    original_content = content
    for old, new in REFACTOR_MAP.items():
        content = re.sub(rf"\b{re.escape(old)}\b", new, content)

    if content != original_content:
        with open(filepath, "w", encoding="utf-8") as f:
            f.write(content)
        print(f"✅ Patched: {filepath}")

def walk_and_patch():
    for root, dirs, files in os.walk(SCAN_PATH):
        for filename in files:
            if filename.endswith(".py"):
                filepath = os.path.join(root, filename)
                patch_file(filepath)

if __name__ == "__main__":
    walk_and_patch()
