import os
import re

# مسیر اصلی هندلرها
HANDLERS_ROOT = "vpn_bot/bot/handlers"
PROJECT_ROOT = "vpn_bot"  # جایی که قراره اسکن کنیم

# الگوی ایمپورت‌هایی که باید عوض بشن
OLD_IMPORT_PATTERN = re.compile(r"from\s+vpn_bot\.bot\.handlers\.([a-zA-Z0-9_]+)")

def build_handler_map():
    handler_map = {}

    for root, _, files in os.walk(HANDLERS_ROOT):
        for file in files:
            if file.endswith(".py") and file != "__init__.py":
                rel_path = os.path.relpath(os.path.join(root, file), HANDLERS_ROOT)
                module_path = rel_path.replace("/", ".").replace("\\", ".").replace(".py", "")
                module_name = file.replace(".py", "")

                # فقط اگه ماژول تکراری نباشه، اضافه کن
                if module_name not in handler_map:
                    handler_map[module_name] = module_path

    return handler_map

def find_python_files(base_dir):
    for root, _, files in os.walk(base_dir):
        for file in files:
            if file.endswith(".py"):
                yield os.path.join(root, file)

def refactor_file(file_path, handler_map):
    with open(file_path, "r", encoding="utf-8") as f:
        content = f.read()

    updated = False

    def replace(match):
        module = match.group(1)
        if module in handler_map:
            new_import = f"from vpn_bot.bot.handlers.{handler_map[module]}"
            print(f"  ↪ {module} → {handler_map[module]}")
            nonlocal updated
            updated = True
            return new_import
        return match.group(0)

    new_content = OLD_IMPORT_PATTERN.sub(replace, content)

    if updated:
        with open(file_path, "w", encoding="utf-8") as f:
            f.write(new_content)
        print(f"✅ Refactored: {file_path}")

def main():
    print("🚀 Building handler map...")
    handler_map = build_handler_map()
    print("🔍 Scanning and refactoring project...")
    for file in find_python_files(PROJECT_ROOT):
        refactor_file(file, handler_map)
    print("🎉 Done.")

if __name__ == "__main__":
    main()
