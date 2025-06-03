#/root/bluehub/scripts/tag_files_with_path.py

import os

BASE_DIR = "vpn_bot"

def update_python_files(root_dir):
    for subdir, _, files in os.walk(root_dir):
        for file in files:
            if file.endswith(".py"):
                full_path = os.path.join(subdir, file)
                relative_path = os.path.relpath(full_path, start=BASE_DIR)
                comment_line = f"# 📁 {BASE_DIR}/{relative_path}\n"

                with open(full_path, "r", encoding="utf-8") as f:
                    lines = f.readlines()

                # حذف اگر خط اول از قبل مشابه باشه
                if lines and lines[0].startswith("# 📁 "):
                    lines = lines[1:]

                # اضافه کردن خط جدید
                lines.insert(0, comment_line)

                with open(full_path, "w", encoding="utf-8") as f:
                    f.writelines(lines)

                print(f"✅ updated: {relative_path}")

if __name__ == "__main__":
    update_python_files(BASE_DIR)
