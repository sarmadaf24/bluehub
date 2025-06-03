# 📁 vpn_bot/services/referral_service.py

from sqlalchemy import select, func
from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.user import User

async def reward_referral(purchaser_id: int, amount: int) -> int:
    """
    اگر purchaser_id دارای referrer باشد، ۱۰٪ از amount را به کیف‌پول و total_referral_bonus
    ارجاع‌دهنده اضافه می‌کند و عدد بونوس را برمی‌گرداند.
    amount به تومان (یا واحد ارز شما) باشد.
    """
    async with AsyncSessionLocal() as sess:
        purchaser = await sess.get(User, purchaser_id)
        if not purchaser or not purchaser.referrer_id:
            return 0

        ref = await sess.get(User, purchaser.referrer_id)
        bonus = (amount * 10) // 100
        ref.balance = (ref.balance or 0) + bonus
        ref.total_referral_bonus = (ref.total_referral_bonus or 0) + bonus
        await sess.commit()
        return bonus

async def get_referral_stats(user_id: int) -> tuple[int,int]:
    """
    تعداد زیرمجموعه‌ها و مجموع بونوس دریافتی.
    """
    async with AsyncSessionLocal() as sess:
        # تعداد زیرمجموعه‌ها
        cnt = (await sess.execute(
            select(func.count(User.user_id)).where(User.referrer_id == user_id)
        )).scalar() or 0

        user = await sess.get(User, user_id)
        total_bonus = user.total_referral_bonus or 0

    return cnt, total_bonus
