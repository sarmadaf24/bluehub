import asyncio
import httpx
import os
from dotenv import load_dotenv

load_dotenv()

API_KEY = os.getenv("NOWPAYMENTS_API_KEY")
if not API_KEY:
    raise Exception("NOWPAYMENTS_API_KEY not found in .env")

async def fetch_available_currencies():
    url = "https://api.nowpayments.io/v1/currencies"
    headers = {"x-api-key": API_KEY}

    async with httpx.AsyncClient() as client:
        res = await client.get(url, headers=headers)
        res.raise_for_status()
        data = res.json()

        # 🔍 بررسی نوع داده
        print("💰 Supported Coins:\n")
        if isinstance(data, dict) and "currencies" in data:
            for coin in data["currencies"]:
                print(coin)  # 👈 این رو ببین چی چاپ می‌کنه
                if isinstance(coin, dict):
                    symbol = coin.get("currency", "❓")
                    accepted = coin.get("can_pay", False)
                    print(f"🪙 {symbol:<10} | accepted: {accepted}")
            print(f"\n✅ Total: {len(data['currencies'])}")
        else:
            print("❌ Unexpected API response:", data)

asyncio.run(fetch_available_currencies())
