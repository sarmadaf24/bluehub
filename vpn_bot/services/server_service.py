# 📁 vpn_bot/services/server_service.py

from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.server import Server
from sqlalchemy import select


# 🔍 انتخاب بهترین سرور فعال برای یک پروتکل خاص
async def get_best_server(protocol: str) -> Server | None:
    async with AsyncSessionLocal() as session:
        result = await session.execute(
            select(Server)
            .where(Server.protocol == protocol)
            .where(Server.is_active == True)
            .where(Server.current_clients < Server.max_clients)
            .order_by(Server.current_clients.asc())
        )
        return result.scalars().first()


# 🟢 افزایش تعداد کاربران متصل به سرور
async def increment_server_clients(server_id: int):
    async with AsyncSessionLocal() as session:
        server = await session.get(Server, server_id)
        if server:
            server.current_clients += 1
            await session.commit()


# 🔻 کاهش تعداد کاربران متصل به سرور
async def decrement_server_clients(server_id: int):
    async with AsyncSessionLocal() as session:
        server = await session.get(Server, server_id)
        if server and server.current_clients > 0:
            server.current_clients -= 1
            await session.commit()
