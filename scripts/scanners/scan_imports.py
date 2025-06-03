# 📂 scan_imports.py
import os
import re

PROJECT_ROOT = "vpn_bot"
pattern = re.compile(r"from\s+vpn_bot\.models\.config\s+import\s+(.+)")

def scan_for_config_imports():
    print("🚀 Deep scan: looking for imports from config.py with User/Config...\n")
    for root, _, files in os.walk(PROJECT_ROOT):
        for file in files:
            if file.endswith(".py"):
                path = os.path.join(root, file)
                with open(path, "r", encoding="utf-8") as f:
                    lines = f.readlines()
                    for idx, line in enumerate(lines, 1):
                        match = pattern.search(line)
                        if match:
                            content = match.group(1).replace(" ", "")
                            if "User" in content or "Config" in content:
                                print(f"📄 {path}")
                                print(f"🔢 Line {idx}: {line.strip()}")
                                print("⚠️  Importing `User` or `Config` from config.py is likely incorrect.\n")

if __name__ == "__main__":
    scan_for_config_imports()
