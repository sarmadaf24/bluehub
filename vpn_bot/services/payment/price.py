# 📁 vpn_bot/utils/price.py

def calculate_price(duration_days: int, volume_gb: int | None) -> int:
    if volume_gb is None:
        return 0  # برای پلن نامحدود

    base_price_per_gb = 2000  # پایه قیمت هر گیگ به تومان
    price = base_price_per_gb * volume_gb

    # تخفیف بر اساس مدت زمان
    if duration_days >= 365:
        price *= 0.55  # 45٪ تخفیف
    elif duration_days >= 180:
        price *= 0.65  # 35٪ تخفیف
    elif duration_days >= 90:
        price *= 0.75  # 25٪ تخفیف

    # تخفیف اضافه برای حجم بالا حتی اگر یک‌ماهه باشه
    if volume_gb >= 50 and volume_gb < 80:
        price *= 0.90  # 10٪ تخفیف
    elif volume_gb >= 80:
        price *= 0.80  # 20٪ تخفیف

    return int(price)
