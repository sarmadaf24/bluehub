# 📁 /root/bluehub/test_payment_checker.py

import os
from dotenv import load_dotenv
load_dotenv()

# 💡 ENVهای ضروری (در صورت نبود تو .env دستی ست کن)
os.environ["PANEL_URL"] = os.getenv("PANEL_URL", "https://bluehub1.varzeshnews24.online:54322/aOQyy6wVYyI7M9T")
os.environ["PANEL_USERNAME"] = os.getenv("PANEL_USERNAME", "C1kt5SJPdF")
os.environ["PANEL_PASSWORD"] = os.getenv("PANEL_PASSWORD", "MTJzS5Opyt")

import asyncio
from vpn_bot.jobs.payment_checker import check_pending_payments

async def main():
    print("🚀 Running payment checker simulation...")
    await check_pending_payments()

if __name__ == "__main__":
    asyncio.run(main())

