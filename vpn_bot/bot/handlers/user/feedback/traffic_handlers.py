# bot/handlers/user/traffic_handlers.py

from aiogram import Router, F
from aiogram.fsm.context import FSMContext
from sqlalchemy import select, func

from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.config import Config
from vpn_bot.db.models.traffic import TrafficRecord
from vpn_bot.utils.i18n import t
from aiogram.types import CallbackQuery, InlineKeyboardButton, InlineKeyboardMarkup
from aiogram.types import InlineKeyboardButton, InlineKeyboardMarkup

router = Router()
print("📦 traffic_handlers.py router loaded ✅")

@router.callback_query(F.data == "submenu_traffic")
async def traffic_menu_handler(callback: CallbackQuery, state: FSMContext):
    lang = (await state.get_data()).get("lang", "fa")

    text = t("traffic_categories_title", lang)
    buttons = [
        [InlineKeyboardButton(text="🔵 Meta (Facebook)",    callback_data="traffic_cat_social")],
        [InlineKeyboardButton(text="▶️ YouTube",           callback_data="traffic_cat_youtube")],
        [InlineKeyboardButton(text="💬 WhatsApp",          callback_data="traffic_cat_whatsapp")],
        [InlineKeyboardButton(text="📸 Instagram",         callback_data="traffic_cat_instagram")],
        [InlineKeyboardButton(text="🐦 Twitter",           callback_data="traffic_cat_twitter")],
        [InlineKeyboardButton(text="💼 LinkedIn",          callback_data="traffic_cat_linkedin")],
        [InlineKeyboardButton(text="📞 Skype",             callback_data="traffic_cat_skype")],
        [InlineKeyboardButton(text="📌 Pinterest",         callback_data="traffic_cat_pinterest")],
        [InlineKeyboardButton(text="🟢 Line",              callback_data="traffic_cat_line")],
        [InlineKeyboardButton(text="✈️ Telegram",          callback_data="traffic_cat_telegram")],
        [InlineKeyboardButton(text="🏠 Clubhouse",         callback_data="traffic_cat_clubhouse")],
        [InlineKeyboardButton(text="🎵 TikTok",            callback_data="traffic_cat_tiktok")],
        [InlineKeyboardButton(text="👻 Snapchat",          callback_data="traffic_cat_snapchat")],
        [InlineKeyboardButton(text=f"🔙 {t('back',lang)}", callback_data="my_subscriptions")],
    ]
    await callback.message.edit_text(
        text,
        reply_markup=InlineKeyboardMarkup(inline_keyboard=buttons)
    )

@router.callback_query(F.data.startswith("traffic_cat_"))
async def traffic_category_handler(callback: CallbackQuery, state: FSMContext):
    lang = (await state.get_data()).get("lang", "fa")
    category = callback.data.split("_", 2)[2]  # e.g. social, youtube, …

    async with AsyncSessionLocal() as sess:
        # مصرفِ آن دسته
        used_res = await sess.execute(
            select(func.sum(TrafficRecord.bytes_used))
            .where(TrafficRecord.user_id == callback.from_user.id)
            .where(TrafficRecord.category == category)
        )
        used = used_res.scalar() or 0

        # مصرفِ کل
        total_res = await sess.execute(
            select(func.sum(TrafficRecord.bytes_used))
            .where(TrafficRecord.user_id == callback.from_user.id)
        )
        total = total_res.scalar() or 0

        # درصد مصرف
        percent = (used / total * 100) if total else 0

        # تعداد جلسات (رکورد)
        count_res = await sess.execute(
            select(func.count())
            .where(TrafficRecord.user_id == callback.from_user.id)
            .where(TrafficRecord.category == category)
        )
        sessions = count_res.scalar() or 0

    # قالب پیام با استفاده از کلید i18n traffic_category_usage
    msg = t("traffic_category_usage", lang).format(
        category=t(f"traffic_{category}", lang),
        used=used,
        percent=round(percent, 2),
        sessions=sessions
    )

    await callback.message.edit_text(
        msg,
        reply_markup=InlineKeyboardMarkup(
            inline_keyboard=[[
                InlineKeyboardButton(
                    text=f"🔙 {t('back', lang)}",
                    callback_data="submenu_traffic"
                )
            ]]
        )
    )
