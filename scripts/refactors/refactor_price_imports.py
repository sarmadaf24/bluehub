#!/usr/bin/env python3

import os

TARGET_IMPORTS = [
    "from vpn_bot.utils.price import",
    "import vpn_bot.utils.price"
]

REPLACEMENT_MAP = {
    "from vpn_bot.utils.price import": "from vpn_bot.services.payment.price import",
    "import vpn_bot.utils.price": "import vpn_bot.services.payment.price"
}

def patch_file(file_path):
    with open(file_path, "r", encoding="utf-8") as f:
        lines = f.readlines()

    changed = False
    new_lines = []
    for line in lines:
        stripped = line.strip()
        for target in TARGET_IMPORTS:
            if stripped.startswith(target):
                new_line = line.replace(target, REPLACEMENT_MAP[target])
                new_lines.append(new_line)
                changed = True
                break
        else:
            new_lines.append(line)

    if changed:
        with open(file_path, "w", encoding="utf-8") as f:
            f.writelines(new_lines)
        print(f"✅ Patched: {file_path}")

def scan_and_patch(base_path):
    for root, _, files in os.walk(base_path):
        for file in files:
            if file.endswith(".py"):
                full_path = os.path.join(root, file)
                patch_file(full_path)

if __name__ == "__main__":
    scan_and_patch("./vpn_bot")
