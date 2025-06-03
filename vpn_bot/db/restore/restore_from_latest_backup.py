import os
import tarfile
import subprocess
from datetime import datetime

# مسیرهای پشتیبان‌گیری
BACKUP_DIR = "/root/bluehub/vpn_bot/db/backups"
FULL_BACKUP_DIR = os.path.join(BACKUP_DIR, "all")
PROJECT_BACKUP_DIR = os.path.join(BACKUP_DIR, "project")
DB_BACKUP_DIR = os.path.join(BACKUP_DIR, "db")

# مسیر پروژه
PROJECT_DIR = "/root/bluehub/vpn_bot"

# اطلاعات پایگاه داده
DB_NAME = "vpn_bot"
DB_USER = "sarmad"
DB_PASSWORD = "Sarmad0af2400"
DB_HOST = "127.0.0.1"
DB_PORT = "5432"

# تنظیم متغیر محیطی DATABASE_URL
os.environ['DATABASE_URL'] = f'postgresql+asyncpg://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}'

def get_latest_file(directory, extension):
    files = [f for f in os.listdir(directory) if f.endswith(extension)]
    if not files:
        return None
    files.sort(reverse=True)
    return os.path.join(directory, files[0])

def restore_full_backup():
    print("🔄 تلاش برای بازیابی از پشتیبان کامل...")
    backup_file = get_latest_file(FULL_BACKUP_DIR, ".tar.gz")
    if not backup_file:
        print("❌ پشتیبان کامل یافت نشد.")
        return False
    try:
        with tarfile.open(backup_file, "r:gz") as tar:
            tar.extractall(path="/")
        print("✅ بازیابی از پشتیبان کامل با موفقیت انجام شد.")
        return True
    except Exception as e:
        print(f"❌ خطا در بازیابی پشتیبان کامل: {e}")
        return False

def restore_project():
    print("🔄 تلاش برای بازیابی پروژه...")
    backup_file = get_latest_file(PROJECT_BACKUP_DIR, ".tar.gz")
    if not backup_file:
        print("❌ پشتیبان پروژه یافت نشد.")
        return False
    try:
        with tarfile.open(backup_file, "r:gz") as tar:
            tar.extractall(path="/")
        print("✅ بازیابی پروژه با موفقیت انجام شد.")
        return True
    except Exception as e:
        print(f"❌ خطا در بازیابی پروژه: {e}")
        return False

def restore_database():
    print("🔄 تلاش برای بازیابی پایگاه داده...")
    backup_file = get_latest_file(DB_BACKUP_DIR, ".sql")
    if not backup_file:
        print("❌ پشتیبان پایگاه داده یافت نشد.")
        return False
    try:
        os.environ['PGPASSWORD'] = DB_PASSWORD
        restore_command = [
            "psql",
            f"--host={DB_HOST}",
            f"--port={DB_PORT}",
            f"--username={DB_USER}",
            f"--dbname={DB_NAME}",
            "--file", backup_file
        ]
        subprocess.run(restore_command, check=True)
        print("✅ بازیابی پایگاه داده با موفقیت انجام شد.")
        return True
    except subprocess.CalledProcessError as e:
        print(f"❌ خطا در بازیابی پایگاه داده: {e}")
        return False

def run_post_restore():
    print("🔄 اجرای اسکریپت post_restore.py...")
    try:
        subprocess.run(['python3', 'post_restore.py'], check=True)
        print("✅ اسکریپت post_restore.py با موفقیت اجرا شد.")
    except subprocess.CalledProcessError as e:
        print(f"❌ خطا در اجرای اسکریپت post_restore.py: {e}")

def main():
    if restore_full_backup():
        run_post_restore()
        return
    if restore_project():
        if restore_database():
            run_post_restore()
            return
    print("❌ بازیابی از هیچ‌کدام از پشتیبان‌ها موفقیت‌آمیز نبود.")

if __name__ == "__main__":
    main()
