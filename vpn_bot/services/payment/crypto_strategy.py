# 📁 vpn_bot/services/payment/crypto_strategy.py

from abc import ABC, abstractmethod

class CryptoProvider(ABC):
    @abstractmethod
    async def create_payment(self, amount_usd: float, order_id: str) -> dict:
        ...
    @abstractmethod
    async def get_status(self, payment_id: str) -> str:
        ...

# مثال پیاده‌سازی NowPayments
class NowPaymentsProvider(CryptoProvider):
    async def create_payment(self, amount_usd, order_id):
        # call POST /v1/payment
        ...
    async def get_status(self, payment_id):
        # call GET /v1/payment/{id}
        ...

# در زمان اجرا:
provider_map = {
    "nowpayments": NowPaymentsProvider(),
    "coingate": CoinGateProvider(),
    # ...
}
