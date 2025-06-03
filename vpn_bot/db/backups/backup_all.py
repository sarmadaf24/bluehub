#!/usr/bin/env python3
# /root/bluehub/vpn_bot/db/backups/backup_all.py

import os
import subprocess
import datetime
from pathlib import Path

# ==== تنظیمات ====
BACKUP_ROOT = Path("/root/bluehub/vpn_bot/db/backups")
PROJECT_DIR = Path("/root/bluehub")
DB_NAME = "vpn_bot"
DB_USER = "sarmad"
DB_PASSWORD = "Sarmad0af2400"
DB_HOST = "127.0.0.1"
DB_PORT = "5432"

# فهرست پوشه‌ها/الگوهای فایل که باید از آرشیو حذف شوند
EXCLUDES = [
    "db/backups",
    "__pycache__",
    "*.pyc", "*.pyo", "*.pyd",
    ".venv", "venv",
    "node_modules",
    "build", "dist", "*.egg-info", "bluehub.egg-info",
    ".git", ".gitignore",
    ".idea", ".vscode",
    ".pytest_cache", "pip-wheel-metadata",
    "coverage_html_report", ".coverage", ".mypy_cache",
    "logs", "tmp", "cache",
    "*.log", "*.tmp", "*.temp",
    "*.swp", "*~",
    ".DS_Store", "Thumbs.db",
    "*.coverage", "coverage.xml",
    "*.egg", "*.whl",
    "*.cache", "*.sqlite3",
    ".env", ".env.*",
    "*.bak", "*.old",
]

def ensure_dir(path: Path):
    path.mkdir(parents=True, exist_ok=True)

def backup_db(to_dir: Path, ts: str) -> Path:
    ensure_dir(to_dir)
    out = to_dir / f"db_backup_{ts}.sql"
    env = os.environ.copy()
    env["PGPASSWORD"] = DB_PASSWORD
    subprocess.run([
        "pg_dump", "-h", DB_HOST, "-p", DB_PORT, "-U", DB_USER,
        "-F", "c", "-b", "-v", "-f", str(out), DB_NAME
    ], env=env, check=True)
    return out

def backup_project_tar(to_dir: Path, ts: str) -> Path:
    ensure_dir(to_dir)
    out = to_dir / f"project_backup_{ts}.tar.gz"
    # آماده‌سازی آرگومان‌های --exclude
    exclude_args = []
    for pat in EXCLUDES:
        exclude_args += ["--exclude", pat]
    # دستور tar
    cmd = [
        "tar", "-czf", str(out),
        *exclude_args,
        "-C", str(PROJECT_DIR), "."
    ]
    subprocess.run(cmd, check=True)
    return out

def backup_full_tar(to_dir: Path, ts: str) -> Path:
    ensure_dir(to_dir)
    out = to_dir / f"full_backup_{ts}.tar.gz"

    # اول دیتابیس رو تو یه فولدر موقت بک‌آپ می‌گیریم
    temp = BACKUP_ROOT.parent / f"backup_tmp_{ts}"
    db_tmp = temp / "db"
    proj_tmp = temp / "project"
    ensure_dir(db_tmp); ensure_dir(proj_tmp)

    try:
        # 1) بک‌آپ دیتابیس
        db_file = backup_db(db_tmp, ts)

        # 2) بک‌آپ شسته‌رفته پروژه تو فولدر موقت
        #    این مرحله فقط برای «اضافه‌کردن» پروژه به آرشیو نهاییه:
        exclude_args = []
        for pat in EXCLUDES:
            exclude_args += ["--exclude", pat]
        subprocess.run([
            "tar", "-czf", str(proj_tmp / f"proj_tar_{ts}.tar.gz"),
            *exclude_args,
            "-C", str(PROJECT_DIR), "."
        ], check=True)

        # 3) حالا کلِ temp رو آرشیو نهایی می‌کنیم
        subprocess.run([
            "tar", "-czf", str(out),
            "-C", str(temp), "."
        ], check=True)

    finally:
        # پاک‌سازی موقت
        subprocess.run(["rm", "-rf", str(temp)], check=False)

    return out

if __name__ == "__main__":
    ts = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")

    db_dir   = BACKUP_ROOT / "db"
    proj_dir = BACKUP_ROOT / "project"
    full_dir = BACKUP_ROOT / "all"

    db_file   = backup_db(db_dir, ts)
    print(f"✅ بکاپ دیتابیس: {db_file}")

    proj_file = backup_project_tar(proj_dir, ts)
    print(f"✅ بکاپ پروژه: {proj_file}")

    full_file = backup_full_tar(full_dir, ts)
    print(f"✅ بکاپ کامل: {full_file}")
