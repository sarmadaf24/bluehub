import os

TEMPLATE_HEADER = '''from aiogram import Router
'''

TEMPLATE_ROUTER_DEF = '''
router = Router()
'''

TEMPLATE_EXPORT = '''
__all__ = ["router"]
'''

# ✅ مسیر دقیق به handlers/ نسبت به مسیر فعلی اسکریپت
CURRENT_DIR = os.path.dirname(os.path.abspath(__file__))
HANDLERS_DIR = os.path.join(CURRENT_DIR, "../vpn_bot/bot/handlers")

def generate_init_for_folder(folder_path):
    module_name = os.path.basename(folder_path)
    files = [
        f for f in os.listdir(folder_path)
        if f.endswith(".py") and f != "__init__.py" and not f.startswith("__")
    ]

    if not files:
        return  # پوشه‌ای بدون فایل قابل import

    lines = [TEMPLATE_HEADER]

    for file in files:
        name = file.replace(".py", "")
        lines.append(f"from .{name} import router as {name}_router")

    lines.append(TEMPLATE_ROUTER_DEF)

    for file in files:
        name = file.replace(".py", "")
        lines.append(f"router.include_router({name}_router)")

    lines.append(TEMPLATE_EXPORT)

    init_file = os.path.join(folder_path, "__init__.py")
    with open(init_file, "w", encoding="utf-8") as f:
        f.write("\n".join(lines))

    print(f"✅ Created __init__.py for: {module_name}")

def run():
    for entry in os.listdir(HANDLERS_DIR):
        folder_path = os.path.join(HANDLERS_DIR, entry)
        if os.path.isdir(folder_path) and not entry.startswith("__") and entry != "__pycache__":
            generate_init_for_folder(folder_path)

if __name__ == "__main__":
    run()
