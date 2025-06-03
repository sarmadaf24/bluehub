# scripts/scan_and_fix_all_imports.py

import os
import re

BASE_DIR = os.path.abspath(".")
TARGET_PREFIXES = {
    "db.models": "db.models",
    "db.core.base": "db.core.base",
    "db.core.init_db": "db.core.init_db",
    "db.core.session": "db.core.session",
    "db.core": "db.core",  # fallback
    "utils": "utils",
}

def should_scan(file):
    return file.endswith(".py") and "migrations" not in file and "alembic" not in file and "venv" not in file and "__pycache__" not in file

def refactor_imports_in_file(filepath):
    with open(filepath, "r", encoding="utf-8", errors="ignore") as f:
        content = f.read()

    new_content = content
    for old, new in TARGET_PREFIXES.items():
        new_content = re.sub(rf"\b{re.escape(old)}\b", new, new_content)

    if content != new_content:
        with open(filepath, "w", encoding="utf-8") as f:
            f.write(new_content)
        print(f"🔧 Fixed imports in {filepath}")

def walk_and_refactor():
    print("🚀 Scanning project for outdated import paths...\n")
    for root, _, files in os.walk(BASE_DIR):
        for file in files:
            if should_scan(file):
                filepath = os.path.join(root, file)
                refactor_imports_in_file(filepath)
    print("\n✅ Import path refactor complete.")

if __name__ == "__main__":
    walk_and_refactor()
