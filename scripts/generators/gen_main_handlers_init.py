# scripts/gen_main_handlers_init.py

import os

BASE_PATH = "vpn_bot/bot/handlers"
IMPORT_PATH = "vpn_bot.bot.handlers"

def build_main_init():
    imports = []
    all_exports = []

    for root, dirs, files in os.walk(BASE_PATH):
        rel_path = os.path.relpath(root, BASE_PATH)
        if rel_path == ".":
            continue
        init_file = os.path.join(root, "__init__.py")
        if os.path.exists(init_file):
            module_path = rel_path.replace(os.sep, ".")
            import_line = f"from .{module_path} import *"
            imports.append(import_line)

    content = "\n".join(imports)
    content += "\n\n__all__ = []\n"
    content += "for mod in [\n"
    for root, dirs, files in os.walk(BASE_PATH):
        rel_path = os.path.relpath(root, BASE_PATH)
        if rel_path == ".":
            continue
        module_path = rel_path.replace(os.sep, ".")
        content += f"    {module_path}.__all__,\n"
    content += "]:\n    __all__.extend(mod)\n"

    with open(os.path.join(BASE_PATH, "__init__.py"), "w") as f:
        f.write(content)

    print("✅ Generated main __init__.py for handlers")

if __name__ == "__main__":
    print("🚀 Generating vpn_bot/bot/handlers/__init__.py ...")
    build_main_init()
    print("🎉 Done.")
