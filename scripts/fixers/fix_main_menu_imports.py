# 📁 scripts/fix_main_menu_imports.py

import os

TARGET_DIR = "vpn_bot"
TARGET_LINE = "from vpn_bot.keyboards.language import main_menu_keyboard"
CORRECT_LINE = "from vpn_bot.keyboards.main import main_menu_keyboard"

def fix_imports():
    print("🔍 Scanning for incorrect imports...")
    for root, dirs, files in os.walk(TARGET_DIR):
        for file in files:
            if file.endswith(".py"):
                filepath = os.path.join(root, file)
                with open(filepath, "r", encoding="utf-8") as f:
                    lines = f.readlines()

                modified = False
                new_lines = []
                for line in lines:
                    if TARGET_LINE in line:
                        print(f"⚠️  Fixing in: {filepath}")
                        line = line.replace(TARGET_LINE, CORRECT_LINE)
                        modified = True
                    new_lines.append(line)

                if modified:
                    with open(filepath, "w", encoding="utf-8") as f:
                        f.writelines(new_lines)
    print("✅ All incorrect imports fixed.")

if __name__ == "__main__":
    fix_imports()
