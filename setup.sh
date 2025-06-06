# فایل: setup.sh (در ریشه پروژه)

#!/usr/bin/env bash
set -euo pipefail

# ۱. ساخت و فعال‌سازی virtualenv
python3 -m venv .venv
source .venv/bin/activate

# ۲. ارتقاء pip و نصب وابستگی‌ها
pip install --upgrade pip
pip install -e .

# ۳. آماده‌سازی ENV
cp .env.example .env
echo "📝 لطفاً فایل .env را با مقادیر واقعی پر کنید، سپس Enter بزنید"
read -r

# ۴. اجرای مهاجرت‌ها
alembic upgrade head

# ۵. پایان
echo "✅ همه چیز آماده است. با دستور زیر ربات را اجرا کنید:"
echo "   source .venv/bin/activate && bluehub"
#chmod +x setup.sh
#./setup.sh