from .config_cisco import CiscoConfig
from .config_ikev2 import IKEv2Config
from .config_ipsec import IPSecConfig
from .config_l2tp import L2TPConfig
from .config_openvpn import OpenVPNConfig
from .config_pptp import PPTPConfig
from .config_sstp import SSTPConfig
from .config_v2ray import V2RayConfig
from .config_wireguard import WireGuardConfig
from .config_shadowsocks import ShadowsocksConfig

__all__ = ["CiscoConfig", "IKEv2Config", "IPSecConfig", "L2TPConfig", "OpenVPNConfig", "PPTPConfig", "SSTPConfig", "V2RayConfig", "WireGuardConfig", "ShadowsocksConfig"]