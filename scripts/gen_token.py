import asyncio
from vpn_bot.services.email_service import generate_email_token

async def main():
    # به جای 6727220793 آیدی کاربرتون رو بذارید
    token = await generate_email_token(6727220793)
    print("🎟️ New token:", token)

if __name__ == "__main__":
    asyncio.run(main())
