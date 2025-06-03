# 📁 vpn_bot/db/seed/seed_all.py

import asyncio
from rich import print

# 🧩 وارد کردن تمام ماژول‌های مورد نیاز
from vpn_bot.db.seed import (
    seed_plans,
    seed_admin,
    seed_servers,
    seed_servers_from_json
)


async def run():
    print("[bold cyan]🚀 شروع وارد کردن تمام داده‌های اولیه...[/bold cyan]")

    # پلن‌ها
    print("[yellow]📦 در حال وارد کردن پلن‌ها...[/yellow]")
    await seed_plans.run()

    # ادمین (اینجا آیدی پیش‌فرض گذاشتیم، می‌تونی درصورت نیاز تغییر بدی)
    print("[yellow]🔐 در حال ارتقا دادن ادمین پیش‌فرض...[/yellow]")
    await seed_admin.run(user_id=2005217637)

    # سرورها از فایل JSON
    print("[yellow]🌐 در حال وارد کردن سرورها از JSON...[/yellow]")
    await seed_servers_from_json.run()

    # سرورهای اضافی دستی
    print("[yellow]🧩 در حال وارد کردن سرورهای اضافه...[/yellow]")
    await seed_servers.run()

    print("[green bold]✅ تمام داده‌های اولیه با موفقیت وارد شدند.[/green bold]")

if __name__ == "__main__":
    asyncio.run(run())
