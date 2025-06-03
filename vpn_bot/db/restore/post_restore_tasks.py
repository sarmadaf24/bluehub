import os
import subprocess

# تنظیم متغیر محیطی DATABASE_URL
os.environ['DATABASE_URL'] = 'postgresql+psycopg2://sarmad:Sarmad0af2400@127.0.0.1:5432/vpn_bot'

# مسیر فایل پیکربندی Alembic
alembic_config = 'vpn_bot/db/migrations/alembic.ini'

# اجرای دستور alembic upgrade head
try:
    print("🔄 اجرای مهاجرت‌های پایگاه داده با Alembic...")
    subprocess.run(['alembic', '-c', alembic_config, 'upgrade', 'head'], check=True)
    print("✅ مهاجرت‌های پایگاه داده با موفقیت انجام شد.")
except subprocess.CalledProcessError as e:
    print(f"❌ خطا در اجرای مهاجرت‌های پایگاه داده: {e}")
    exit(1)

# ایجاد پایگاه داده جدید
db_name = 'vpn_bot'
db_user = 'postgres'
try:
    print(f"🔄 ایجاد پایگاه داده جدید: {db_name}...")
    subprocess.run(['createdb', '-h', 'localhost', '-p', '5432', '-U', db_user, db_name], check=True)
    print(f"✅ پایگاه داده {db_name} با موفقیت ایجاد شد.")
except subprocess.CalledProcessError as e:
    print(f"❌ خطا در ایجاد پایگاه داده: {e}")
    exit(1)

# اجرای اسکریپت seedall
try:
    print("🔄 اجرای اسکریپت seedall برای مقداردهی اولیه داده‌ها...")
    subprocess.run(['python', '-m', 'vpn_bot.db.manage', 'seedall'], check=True)
    print("✅ اسکریپت seedall با موفقیت اجرا شد.")
except subprocess.CalledProcessError as e:
    print(f"❌ خطا در اجرای اسکریپت seedall: {e}")
    exit(1)
