# 📁 vpn_bot/bot/handlers/admin/admin_panel.py
from aiogram import Router, F
from aiogram.types import (
    Message,
    CallbackQuery,
    InlineKeyboardMarkup,
    InlineKeyboardButton
)
from aiogram.filters import Command
from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.user import User
from vpn_bot.db.models import Config
from vpn_bot.db.models.plan import Plan
from vpn_bot.db.models.transaction import Transaction
from sqlalchemy import select, func
from vpn_bot.utils.i18n import t

router = Router()
print("📦 admin_panel.py router loaded ✅")


PAGE_SIZE = 5

# ✅ /admin command - نمایش منوی مدیریت


@router.message(Command("admin"))
async def handle_admin(message: Message):
    async with AsyncSessionLocal() as session:
        user = await session.get(User, message.from_user.id)
        lang = user.lang if user else "fa"

        if not user or user.role != "admin":
            await message.answer(t("no_access", lang))
            return

        keyboard = InlineKeyboardMarkup(inline_keyboard=[
            [
                InlineKeyboardButton(text=t("stats", lang),
                                     callback_data="admin_stats"),
                InlineKeyboardButton(text=t("users", lang),
                                     callback_data="admin_users")
            ],
            [
                InlineKeyboardButton(
                    text=t("add_plan", lang), callback_data="admin_add_plan"),
                InlineKeyboardButton(
                    text=t("broadcast", lang), callback_data="admin_broadcast")
            ]
        ])

        await message.answer(t("admin_welcome", lang), reply_markup=keyboard)

# ✅ آمار کلی سیستم


@router.callback_query(F.data == "admin_stats")
async def handle_stats(call: CallbackQuery):
    async with AsyncSessionLocal() as session:
        user = await session.get(User, call.from_user.id)
        lang = user.lang if user else "fa"

        user_count = await session.scalar(select(func.count()).select_from(User))
        plan_count = await session.scalar(select(func.count()).select_from(Plan))
        config_count = await session.scalar(select(func.count()).select_from(Config))
        trans_count = await session.scalar(select(func.count()).select_from(Transaction))

        msg = (
            f"{t('total_stats', lang)}\n"
            f"{t('stat_users', lang)}: {user_count}\n"
            f"{t('stat_plans', lang)}: {plan_count}\n"
            f"{t('stat_configs', lang)}: {config_count}\n"
            f"{t('stat_transactions', lang)}: {trans_count}"
        )

        await call.message.answer(msg)
        await call.answer()

# ✅ زیرمنوی مدیریت کاربران


@router.callback_query(F.data == "admin_users")
async def show_admin_user_panel(call: CallbackQuery):
    async with AsyncSessionLocal() as session:
        user = await session.get(User, call.from_user.id)
        lang = user.lang if user else "fa"

    keyboard = InlineKeyboardMarkup(inline_keyboard=[
        [InlineKeyboardButton(text=t("active_users_btn", lang),
                              callback_data="active_users")],
        [InlineKeyboardButton(
            text=t("inactive_users_btn", lang), callback_data="inactive_users")],
        [InlineKeyboardButton(
            text=t("recent_transactions_btn", lang), callback_data="recent_transactions")],
        [InlineKeyboardButton(text=t("list_all_users", lang),
                              callback_data="admin_users:0")]
    ])

    await call.message.edit_text(t("user_management", lang), reply_markup=keyboard)
    await call.answer()

# ✅ کاربران فعال


@router.callback_query(F.data == "active_users")
async def show_active_users(call: CallbackQuery):
    async with AsyncSessionLocal() as session:
        lang = (await session.get(User, call.from_user.id)).lang or "fa"
        configs = (await session.execute(
            select(Config).where(Config.active == 1)
        )).scalars().all()

        user_ids = list({c.user_id for c in configs})

        if not user_ids:
            msg = t("no_active_users", lang)
        else:
            users = (await session.execute(
                select(User).where(User.user_id.in_(user_ids))
            )).scalars().all()

            msg = t("active_users_list", lang) + "\n\n" + "\n".join(
                [f"{u.username or t('no_name', lang)} ({
                    u.user_id})" for u in users]
            )

        await call.message.answer(msg)
        await call.answer()

# ✅ کاربران غیرفعال


@router.callback_query(F.data == "inactive_users")
async def show_inactive_users(call: CallbackQuery):
    async with AsyncSessionLocal() as session:
        lang = (await session.get(User, call.from_user.id)).lang or "fa"

        all_users = (await session.execute(select(User))).scalars().all()
        active_user_ids = {
            c.user_id for c in (await session.execute(
                select(Config).where(Config.active == 1)
            )).scalars().all()
        }

        inactive_users = [
            u for u in all_users if u.user_id not in active_user_ids]

        if not inactive_users:
            msg = t("all_users_active", lang)
        else:
            msg = t("inactive_users_list", lang) + "\n\n" + "\n".join(
                [f"{u.username or t('no_name', lang)} ({
                    u.user_id})" for u in inactive_users]
            )

        await call.message.answer(msg)
        await call.answer()

# ✅ ۵ تراکنش آخر


@router.callback_query(F.data == "recent_transactions")
async def show_recent_transactions(call: CallbackQuery):
    async with AsyncSessionLocal() as session:
        lang = (await session.get(User, call.from_user.id)).lang or "fa"

        transactions = (await session.execute(
            select(Transaction).order_by(Transaction.trans_id.desc()).limit(5)
        )).scalars().all()

        if not transactions:
            msg = t("no_transactions", lang)
        else:
            msg = t("recent_transactions_list", lang) + "\n\n" + "\n".join(
                [f"💳 {t_.amount} {
                    t_.currency} - {t_.status.upper()} - ({t_.user_id})" for t_ in transactions]
            )

        await call.message.answer(msg)
        await call.answer()

# ✅ لیست کاربران با صفحه‌بندی


@router.callback_query(F.data.startswith("admin_users:"))
async def list_users(call: CallbackQuery):
    page = int(call.data.split(":")[1])
    async with AsyncSessionLocal() as session:
        lang = (await session.get(User, call.from_user.id)).lang or "fa"
        total_users = await session.scalar(select(func.count()).select_from(User))
        result = await session.execute(
            select(User)
            .order_by(User.user_id.desc())
            .offset(page * PAGE_SIZE)
            .limit(PAGE_SIZE)
        )
        users = result.scalars().all()

    if not users:
        await call.answer(t("no_users_found", lang))
        return

    msg = f"📋 {t('user_list', lang)}:\n\n"
    for user in users:
        msg += (
            f"🧑‍💻 ID: `{user.user_id}`\n"
            f"👤 {t('username', lang)}: @{user.username or '---'}\n"
            f"📞 {t('phone', lang)}: {user.phone or '---'}\n"
            f"🎩 {t('role', lang)}: {user.role or 'user'}\n"
            f"💰 {t('balance', lang)}: {user.balance} {
                t('currency_toman', lang)}\n"
            "➖➖➖➖➖\n"
        )

    buttons = []
    if page > 0:
        buttons.append(InlineKeyboardButton(t("previous", lang),
                       callback_data=f"admin_users:{page - 1}"))
    if (page + 1) * PAGE_SIZE < total_users:
        buttons.append(InlineKeyboardButton(t("next", lang),
                       callback_data=f"admin_users:{page + 1}"))

    keyboard = InlineKeyboardMarkup(
        inline_keyboard=[buttons] if buttons else [])

    await call.message.answer(msg, parse_mode="Markdown", reply_markup=keyboard)
    await call.answer()
