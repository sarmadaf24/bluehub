# 📁 scripts/replace_translation_key.py

import os
import re

TARGET_DIR = "vpn_bot"
OLD_KEY = "welcome_message"
NEW_KEY = "home_msg"

def replace_translation_key():
    total_replaced = 0

    print(f"🔍 Replacing t(\"{OLD_KEY}\") with t(\"{NEW_KEY}\") in {TARGET_DIR}/ ...")

    for root, _, files in os.walk(TARGET_DIR):
        for file in files:
            if file.endswith(".py"):
                filepath = os.path.join(root, file)

                with open(filepath, "r", encoding="utf-8") as f:
                    content = f.read()

                new_content = re.sub(
                    rf't\(["\']{OLD_KEY}["\']\)',
                    f't("{NEW_KEY}")',
                    content
                )

                if content != new_content:
                    with open(filepath, "w", encoding="utf-8") as f:
                        f.write(new_content)
                    print(f"✅ Updated: {filepath}")
                    total_replaced += 1

    print(f"\n🎉 Replacement complete. Total files updated: {total_replaced}")

if __name__ == "__main__":
    replace_translation_key()
