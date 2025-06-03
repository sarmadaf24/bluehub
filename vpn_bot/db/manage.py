# 📁 /root/bluehub/vpn_bot/db/manage.py

import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "../../../")))


import typer
import asyncio
from rich import print

# 🧩 وارد کردن ماژول‌ها از ساختار جدید
from vpn_bot.db.core.base import Base
from vpn_bot.db.core.session import engine
from vpn_bot.db.seed.seed_plans import run as seed_plans
from vpn_bot.db.seed.seed_admin import run as make_admin
from vpn_bot.db.seed.seed_all import run as seed_all
# ✅ نگه داشتن این:
from main import main as run_bot
app = typer.Typer(help="🔧 ابزار مدیریت پروژه VPN Bot")


@app.command()
def create_tables():
    """ایجاد جدول‌های دیتابیس"""
    print("[bold blue]⏳ در حال ایجاد جدول‌ها...[/bold blue]")

    async def init_db():
        async with engine.begin() as conn:
            await conn.run_sync(Base.metadata.create_all)
    asyncio.run(init_db())
    print("[green]✅ جدول‌ها ساخته شدند.[/green]")


@app.command()
def seed():
    """وارد کردن پلن‌های اولیه به دیتابیس"""
    print("[bold blue]📦 در حال وارد کردن پلن‌ها...[/bold blue]")
    asyncio.run(seed_plans())
    print("[green]✅ پلن‌ها وارد شدند.[/green]")


@app.command()
def makeadmin(user_id: int = typer.Argument(..., help="آیدی کاربر")):
    """ارتقای کاربر به مدیر"""
    print(f"[bold blue]🔐 در حال ارتقا دادن کاربر {
          user_id} به ادمین...[/bold blue]")
    asyncio.run(make_admin(user_id=user_id))
    print(f"[green]✅ کاربر {user_id} الان ادمینه.[/green]")


@app.command()
def seedall():
    """وارد کردن همه داده‌های اولیه (پلن، ادمین، سرورها و...)"""
    print("[bold cyan]🚀 در حال وارد کردن همه داده‌های اولیه...[/bold cyan]")
    asyncio.run(seed_all())
    print("[green]✅ همه‌چیز آماده‌ست![/green]")


@app.command()
def run():
    """اجرای بات تلگرام"""
    print("[bold blue]🤖 در حال اجرای بات...[/bold blue]")
    asyncio.run(run_bot())


if __name__ == "__main__":
    app()
