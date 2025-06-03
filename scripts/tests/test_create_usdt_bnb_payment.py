# 📄 File: test_create_usdt_bnb_payment.py

import asyncio
from dotenv import load_dotenv
load_dotenv()

from vpn_bot.services.payment.nowpayments import create_payment

COINS_TO_TEST = [
    ("usdt", "USDT روی شبکه TRX (TRC20)"),
    ("bnb", "BNB روی BSC")
]

async def test_coin(coin, description):
    print(f"🚀 Testing: {description}")
    payment = await create_payment(
        price_amount=5.0,  # تست با 5 دلار
        price_currency="usd",
        pay_currency=coin,
        order_id=f"test-{coin}",
        description=f"Test payment for {coin.upper()}"
    )
    
    if payment:
        print(f"✅ Success for {coin.upper()}")
        print("💰 Pay address:", payment.get("pay_address"))
        print("📦 Status:", payment.get("payment_status"))
        print("🖼️ QR Base64 (short):", payment.get("qrcode_base64", "")[:50] + "...")
    else:
        print(f"❌ Failed for {coin.upper()}")

async def main():
    for coin, desc in COINS_TO_TEST:
        await test_coin(coin, desc)
        print("\n" + "-"*60 + "\n")

asyncio.run(main())
