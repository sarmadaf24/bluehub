#!/usr/bin/env python3

import os
import re

# 📦 مسیر پروژه‌ت رو مشخص کن
BASE_DIR = "./vpn_bot"
EXT = (".py",)

# 🗂️ مپ تغییر مسیرها (قدیمی → جدید)
REMAP_IMPORTS = {
    "bot_notifier": "panel_service",
    "config_service": "config_builder",
    "link_generator": "connection_service",
    "panel_client": "panel_service",
    "plan_service": "panel_service",
    "server_capacity": "server_service",
    "server_selector": "server_service",
    "user_service": "user_service",
    "xui_client": "panel_service",
}

# 🧠 Regex ساختار ایمپورت
IMPORT_PATTERN = re.compile(
    r"from\s+vpn_bot\.services\.(?P<old>[a-zA-Z0-9_]+)\s+import"
)

def patch_file(filepath):
    with open(filepath, "r", encoding="utf-8") as f:
        content = f.read()

    original_content = content

    def replacer(match):
        old = match.group("old")
        new = REMAP_IMPORTS.get(old)
        if new:
            return f"from vpn_bot.services.{new} import"
        return match.group(0)

    content = IMPORT_PATTERN.sub(replacer, content)

    if content != original_content:
        with open(filepath, "w", encoding="utf-8") as f:
            f.write(content)
        print(f"✅ Patched: {filepath}")

def scan_and_patch():
    for root, _, files in os.walk(BASE_DIR):
        for file in files:
            if file.endswith(EXT):
                full_path = os.path.join(root, file)
                patch_file(full_path)

if __name__ == "__main__":
    scan_and_patch()
