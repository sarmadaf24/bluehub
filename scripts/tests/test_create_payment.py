# 📁 test_create_payment.py

import asyncio
from dotenv import load_dotenv
load_dotenv()

from vpn_bot.services.payment.nowpayments import create_payment

async def main():
    response = await create_payment(
        price_amount=5.0,          # 💵 مقدار به USD
        price_currency="usd",     # 💲 ارز مبنا
        pay_currency="trx",       # 🔁 رمز ارز کاربر
        order_id="test-123"       # 🆔 شناسه سفارش تستی
    )

    if response:
        print("✅ Payment created successfully:\n")
        print("💰 Pay to:", response.get("pay_address", "-"))
        print("🆔 Payment ID:", response.get("payment_id", "-"))
        print("📦 Status:", response.get("payment_status", "-"))
        print("🖼️ QR Base64:", response.get("qrcode_url", "-")[:100], "...")  # فقط ۱۰۰ کاراکتر اول
    else:
        print("❌ Failed to create payment")

asyncio.run(main())
