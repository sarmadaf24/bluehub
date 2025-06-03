# /root/bluehub/vpn_bot/api/schemas.py

from typing import Optional
from pydantic import BaseModel, Field


# Base shared
class ServerBase(BaseModel):
    name: str
    ip: str
    port: int
    protocol: str
    panel_path: str
    domain: Optional[str] = None
    is_active: Optional[bool] = True
    current_clients: Optional[int] = 0
    max_clients: Optional[int] = 0
    panel_username: Optional[str] = None
    panel_password: Optional[str] = None


# payload for creating a new server
class ServerCreate(ServerBase):
    pass  # همه فیلدهای لازم از Base ارث‌بری می‌کند


# payload for updating an existing server
class ServerUpdate(BaseModel):
    name: Optional[str] = None
    ip: Optional[str] = None
    port: Optional[int] = None
    protocol: Optional[str] = None
    panel_path: Optional[str] = None
    domain: Optional[str] = None
    is_active: Optional[bool] = None
    current_clients: Optional[int] = None
    max_clients: Optional[int] = None
    panel_username: Optional[str] = None
    panel_password: Optional[str] = None


# schema returned in responses
class ServerRead(ServerBase):
    id: int = Field(..., alias="id")

    class Config:
        orm_mode = True
        allow_population_by_field_name = True
