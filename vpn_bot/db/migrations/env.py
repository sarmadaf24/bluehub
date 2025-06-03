#/root/bluehub/vpn_bot/db/migrations/env.py

import os
import sys
from dotenv import load_dotenv

# ─── Project Root Setup ───────────────────────────────────────────────────────
root = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..', '..'))
sys.path.insert(0, root)
load_dotenv(os.path.join(root, '.env'))

# ─── Alembic & Logging Config ─────────────────────────────────────────────────
from logging.config import fileConfig
from alembic import context

config = context.config
fileConfig(config.config_file_name)

# ─── Override URL with async driver ────────────────────────────────────────────
from config import DATABASE_URL
config.set_main_option('sqlalchemy.url', DATABASE_URL)

# ─── Models & Metadata ────────────────────────────────────────────────────────
from vpn_bot.db.models import Base
target_metadata = Base.metadata

# ─── Engine Setup ─────────────────────────────────────────────────────────────
from sqlalchemy.ext.asyncio import create_async_engine

engine = create_async_engine(DATABASE_URL, future=True)

# ─── Migration Runners ─────────────────────────────────────────────────────────

from alembic import context
from sqlalchemy import inspect
from vpn_bot.db.core.base import Base  # جای درستِ importِ metadata شما

# فقط اشیائی (Table, Column، Index و غیره) را لحاظ کن
# که در مدلِ پایتون (Base.metadata) وجود دارند.
def include_object(obj, name, type_, reflected, compare_to):
    # وقتی compare_to is None یعنی
    # در metadataِ هدف (target_metadata) این شیء نیست → نادیده بگیر
    if compare_to is None:
        return False
    return True


def do_run_migrations(connection):
    context.configure(
        connection=connection,
        target_metadata=target_metadata,
        render_as_batch=True,
        compare_type=True,
        compare_server_default=True,
        include_object=include_object,      
    )
    with context.begin_transaction():
        context.run_migrations()

async def run_migrations_online():
    async with engine.begin() as conn:
        await conn.run_sync(do_run_migrations)

# ─── Entry Point ──────────────────────────────────────────────────────────────
if context.is_offline_mode():
    raise NotImplementedError("Offline mode not supported.")
else:
    import asyncio
    asyncio.run(run_migrations_online())
