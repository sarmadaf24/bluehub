#!/usr/bin/env python3

import os
import re

# 🧠 فایل‌هایی که باید بررسی کنیم
TARGET_DIR = "./vpn_bot"
OLD_CLASS = "PanelService"
NEW_CLASS = "PanelService"
MODULE_PATH = "vpn_bot.services.panel_service"

# ✅ پترن برای import
IMPORT_PATTERN = re.compile(rf"from\s+{re.escape(MODULE_PATH)}\s+import\s+{OLD_CLASS}")
USAGE_PATTERN = re.compile(rf"\b{OLD_CLASS}\s*\(")

def patch_file(filepath):
    with open(filepath, "r", encoding="utf-8") as f:
        content = f.read()

    original_content = content

    # جایگزینی ایمپورت
    content = IMPORT_PATTERN.sub(f"from {MODULE_PATH} import {NEW_CLASS}", content)
    # جایگزینی استفاده از کلاس
    content = USAGE_PATTERN.sub(f"{NEW_CLASS}(", content)

    if content != original_content:
        with open(filepath, "w", encoding="utf-8") as f:
            f.write(content)
        print(f"✅ Patched: {filepath}")


def walk_and_patch():
    for root, _, files in os.walk(TARGET_DIR):
        for file in files:
            if file.endswith(".py"):
                patch_file(os.path.join(root, file))


if __name__ == "__main__":
    walk_and_patch()
