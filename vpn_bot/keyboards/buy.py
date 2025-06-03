# 📁 vpn_bot/keyboards/buy.py

from aiogram.types import InlineKeyboardMarkup, InlineKeyboardButton
from vpn_bot.utils.i18n import t

# ✅ انتخاب پروتکل‌ها - ستونی


def protocol_selection_keyboard(lang: str = "fa") -> InlineKeyboardMarkup:
    protocols = [
        ("protocol_v2ray", "proto_v2ray"),
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

    # 🔙 دکمه برگشت به منوی اصلی
    buttons.append([
        InlineKeyboardButton(text=t("back", lang), callback_data="go:main")
    ])

    return InlineKeyboardMarkup(inline_keyboard=buttons)


def v2ray_type_keyboard(lang: str = "fa") -> InlineKeyboardMarkup:
    v2ray_types = [
        ("v2ray_vmess", "v2ray:vmess"),
        ("v2ray_vless", "v2ray:vless"),
        ("v2ray_trojan", "v2ray:trojan"),
        ("v2ray_shadowsocks", "v2ray:shadowsocks"),
    ]

    buttons = [
        [InlineKeyboardButton(text=t(text_key, lang), callback_data=cb_data)]
        for text_key, cb_data in v2ray_types
    ]

    # 🔙 دکمه برگشت به انتخاب پروتکل‌ها
    buttons.append([
        InlineKeyboardButton(text=t("back", lang),
                             callback_data="go:protocols")
    ])

    return InlineKeyboardMarkup(inline_keyboard=buttons)


def payment_type_keyboard(lang: str = "fa", v2ray_type: str = "") -> InlineKeyboardMarkup:
    buttons = [
        [InlineKeyboardButton(text=t("payment_zarinpal", lang),
                              callback_data="payment:zarinpal")],
        [InlineKeyboardButton(text=t("payment_paypal", lang),
                              callback_data="payment:paypal")],
        [InlineKeyboardButton(text=t("payment_crypto", lang),
                              callback_data="payment:crypto")],
        [InlineKeyboardButton(text=t("payment_card", lang),
                              callback_data="payment:card")],
        [InlineKeyboardButton(text=t("back", lang), callback_data="go:v2ray")]
    ]

    return InlineKeyboardMarkup(inline_keyboard=buttons)
