import os
import re

TARGET_PATH = "/root/bluewire/vpn_bot/bot"
router_usages = {}

def find_py_files(base_path):
    for root, _, files in os.walk(base_path):
        for file in files:
            if file.endswith(".py"):
                yield os.path.join(root, file)

def scan_router_usages():
    for filepath in find_py_files(TARGET_PATH):
        with open(filepath, "r", encoding="utf-8") as f:
            lines = f.readlines()

        for i, line in enumerate(lines):
            match = re.search(r"(dp|router)\.include_router\(([\w_\.]+)\)", line)
            if match:
                router = match.group(2)
                router_usages.setdefault(router, []).append((filepath, i, line.strip()))

def comment_duplicates():
    updated_files = set()

    for router, occurrences in router_usages.items():
        if len(occurrences) > 1:
            # فقط موارد دوم به بعد کامنت می‌شن
            for filepath, line_num, original in occurrences[1:]:
                with open(filepath, "r", encoding="utf-8") as f:
                    lines = f.readlines()

                if not lines[line_num].lstrip().startswith("#"):
                    lines[line_num] = f"# 🔥 Auto-commented: {lines[line_num]}"
                    with open(filepath, "w", encoding="utf-8") as f:
                        f.writelines(lines)
                    updated_files.add(filepath)

    return updated_files

# اجرای مرحله‌ای
print("🚀 Scanning for duplicate include_router usages in 'vpn_bot/bot'...\n")
scan_router_usages()
touched = comment_duplicates()

for file in touched:
    print(f"✅ Updated: {file}")

if not touched:
    print("🎉 No duplicates found to comment.")

print("\n🎯 Done.")
