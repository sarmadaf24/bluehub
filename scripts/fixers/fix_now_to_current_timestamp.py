import os
import re

from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parent.parent
TARGET_EXTENSIONS = [".py"]
TARGET_PATTERN = r"server_default\s*=\s*func\.now\(\)"

replacement_import = "from sqlalchemy.sql import text"
replacement_code = 'server_default=text("CURRENT_TIMESTAMP")'

def patch_file(path: Path):
    with open(path, "r", encoding="utf-8") as f:
        content = f.read()

    if not re.search(TARGET_PATTERN, content):
        return False

    new_content = re.sub(TARGET_PATTERN, replacement_code, content)

    # اضافه‌کردن ایمپورت اگه نیست
    if replacement_import not in new_content:
        lines = new_content.splitlines()
        for i, line in enumerate(lines):
            if line.startswith("from") or line.startswith("import"):
                continue
            lines.insert(i, replacement_import)
            break
        new_content = "\n".join(lines)

    with open(path, "w", encoding="utf-8") as f:
        f.write(new_content)

    print(f"✅ Patched: {path}")
    return True

def scan_and_patch():
    print("🔍 Scanning for server_default=text("CURRENT_TIMESTAMP") ...")
    for root, _, files in os.walk(PROJECT_ROOT):
        for file in files:
            if any(file.endswith(ext) for ext in TARGET_EXTENSIONS):
                full_path = Path(root) / file
                try:
                    patch_file(full_path)
                except Exception as e:
                    print(f"❌ Error in {full_path}: {e}")

if __name__ == "__main__":
    scan_and_patch()
    print("🎉 All done. Ready to migrate like a boss.")
