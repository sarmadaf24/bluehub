#/root/bluehub/scripts/fix_alembic_env.py

#!/usr/bin/env python3

env_file = "vpn_bot/db/migrations/alembic/env.py"

with open(env_file, "r", encoding="utf-8") as f:
    content = f.read()

# اصلاح مسیرها
content = content.replace("from db.models", "from vpn_bot.db.models")
content = content.replace("from vpn_bot.database.base", "from vpn_bot.db.core.base")
content = content.replace("from vpn_bot.database", "from vpn_bot.db.core")

# اضافه کردن ایمپورت config اگر نبود
if "from config import DATABASE_URL" not in content:
    content = content.replace(
        "from logging.config import fileConfig",
        "from logging.config import fileConfig\nfrom config import DATABASE_URL"
    )

# جایگزینی مقدار دیتابیس در صورت وجود
content = content.replace(
    "config.set_main_option('sqlalchemy.url', 'sqlite:///db.sqlite3')",  # اگه بود
    "config.set_main_option('sqlalchemy.url', DATABASE_URL)"
)

with open(env_file, "w", encoding="utf-8") as f:
    f.write(content)

print(f"✅ Updated Alembic env.py with new db paths.")
