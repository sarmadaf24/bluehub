import os
import re

# مسیر پروژه اصلی
PROJECT_ROOT = "vpn_bot"

# فایل‌هایی که در __init__.py نباید ازشون import شه
model_specific_imports = {
    "User": "db.models.user",
    "Config": "db.models.config",
    "Ticket": "db.models.ticket",
    "Transaction": "db.models.transaction",
    "Plan": "db.models.plan",
    "Order": "db.models.order",
}

def refactor_imports_in_file(filepath):
    with open(filepath, "r", encoding="utf-8") as f:
        lines = f.readlines()

    updated = False
    new_lines = []

    for line in lines:
        match = re.match(r"from\s+vpn_bot\.models\s+import\s+(.+)", line)
        if match:
            imported_items = [item.strip() for item in match.group(1).split(",")]

            for item in imported_items:
                if item in model_specific_imports:
                    new_line = f"from {model_specific_imports[item]} import {item}\n"
                    new_lines.append(new_line)
                    updated = True
                else:
                    new_lines.append(line)  # fallback
        else:
            new_lines.append(line)

    if updated:
        with open(filepath, "w", encoding="utf-8") as f:
            f.writelines(new_lines)
        print(f"✅ Fixed: {filepath}")

def walk_and_fix(path):
    for root, dirs, files in os.walk(path):
        for file in files:
            if file.endswith(".py"):
                full_path = os.path.join(root, file)
                refactor_imports_in_file(full_path)

if __name__ == "__main__":
    print("🔍 Fixing model imports...")
    walk_and_fix(PROJECT_ROOT)
    print("🎉 Done.")
