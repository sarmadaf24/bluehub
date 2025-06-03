# vpn_bot/keyboards/guide/v2ray.py

from aiogram.types import InlineKeyboardMarkup, InlineKeyboardButton
from vpn_bot.utils.i18n import t

def guide_protocols_keyboard(lang: str = "fa") -> InlineKeyboardMarkup:
    protocols = [
        ("protocol_v2ray", "guide:v2ray"),
        ("protocol_openvpn", "coming_soon"),
        ("protocol_wireguard", "coming_soon"),
        ("protocol_l2tp", "coming_soon"),
        ("protocol_pptp", "coming_soon"),
        ("protocol_sstp", "coming_soon"),
        ("protocol_cisco", "coming_soon"),
        ("protocol_ikev2", "coming_soon"),
        ("protocol_ipsec", "coming_soon"),
    ]

    buttons = [
        [InlineKeyboardButton(text=t(text_key, lang), callback_data=cb_data)]
        for text_key, cb_data in protocols
    ]

    # 🔙 دکمه برگشت
    buttons.append([
        InlineKeyboardButton(text=t("back", lang), callback_data="go:main")
    ])

    return InlineKeyboardMarkup(inline_keyboard=buttons)
