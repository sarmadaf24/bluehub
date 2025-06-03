from pathlib import Path

targets = [
    "vpn_bot/bot/handlers/admin/__init__.py",
    "vpn_bot/bot/handlers/user/__init__.py",
    "vpn_bot/bot/handlers/common/__init__.py",
    "vpn_bot/bot/handlers/payment/__init__.py",
    "vpn_bot/bot/handlers/ticketing/__init__.py",
]

for file_path in targets:
    path = Path(file_path)
    if not path.exists():
        print(f"❌ File not found: {file_path}")
        continue

    lines = path.read_text(encoding="utf-8").splitlines()
    updated = []
    modified = False

    for line in lines:
        if "router.include_router(" in line and not line.strip().startswith("#"):
            updated.append(f"# 🔥 Auto-commented: {line.strip()}")
            modified = True
        else:
            updated.append(line)

    if modified:
        path.write_text("\n".join(updated) + "\n", encoding="utf-8")
        print(f"✅ Updated: {file_path}")
    else:
        print(f"ℹ️ No changes: {file_path}")
