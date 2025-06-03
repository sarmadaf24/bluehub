#!/usr/bin/env python3

import os

REPO_DIR = "."  # مسیر پروژه، می‌تونی به دلخواه تغییرش بدی
TARGET_NAME = "PanelService"
REPLACEMENT_NAME = "PanelService"
TARGET_EXTENSIONS = (".py",)

def should_process(file_path):
    return file_path.endswith(TARGET_EXTENSIONS)

def patch_file(file_path):
    with open(file_path, "r", encoding="utf-8") as f:
        content = f.read()

    if TARGET_NAME not in content:
        return False  # چیزی برای تغییر نبود

    patched = content.replace(TARGET_NAME, REPLACEMENT_NAME)

    with open(file_path, "w", encoding="utf-8") as f:
        f.write(patched)

    print(f"✅ Patched: {file_path}")
    return True

def run():
    for root, _, files in os.walk(REPO_DIR):
        for file in files:
            file_path = os.path.join(root, file)
            if should_process(file_path):
                patch_file(file_path)

if __name__ == "__main__":
    run()
