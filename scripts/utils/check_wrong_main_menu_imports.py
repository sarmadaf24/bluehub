# 📁 scripts/check_wrong_main_menu_imports.py

import os

TARGET_DIR = "vpn_bot"
TARGET_IMPORT = "from vpn_bot.keyboards.language import main_menu_keyboard"

def check_wrong_imports():
    found = []
    for root, _, files in os.walk(TARGET_DIR):
        for file in files:
            if file.endswith(".py"):
                path = os.path.join(root, file)
                with open(path, "r", encoding="utf-8") as f:
                    for idx, line in enumerate(f, 1):
                        if TARGET_IMPORT in line:
                            found.append((path, idx, line.strip()))

    if found:
        print("❗ ایمپورت اشتباه پیدا شد در:")
        for path, line_no, line in found:
            print(f"📍 {path}:{line_no} → {line}")
    else:
        print("✅ هیچ ایمپورت اشتباهی باقی نمونده 💯")

if __name__ == "__main__":
    check_wrong_imports()
