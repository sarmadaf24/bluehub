# 📁 /root/bluehub/vpn_bot/bot/handlers/user/panel/user_config.py

import io
import qrcode
from urllib.parse import urlparse

from aiogram import Router, F
from aiogram.types import CallbackQuery, BufferedInputFile
from aiogram.fsm.context import FSMContext

from sqlalchemy import select
from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.config import Config
from vpn_bot.utils.i18n import t, get_user_lang
from vpn_bot.services.panel_service import PanelService
from config import XUI_PANEL_HOST, XUI_USERNAME, XUI_PASSWORD

router = Router()
print("📦 user_config.py router loaded ✅")

@router.callback_query(F.data.startswith("user:config_"))
async def user_config_handler(callback: CallbackQuery, state: FSMContext):
    # 1️⃣ زبان کاربر
    lang = (await state.get_data()).get("lang") or await get_user_lang(callback.from_user.id)

    # 2️⃣ بارگذاری کانفیگ از دیتابیس
    cfg_id = int(callback.data.split("_")[-1])
    async with AsyncSessionLocal() as sess:
        res = await sess.execute(select(Config).where(Config.id == cfg_id))
        cfg = res.scalars().first()

    if not cfg:
        return await callback.answer(t("no_configs", lang), show_alert=True)

    # 3️⃣ بازسازی لینک (یا از روی پانل دوباره بسازید)
    # اگر raw_link ذخیره کرده باشید، از آن استفاده کنید:
    if hasattr(cfg, "raw_link") and cfg.raw_link:
        link = cfg.raw_link
    else:
        # بازسازی با PanelService
        parsed = urlparse(XUI_PANEL_HOST)
        panel = PanelService(
            base_url=f"{parsed.scheme}://{parsed.netloc}",
            username=XUI_USERNAME,
            password=XUI_PASSWORD,
            panel_path=parsed.path
        )
        await panel.login()
        link = panel.generate_v2ray_link(
            protocol=cfg.protocol,
            uuid=cfg.uuid,
            domain=cfg.domain,
            port=cfg.port,
            # اگر نیاز به پارامترهای اضافی دارید، اینجا اضافه کنید
        )
        await panel.close()

    # 4️⃣ ارسال متن لینک
    await callback.message.answer(
        t("config_link_msg", lang).format(link=link),
        parse_mode="HTML"
    )

    # 5️⃣ ساخت و ارسال QR-code
    qr_img = qrcode.make(link)
    buf = io.BytesIO()
    qr_img.save(buf)  # فرمت به طور خودکار تشخیص داده می‌شود
    buf.seek(0)
    await callback.message.answer_photo(
        photo=BufferedInputFile(buf.read(), filename="config_qr.png"),
        caption=t("config_link_msg", lang).format(link=link),
    )

    # 6️⃣ پایان
    await callback.answer()
