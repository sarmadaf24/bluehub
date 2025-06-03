# 📁 scripts/test_ss_config.py

import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))
from dotenv import load_dotenv
load_dotenv()

import asyncio
from vpn_bot.services.config_service import generate_config_for_user

async def test():
    config = await generate_config_for_user(user_id=123456789, protocol="shadowsocks")
    print(config)

if __name__ == "__main__":
    asyncio.run(test())
