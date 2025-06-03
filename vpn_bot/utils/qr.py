# 📁 vpn_bot/utils/qr.py

import qrcode
import base64
import os
import io  # ✅ این خط جدید اضافه بشه
from PIL import Image
# ✅ تبدیل base64 به تصویر برای ارسال در بات
from aiogram.types import BufferedInputFile
QR_DIR = "vpn_bot/static/qr"

# 🧠 تولید و ذخیره QR در فایل PNG برای استفاده محلی (مثلاً نمایش در پنل ادمین)


def generate_qr_file(address: str, coin: str) -> str:
    os.makedirs(QR_DIR, exist_ok=True)
    filename = f"{coin.lower()}_{address[:6]}.png"
    filepath = os.path.join(QR_DIR, filename)

    qr = qrcode.QRCode(
        version=1,
        box_size=10,
        border=4
    )
    qr.add_data(address)
    qr.make(fit=True)
    img = qr.make_image(fill_color="black", back_color="white")
    img.save(filepath)
    return filepath

# 📦 تولید QR به‌صورت base64 برای استفاده در HTML / Bot
# 🧠 تولید QR Base64 برای آدرس پرداخت هر کوین


def generate_qr_base64(address: str) -> str:
    qr = qrcode.QRCode(
        version=1,
        box_size=10,
        border=4
    )
    qr.add_data(address)
    qr.make(fit=True)

    img = qr.make_image(fill_color="black", back_color="white")

    buffer = io.BytesIO()
    img.save(buffer, format="PNG")
    buffer.seek(0)
    base64_data = buffer.getvalue()
    import base64
    return f"data:image/png;base64,{base64.b64encode(base64_data).decode()}"


def get_qr_image_bytes(qr_base64: str | None) -> BufferedInputFile:
    if not qr_base64 or not isinstance(qr_base64, str):
        print("❌ QR Base64 is empty or invalid type.")
        return BufferedInputFile(b"", filename="invalid.png")

    try:
        base64_data = qr_base64.split(",")[1]
        missing_padding = len(base64_data) % 4
        if missing_padding:
            base64_data += "=" * (4 - missing_padding)
        byte_data = base64.b64decode(base64_data)

        # 🧪 بررسی معتبر بودن تصویر
        Image.open(io.BytesIO(byte_data)).verify()

        return BufferedInputFile(byte_data, filename="qr.png")

    except Exception as e:
        print(f"❌ Invalid QR Code image: {e}")
        return BufferedInputFile(b"", filename="invalid.png")
