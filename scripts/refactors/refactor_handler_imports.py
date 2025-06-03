import os
import re

BASE_DIR = "./vpn_bot"
OLD_PREFIX = "from vpn_bot.bot.handlers."
NEW_BASE = "from vpn_bot.bot.handlers"

# مسیرهای جدید (map قدیم به جدید)
HANDLER_MAP = {
    "start": "common.start",
    "register": "user.account.register",
    "plans": "user.buy.plans",
    "pay_zarinpal": "payment.zarinpal",
    "ticket": "ticketing.ticket",
    "ticket_admin": "ticketing.admin",
    # ... هر چی مسیر جابه‌جا شده اینجا دستی بزن یا داینامیک بساز
}

def find_python_files(path):
    for root, dirs, files in os.walk(path):
        for file in files:
            if file.endswith(".py"):
                yield os.path.join(root, file)

def refactor_file(file_path):
    changed = False
    with open(file_path, "r", encoding="utf-8") as f:
        content = f.read()

    # تطبیق همه‌ی ایمپورت‌هایی که مثل: from vpn_bot.bot.handlers.start import ...
    pattern = re.compile(rf"{re.escape(OLD_PREFIX)}(\w+)\b")
    
    def replace(match):
        old_module = match.group(1)
        new_path = HANDLER_MAP.get(old_module)
        if new_path:
            nonlocal changed
            changed = True
            return f"{NEW_BASE}.{new_path}"
        return match.group(0)  # همون قبلی رو نگه دار

    new_content = pattern.sub(replace, content)

    if changed:
        with open(file_path, "w", encoding="utf-8") as f:
            f.write(new_content)
        print(f"✅ Refactored: {file_path}")

def main():
    print("🚀 Refactoring handler imports...")
    for file in find_python_files(BASE_DIR):
        refactor_file(file)
    print("🎉 Done.")

if __name__ == "__main__":
    main()
