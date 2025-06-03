#/root/bluehub/scripts/fix_utils_imports.py

import os

PROJECT_ROOT = "vpn_bot"

replacements = {
    "from utils.": "from vpn_bot.utils.",
    "import utils.": "import vpn_bot.utils.",
    "from utils import": "from vpn_bot.utils import",
    "import utils": "import vpn_bot.utils",
}

def fix_imports_in_file(file_path):
    with open(file_path, "r", encoding="utf-8") as f:
        content = f.read()

    new_content = content
    for old, new in replacements.items():
        new_content = new_content.replace(old, new)

    if new_content != content:
        print(f"🔧 اصلاح شد: {file_path}")
        with open(file_path, "w", encoding="utf-8") as f:
            f.write(new_content)

def walk_and_fix(directory):
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith(".py"):
                fix_imports_in_file(os.path.join(root, file))

if __name__ == "__main__":
    print(f"🚀 شروع اصلاح کامل importهای utils در پوشه {PROJECT_ROOT}...")
    walk_and_fix(PROJECT_ROOT)
    print("✅ همه فایل‌ها بررسی و اصلاح شدند.")

