# vpn_bot/bot/handlers/common/guide/v2ray_platforms.py

from aiogram import Router, F
from aiogram.types import CallbackQuery, FSInputFile, InlineKeyboardMarkup, InlineKeyboardButton
from pathlib import Path
from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.user import User
from vpn_bot.utils.i18n import t
from vpn_bot.keyboards.guide.v2ray_platforms import v2ray_platforms_keyboard
from vpn_bot.keyboards.guide.v2ray import guide_protocols_keyboard

router = Router()
print("📦 v2ray_platforms.py router loaded ✅")

async def get_user(user_id: int) -> User | None:
    async with AsyncSessionLocal() as session:
        return await session.get(User, user_id)

# پایهٔ مسیر resources
BASE_GUIDES = Path(__file__).parents[3] / "resources" / "guides" / "v2ray"


@router.callback_query(F.data == "guide:v2ray")
async def show_platforms(callback: CallbackQuery):
    """نمایش منوی انتخاب پلتفرم‌ها"""
    user = await get_user(callback.from_user.id)
    lang = user.lang if user and user.lang else "fa"

    await callback.message.edit_text(
        t("guide_select_platform", lang),
        reply_markup=v2ray_platforms_keyboard(lang)
    )


@router.callback_query(F.data.startswith("guide:v2ray:"))
async def send_guide(callback: CallbackQuery):
    """ارسال تصاویر و متن آموزش برای هر پلتفرم"""
    user = await get_user(callback.from_user.id)
    lang = user.lang if user and user.lang else "fa"
    _, _, platform = callback.data.split(":", 2)

    # 1) پاک کردن کیبورد منوی قبلی
    await callback.message.edit_reply_markup(reply_markup=None)

    # 2) ارسال تصاویر مرحله‌ای
    images_dir = BASE_GUIDES / platform / lang / "images"
    if images_dir.exists():
        for img_path in sorted(images_dir.glob("*.png")):
            await callback.message.answer_photo(
                FSInputFile(str(img_path))
            )

    # 3) ارسال متن راهنما همراه دکمه‌ی «بازگشت»
    text_path = BASE_GUIDES / platform / lang / "text.txt"
    guide_text = text_path.read_text(encoding="utf-8") if text_path.exists() else ""
    back_keyboard = InlineKeyboardMarkup(inline_keyboard=[
        [InlineKeyboardButton(text=t("back", lang), callback_data="guide:back_to_protocols")]
    ])
    await callback.message.answer(guide_text, reply_markup=back_keyboard)


@router.callback_query(F.data == "guide:back_to_protocols")
async def back_to_protocols(callback: CallbackQuery):
    """بازگشت به منوی پروتکل‌ها"""
    user = await get_user(callback.from_user.id)
    lang = user.lang if user and user.lang else "fa"

    await callback.message.edit_text(
        t("guide_select_protocol", lang),
        reply_markup=guide_protocols_keyboard(lang)
    )
