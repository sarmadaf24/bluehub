# 📁 test_confirm_receipt.py

import sys
import os
sys.path.insert(0, os.path.abspath(os.path.dirname(__file__)))

import asyncio
import time
from datetime import datetime, timedelta

from db.models import Plan, Transaction, Config
from db.core.session import AsyncSessionLocal
from vpn_bot.services.xui_client import XUIClient, generate_qr_code_bytes

user_id = 123456789
plan_id = 1  # ← آیدی یکی از پلن‌های فعال که inbound داره
amount_usd = 1.0

async def test_confirm_receipt_manual():
    async with AsyncSessionLocal() as session:
        plan_result = await session.execute(
            Plan.__table__.select().where(Plan.id == plan_id)
        )
        plan_row = plan_result.first()
        if not plan_row:
            print("❌ پلن پیدا نشد.")
            return

        plan = await session.get(Plan, plan_id)
        await session.refresh(plan, ["inbound"])

        inbound = plan.inbound
        if not inbound:
            print("❌ اینباند ندارد.")
            return

        # فیلدهای مورد نیاز رو چک کنیم
        required = {
            "inbound_id": plan.inbound_id,
            "server": inbound.server,
            "port": inbound.port,
            "protocol": inbound.protocol,
        }
        if inbound.protocol == "shadowsocks":
            required["encryption"] = inbound.encryption
            required["password"] = inbound.password

        missing = [k for k, v in required.items() if not v]
        if missing:
            print("❌ مقادیر ناقص:", missing)
            return

        # اتصال به XUI و ساخت یوزر
        xui = XUIClient()
        try:
            new_client = await xui.add_client_to_inbound(
                inbound_id=plan.inbound_id,
                email=f"user_{user_id}",
                total_gb=plan.volume_gb or 0,
                expire_days=plan.duration_days,
                flow=""
            )
        except Exception as e:
            print("❌ اتصال به XUI شکست خورد:", e)
            return

        # لینک و QR
        try:
            link = xui.generate_v2ray_link(
                uuid=new_client["uuid"],
                domain=inbound.server,
                port=inbound.port,
                protocol=inbound.protocol,
                encryption=inbound.encryption if inbound.protocol == "shadowsocks" else None,
                password=inbound.password if inbound.protocol == "shadowsocks" else None,
            )
        except Exception as e:
            print("❌ ساخت لینک شکست خورد:", e)
            return

        qr = generate_qr_code_bytes(link)
        with open(f"qr_{plan.id}.png", "wb") as f:
            f.write(qr.read())
        print("✅ QR ساخته شد و ذخیره شد به صورت qr_<plan_id>.png")
        print("🔗 لینک کانفیگ:", link)

        expiration = datetime.utcnow() + timedelta(days=plan.duration_days)
        session.add(Transaction(
            user_id=user_id,
            plan_id=plan_id,
            amount=amount_usd,
            currency="IRT",
            gateway="manual",
            reference=f"manual-{int(time.time())}",
            status="paid",
            type="buy"
        ))
        session.add(Config(
            user_id=user_id,
            config_name=f"Card-Test-{int(time.time())}",
            protocol=inbound.protocol,
            server=inbound.server,
            port=inbound.port,
            uuid=new_client["uuid"],
            expiration_date=expiration,
            active=True,
            is_trial=False,
        ))
        await session.commit()

        print("✅ ثبت در دیتابیس انجام شد.")


if __name__ == "__main__":
    asyncio.run(test_confirm_receipt_manual())
