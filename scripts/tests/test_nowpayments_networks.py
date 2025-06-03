import asyncio
from vpn_bot.services.payment.nowpayments import create_payment

coins_to_test = [
    ("USDT", "trc20"),
    ("BNB", "bsc")
]

async def test_coin(coin, network):
    print(f"\n🚀 Testing: {coin} روی شبکه {network.upper()}")
    try:
        result = await create_payment(
            price_amount=5,
            price_currency="usd",
            pay_currency=coin.lower(),
            order_id=f"test-{coin.lower()}",
            description=f"Test payment via {coin.upper()}",
            network=network.lower()  # 🧠 network اضافه شده در پارامتر
        )
        if result:
            print(f"✅ Success for {coin}:")
            print(f"   🆔 ID: {result.get('payment_id')}")
            print(f"   💰 Address: {result.get('pay_address')}")
            print(f"   🖼 QR: {result.get('qrcode_base64')[:50]}...")
        else:
            print(f"❌ Failed for {coin}")
    except Exception as e:
        print(f"❌ Error for {coin}: {e}")

async def main():
    for coin, network in coins_to_test:
        await test_coin(coin, network)

if __name__ == "__main__":
    asyncio.run(main())
