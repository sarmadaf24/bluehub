import os

BASE_DIR = "vpn_bot/bot/handlers"

def snake_to_camel(s):
    return ''.join(word.capitalize() for word in s.split('_'))

def create_init_py(path):
    entries = []
    for filename in os.listdir(path):
        if filename.endswith(".py") and filename != "__init__.py":
            module_name = filename[:-3]
            alias = f"{module_name}_router"
            entries.append((module_name, alias))

    if not entries:
        return False

    lines = []
    for module_name, alias in entries:
        lines.append(f"from .{module_name} import router as {alias}")
    lines.append("")
    all_exports = ", ".join(f'"{alias}"' for _, alias in entries)
    lines.append(f"__all__ = [{all_exports}]")
    content = "\n".join(lines) + "\n"

    init_file = os.path.join(path, "__init__.py")
    with open(init_file, "w") as f:
        f.write(content)
    print(f"✅ Generated: {init_file}")
    return True

def scan_all_dirs():
    for root, dirs, files in os.walk(BASE_DIR):
        create_init_py(root)

if __name__ == "__main__":
    print("🚀 Generating __init__.py files with __all__ ...")
    scan_all_dirs()
    print("🎉 Done.")
