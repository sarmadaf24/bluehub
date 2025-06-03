# scripts/generate_all_statements.py

import os

BASE_DIR = "vpn_bot/bot/handlers"

def generate_all_init_files(base_path):
    for root, dirs, files in os.walk(base_path):
        py_files = [f for f in files if f.endswith(".py") and f != "__init__.py"]
        if not py_files:
            continue

        init_file = os.path.join(root, "__init__.py")
        lines = []
        all_exports = []

        for f in py_files:
            module_name = f[:-3]
            alias = f"{module_name}_router" if "router" in f or "admin" in f else module_name
            lines.append(f"from .{module_name} import *")
            # We assume the imported module has its own __all__, so we don't alias specific names here
        lines.append("")
        lines.append("__all__ = []")
        lines.append("for mod in dir():")
        lines.append("    if mod.endswith('_router') or mod.endswith('_command'):")
        lines.append("        __all__.append(mod)")
        lines.append("")

        with open(init_file, "w") as f:
            f.write("\n".join(lines))

        print(f"✅ Updated: {init_file}")

if __name__ == "__main__":
    print("🚀 Scanning and updating __init__.py files with __all__ ...")
    generate_all_init_files(BASE_DIR)
    print("🎉 Done.")
