# vpn_bot/services/coupon_service.py

from datetime import datetime
from sqlalchemy import select, update
from vpn_bot.db.core.session import AsyncSessionLocal
from vpn_bot.db.models.coupon import Coupon

class CouponError(Exception):
    pass

async def apply_coupon(code: str, amount: int) -> int:
    """
    کوپن را اعتبارسنجی و مبلغ نهایی را برمی‌گرداند.
    """
    async with AsyncSessionLocal() as sess:
        result = await sess.execute(
            select(Coupon).where(Coupon.code == code)
        )
        coupon = result.scalar_one_or_none()

        if not coupon:
            raise CouponError("❌ کوپن پیدا نشد.")
        now = datetime.utcnow()
        if not (coupon.valid_from <= now <= coupon.valid_until):
            raise CouponError("❌ کوپن منقضی شده یا هنوز فعال نیست.")
        if coupon.used:
            raise CouponError("⚠️ این کوپن قبلا استفاده شده.")

        # محاسبه تخفیف
        if 0 < coupon.discount <= 100:
            discounted = amount * (100 - coupon.discount) // 100
        else:
            discounted = max(0, amount - coupon.discount)

        # علامت‌گذاری کوپن به‌عنوان استفاده‌شده
        await sess.execute(
            update(Coupon)
            .where(Coupon.code == code)
            .values(used=True)
        )
        await sess.commit()
        return discounted
