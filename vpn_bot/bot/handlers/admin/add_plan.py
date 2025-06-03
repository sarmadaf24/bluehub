# 📁 vpn_bot/bot/handlers/admin/add_plan.py
# add_plan.py /root/bluewire/vpn_bot/bot/handlers/admin
from aiogram import Router, F
from aiogram.types import Message
from aiogram.fsm.context import FSMContext
from aiogram.fsm.state import StatesGroup, State
from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.plan import Plan
from vpn_bot.db.models.user import User
from vpn_bot.utils.i18n import t


router = Router()
print("📦 add_plan.py router loaded ✅")

# 🔄 FSM State‌ها برای گرفتن پلن جدید از ادمین


class AddPlanState(StatesGroup):
    waiting_for_name = State()
    waiting_for_duration = State()
    waiting_for_price = State()


@router.message(F.text == "/addplan")
async def start_add_plan(message: Message, state: FSMContext):
    async with AsyncSessionLocal() as session:
        user = await session.get(User, message.from_user.id)
        lang = user.lang if user else "fa"

    await message.answer(t("enter_plan_name", lang))
    await state.set_state(AddPlanState.waiting_for_name)


@router.message(AddPlanState.waiting_for_name)
async def get_plan_name(message: Message, state: FSMContext):
    await state.update_data(name=message.text.strip())

    async with AsyncSessionLocal() as session:
        user = await session.get(User, message.from_user.id)
        lang = user.lang if user else "fa"

    await message.answer(t("enter_plan_duration", lang))
    await state.set_state(AddPlanState.waiting_for_duration)


@router.message(AddPlanState.waiting_for_duration)
async def get_plan_duration(message: Message, state: FSMContext):
    async with AsyncSessionLocal() as session:
        user = await session.get(User, message.from_user.id)
        lang = user.lang if user else "fa"

    try:
        duration = int(message.text.strip())
    except ValueError:
        await message.answer(t("only_numbers", lang))
        return

    await state.update_data(duration_days=duration)
    await message.answer(t("enter_plan_price", lang))
    await state.set_state(AddPlanState.waiting_for_price)


@router.message(AddPlanState.waiting_for_price)
async def get_plan_price(message: Message, state: FSMContext):
    async with AsyncSessionLocal() as session:
        user = await session.get(User, message.from_user.id)
        lang = user.lang if user else "fa"

    try:
        price = int(message.text.strip())
    except ValueError:
        await message.answer(t("only_numbers", lang))
        return

    data = await state.get_data()
    name = data.get("name")
    duration = data.get("duration_days")

    async with AsyncSessionLocal() as session:
        plan = Plan(
            name=name,
            duration_days=duration,
            price=price,
            volume_gb=None
        )
        session.add(plan)
        await session.commit()

    await message.answer(
        t("plan_added", lang).format(name=name, duration=duration, price=price)
    )
    await state.clear()
