# 🔧 gen_init_exports.py
import os
import ast

BASE_DIR = "./vpn_bot/db/models"  # مسیر هدف رو اگه جای دیگه‌ای هست، تغییر بده

def extract_exports(file_path):
    with open(file_path, "r", encoding="utf-8") as f:
        tree = ast.parse(f.read(), filename=file_path)

    exports = []
    for node in tree.body:
        if isinstance(node, (ast.ClassDef, ast.FunctionDef)):
            exports.append(node.name)
    return exports

def generate_init_py(directory):
    lines = []
    all_exports = []

    for filename in sorted(os.listdir(directory)):
        if filename.endswith(".py") and filename != "__init__.py":
            module_name = filename[:-3]
            file_path = os.path.join(directory, filename)
            exports = extract_exports(file_path)
            if exports:
                lines.append(f"from .{module_name} import {', '.join(exports)}")
                all_exports.extend(exports)

    lines.append(f"\n__all__ = [{', '.join(f'\"{name}\"' for name in all_exports)}]")

    init_path = os.path.join(directory, "__init__.py")
    with open(init_path, "w", encoding="utf-8") as f:
        f.write("\n".join(lines))

    print(f"✅ Generated: {init_path}")

def walk(base):
    for root, dirs, files in os.walk(base):
        if "__init__.py" in files:
            generate_init_py(root)

if __name__ == "__main__":
    walk(BASE_DIR)
