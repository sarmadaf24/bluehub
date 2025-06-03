# 📁 vpn_bot/services/exchange_service.py

import httpx
from typing import Dict
from datetime import datetime, timedelta

API_KEY = "b72bfaf92f3f75571e8de7ea"
BASE_URL = f"https://v6.exchangerate-api.com/v6/{API_KEY}/latest/USD"
CACHE_TTL = timedelta(minutes=30)

_cache: Dict[str, float] = {}
_last_fetched = None


async def get_exchange_rates() -> Dict[str, float]:
    global _cache, _last_fetched
    now = datetime.utcnow()

    if _cache and _last_fetched and now - _last_fetched < CACHE_TTL:
        return _cache

    try:
        async with httpx.AsyncClient() as client:
            resp = await client.get(BASE_URL)
            data = resp.json()
            rates = data["conversion_rates"]

            usd_to_irr = rates.get("IRR", 0)
            if usd_to_irr == 0:
                raise ValueError("IRR rate not available")

            _cache = {
                "toman": usd_to_irr / 10,
                "usd": usd_to_irr,
                "eur": usd_to_irr / rates["EUR"],
                "aed": usd_to_irr / rates["AED"],
                "try": usd_to_irr / rates["TRY"],
                "trx": usd_to_irr / rates["TRX"] if rates.get("TRX") else 1,
            }

            _last_fetched = now
            return _cache

    except Exception as e:
        print("⚠️ Error fetching rates:", e)
        return _cache or {
            "toman": 10, "usd": 42000, "eur": 45000,
            "aed": 11000, "try": 3000, "trx": 4000
        }
