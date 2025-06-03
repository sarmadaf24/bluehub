# /root/bluehub/vpn_bot/bot/handlers/user/panel/menu_handlers.py

from aiogram import Router, F
from aiogram.types import CallbackQuery, InlineKeyboardMarkup, InlineKeyboardButton
from aiogram.fsm.context import FSMContext

from vpn_bot.utils.i18n import t
from vpn_bot.keyboards.main import main_menu_inline
from vpn_bot.keyboards.buy import protocol_selection_keyboard, payment_type_keyboard
from sqlalchemy import select

from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.config import Config

router = Router()
print("📦 menu_handlers.py router loaded ✅")

@router.callback_query(F.data == "my_subscriptions")
async def my_subscriptions_handler(callback: CallbackQuery, state: FSMContext):
    lang = (await state.get_data()).get("lang", "fa")

    # --- چک کانفیگ خریداری‌شده ---
    async with AsyncSessionLocal() as sess:
        res = await sess.execute(
            select(Config)
            .where(Config.user_id == callback.from_user.id)
            .where(~Config.config_name.ilike("%trial%"))
            .limit(1)
        )
        paid_cfg = res.scalars().first()

    if not paid_cfg:
        # هیچ کانفیگ خریداری‌شده‌ای نیست → پیام هشدار
        return await callback.answer(
            t("no_purchased_subscription", lang),
            show_alert=True
        )

    # اگر کانفیگ خریداری‌شده بود، ادامه بده به منوی اشتراک‌ها
    await show_my_configs_menu(callback, state)


# ── «اشتراک‌های من» ────────────────────────────────────────────────────────────
@router.callback_query(F.data == "main:my_configs")
async def show_my_configs_menu(callback: CallbackQuery, state: FSMContext):
    lang = (await state.get_data()).get("lang", "fa")

    # بارگذاری آخرین کانفیگ کاربر
    async with AsyncSessionLocal() as sess:
        res = await sess.execute(
            select(Config)
            .where(Config.user_id == callback.from_user.id)
            .order_by(Config.created_at.desc())
            .limit(1)
        )
        cfg = res.scalars().first()

    if not cfg:
        await callback.answer(t("no_configs", lang), show_alert=True)
        return

    header = t("my_configs_header", lang)
    buttons = [
        # وضعیت اشتراک
        [InlineKeyboardButton(text=t("submenu_status", lang),
                              callback_data=f"user:status_{cfg.id}")],
        # منوی اول تمدید
        [InlineKeyboardButton(text=t("submenu_renew", lang),
                              callback_data=f"renew_config_{cfg.id}")],
        # و بقیه...
        [InlineKeyboardButton(text=t("submenu_wallet", lang),
                              callback_data=f"user:wallet_{cfg.id}")],
        [InlineKeyboardButton(text=t("submenu_traffic", lang),
                              callback_data="submenu_traffic")],
        [InlineKeyboardButton(text=t("submenu_config", lang),
                              callback_data=f"user:config_{cfg.id}")],

        # برگشت
        [InlineKeyboardButton(text=t("back_to_main", lang),
                              callback_data="go:main")],
    ]

    kb = InlineKeyboardMarkup(inline_keyboard=buttons)
    await callback.message.edit_text(header, reply_markup=kb, parse_mode="HTML")
    await callback.answer()


@router.callback_query(F.data == "go:main")
async def go_to_main(callback: CallbackQuery, state: FSMContext):
    lang = (await state.get_data()).get("lang", "fa")
    await callback.message.edit_text(
        t("home_msg", lang),
        reply_markup=main_menu_inline(lang),
        parse_mode="HTML"
    )
    await callback.answer()


# ── وضعیت اشتراک ──────────────────────────────────────────────────────────────
@router.callback_query(F.data.startswith("user:status_"))
async def submenu_status(callback: CallbackQuery, state: FSMContext):
    lang = (await state.get_data()).get("lang", "fa")
    cfg_id = int(callback.data.split("_")[1])

    async with AsyncSessionLocal() as sess:
        res = await sess.execute(select(Config).where(Config.id == cfg_id))
        cfg = res.scalars().first()

    if not cfg:
        return await callback.answer(t("no_configs", lang), show_alert=True)

    total = cfg.transfer_enable or 0
    used  = getattr(cfg, "transfer_enable_used", 0)
    remaining = max(total - used, 0)

    text = (
        f"🧾 <b>{t('submenu_status', lang)}</b>\n\n"
        f"📦 {cfg.name}\n"
        f"⏳ {cfg.created_at:%Y-%m-%d} – {cfg.expiration_date:%Y-%m-%d}\n"
        f"📊 {used/1024**3:.2f}/{total/1024**3:.2f} GB\n"
        f"🔰 {t('remaining', lang)}: {remaining/1024**3:.2f} GB"
    )
    kb = InlineKeyboardMarkup(inline_keyboard=[
        [InlineKeyboardButton(text=t("back_to_main", lang),
                              callback_data="go:main")]
    ])
    await callback.message.edit_text(text, reply_markup=kb, parse_mode="HTML")
    await callback.answer()


# ── منوی «تمدید اشتراک» ─────────────────────────────────────────────────────────
@router.callback_query(F.data.startswith("renew_config_"))
async def submenu_renew_menu(callback: CallbackQuery, state: FSMContext):
    lang = (await state.get_data()).get("lang", "fa")
    cfg_id = int(callback.data.split("_")[-1])

    header = t("choose_renew_submenu", lang)
    buttons = [
        [InlineKeyboardButton(text=t("renew_same", lang),
                              callback_data=f"user:renew_same_{cfg_id}")],
        [InlineKeyboardButton(text=t("renew_change", lang),
                              callback_data=f"user:renew_change_{cfg_id}")],
        [InlineKeyboardButton(text=t("back_to_configs", lang),
                              callback_data="main:my_configs")],
    ]
    kb = InlineKeyboardMarkup(inline_keyboard=buttons)

    await callback.message.edit_text(header, reply_markup=kb, parse_mode="HTML")
    await callback.answer()


# ── «🔁 تمدید همین پلن» ───────────────────────────────────────────────────────────
@router.callback_query(F.data.startswith("user:renew_same_"))
async def handle_renew_same(callback: CallbackQuery, state: FSMContext):
    lang = (await state.get_data()).get("lang", "fa")
    cfg_id = int(callback.data.split("_")[-1])

    # بارگذاری کانفیگ برای استخراج plan و protocol
    async with AsyncSessionLocal() as sess:
        res = await sess.execute(select(Config).where(Config.id == cfg_id))
        cfg = res.scalars().first()
    if not cfg:
        return await callback.answer(t("no_configs", lang), show_alert=True)

    # فرض می‌کنیم config.config_name == "Plan-<id>"
    try:
        plan_id = int(cfg.config_name.split("-")[-1])
    except:
        return await callback.answer("❌ خطا در استخراج پلن.", show_alert=True)

    # ذخیره در state برای ادامه در buy_flow
    await state.update_data(plan_id=plan_id, v2ray_type=cfg.protocol)

    # همان صفحه‌ی انتخاب روش پرداختِ buy_flow
    await callback.message.edit_text(
        t("choose_payment_method", lang),
        reply_markup=payment_type_keyboard(lang, cfg.protocol)
    )
    await callback.answer()


# ── «⚙️ تغییر پلن» ────────────────────────────────────────────────────────────────
@router.callback_query(F.data.startswith("user:renew_change_"))
async def handle_renew_change(callback: CallbackQuery, state: FSMContext):
    lang = (await state.get_data()).get("lang", "fa")
    # می‌رویم سراغ انتخاب پروتکل مثل شروع خریدِ جدید
    await callback.message.edit_text(
        t("choose_protocol", lang),
        reply_markup=protocol_selection_keyboard(lang)
    )
    await callback.answer()


