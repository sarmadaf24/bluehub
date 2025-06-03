# 📁 vpn_bot/services/nowpayments_service.py

async def create_invoice(self, amount: float, fiat_currency: str, pay_currency: str,
                         order_id: str, description: str):
    response = await self.client.post(
        "/invoice",
        json={
            "price_amount": amount,
            "price_currency": fiat_currency,
            "order_id": order_id,
            "order_description": description,
            "pay_currency": pay_currency,
            # در صورت نیاز ipn_callback_url, success_url, cancel_url را هم اضافه کنید
        },
    )
    return response.json()
