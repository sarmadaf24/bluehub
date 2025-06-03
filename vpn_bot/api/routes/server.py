# vpn_bot/api/routes/server.py

from typing import List

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from vpn_bot.api.schemas import ServerCreate, ServerRead, ServerUpdate
from vpn_bot.db.models.server import Server as ServerModel
from vpn_bot.db.core.session import get_async_session

router = APIRouter()


@router.post("/", response_model=ServerRead)
async def create_server(
    payload: ServerCreate,
    session: AsyncSession = Depends(get_async_session),
):
    server = ServerModel(**payload.dict())
    session.add(server)
    await session.commit()
    await session.refresh(server)
    return server


@router.get("/", response_model=List[ServerRead])
async def list_servers(
    session: AsyncSession = Depends(get_async_session),
):
    result = await session.execute(select(ServerModel))
    return result.scalars().all()


@router.get("/{server_id}", response_model=ServerRead)
async def get_server(
    server_id: int,
    session: AsyncSession = Depends(get_async_session),
):
    server = await session.get(ServerModel, server_id)
    if not server:
        raise HTTPException(404, "Server not found")
    return server


@router.put("/{server_id}", response_model=ServerRead)
async def update_server(
    server_id: int,
    payload: ServerUpdate,
    session: AsyncSession = Depends(get_async_session),
):
    server = await session.get(ServerModel, server_id)
    if not server:
        raise HTTPException(404, "Server not found")
    for field, value in payload.dict(exclude_unset=True).items():
        setattr(server, field, value)
    await session.commit()
    await session.refresh(server)
    return server


@router.delete("/{server_id}", response_model=dict)
async def delete_server(
    server_id: int,
    session: AsyncSession = Depends(get_async_session),
):
    server = await session.get(ServerModel, server_id)
    if not server:
        raise HTTPException(404, "Server not found")
    await session.delete(server)
    await session.commit()
    return {"ok": True}
