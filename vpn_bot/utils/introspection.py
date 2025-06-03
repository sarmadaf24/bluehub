#/root/bluehub/vpn_bot/utils/introspection

import importlib
import pkgutil
import logging
from aiogram import Router
from types import ModuleType
from typing import List

logger = logging.getLogger(__name__)


def auto_register_routers(base_package: ModuleType, raise_errors: bool = False) -> List[Router]:
    # 🔍 اسکن برای روترها
    routers = []
    for finder, name, ispkg in pkgutil.walk_packages(
        path=base_package.__path__,
        prefix=base_package.__name__ + "."
    ):
        try:
            module = importlib.import_module(name)
            router = getattr(module, "router", None)
            if isinstance(router, Router):
                routers.append(router)
                logger.debug(f"✅ Router یافت شد: {name}")
        except Exception as e:
            logger.warning(f"⚠️ خطا در import {name}: {e}")
            if raise_errors:
                raise
    return routers

# ✅ حالا بعد از تعریف، alias بده:
auto_register = auto_register_routers


def extract_clients(inbound: dict) -> list[dict]:
    # 📦 گرفتن لیست کلاینت‌ها از inbound
    protocol = inbound.get("protocol", "").lower()
    clients = inbound.get("settings", {}).get("clients", [])
    for client in clients:
        client["protocol"] = protocol
        client["port"] = inbound.get("port")
        client["address"] = inbound.get("address")
        client["network"] = inbound.get("streamSettings", {}).get("network", "")
        client["security"] = inbound.get("streamSettings", {}).get("security", "")
    return clients
