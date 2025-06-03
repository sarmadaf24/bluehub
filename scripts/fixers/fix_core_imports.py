import os

BASE_DIR = "vpn_bot"

def fix_core_imports():
    for subdir, _, files in os.walk(BASE_DIR):
        for file in files:
            if file.endswith(".py"):
                path = os.path.join(subdir, file)

                with open(path, "r", encoding="utf-8") as f:
                    content = f.read()

                updated = content.replace("import core", "from vpn_bot.bot import core")
                updated = updated.replace("from core", "from vpn_bot.bot.core")

                if content != updated:
                    with open(path, "w", encoding="utf-8") as f:
                        f.write(updated)
                    print(f"✅ Updated: {path}")

if __name__ == "__main__":
    fix_core_imports()
