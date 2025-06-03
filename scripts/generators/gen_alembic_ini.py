# 📁 scripts/gen_alembic_ini.py

import os

BASE_DIR = os.path.abspath(os.path.dirname(__file__))
alembic_path = os.path.join(BASE_DIR, "..", "vpn_bot", "db", "migrations", "alembic")
output_file = os.path.join(BASE_DIR, "..", "alembic.ini")

# 👁️‍🗨️ دیتابیس به صورت هوشمند انتخاب میشه (SQLite یا PostgreSQL)
default_sqlite_url = "sqlite:///vpn_bot/db/migrations/db.sqlite3"
default_postgres_url = os.getenv("DATABASE_URL", "postgresql://user:pass@localhost/dbname")

is_sqlite = os.path.exists("vpn_bot/db/migrations/db.sqlite3")
db_url = default_sqlite_url if is_sqlite else default_postgres_url

config_template = f"""[alembic]
script_location = vpn_bot/db/migrations/alembic
sqlalchemy.url = {db_url}

[loggers]
keys = root,sqlalchemy,alembic

[handlers]
keys = console

[formatters]
keys = generic

[logger_root]
level = WARN
handlers = console
qualname =

[logger_sqlalchemy]
level = WARN
handlers =
qualname = sqlalchemy.engine

[logger_alembic]
level = INFO
handlers =
qualname = alembic

[handler_console]
class = StreamHandler
args = (sys.stderr,)
level = NOTSET
formatter = generic

[formatter_generic]
format = %(levelname)-5.5s [%(name)s] %(message)s
"""

with open(output_file, "w") as f:
    f.write(config_template)

print(f"✅ alembic.ini created at {output_file}")
print(f"🔗 Database URL: {db_url}")
