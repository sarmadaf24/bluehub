# 📁 vpn_bot/api/server_manager.py
from fastapi import APIRouter
from pydantic import BaseModel
from vpn_bot.db.models.server import Server
from vpn_bot.db.core.session import AsyncSessionLocal
from sqlalchemy import insert

router = APIRouter()


class ServerInput(BaseModel):
    name: str
    ip: str
    port: int
    protocol: str
    country: str = "Unknown"
    max_clients: int = 200


@router.post("/servers/add")
async def add_server(data: ServerInput):
    async with AsyncSessionLocal() as session:
        stmt = insert(Server).values(
            name=data.name,
            ip=data.ip,
            port=data.port,
            protocol=data.protocol,
            country=data.country,
            is_active=True,
            current_clients=0,
            max_clients=data.max_clients
        )
        await session.execute(stmt)
        await session.commit()
        return {"status": "✅ Server added"}

from vpn_bot.api.routes.verify_email import router as verify_email_router

app.include_router(
    verify_email_router,
    prefix="/api",         # یا هر پیشوندی که مد نظر دارید
    tags=["email_verification"]
)