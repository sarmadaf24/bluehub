# 📁 vpn_bot/utils/__init__.py



from .introspection import auto_register_routers as auto_register, extract_clients
from .i18n import t, get_user_lang

__all__ = ["auto_register", "extract_clients", "t", "get_user_lang"]
