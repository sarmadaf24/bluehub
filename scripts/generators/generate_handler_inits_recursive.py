import os

from pathlib import Path

TEMPLATE_HEADER = '''from aiogram import Router
'''

TEMPLATE_ROUTER_DEF = '''
router = Router()
'''

TEMPLATE_EXPORT = '''
__all__ = ["router"]
'''

BASE_HANDLERS_DIR = Path(__file__).resolve().parent.parent / "vpn_bot" / "bot" / "handlers"

def collect_handler_files(folder: Path):
    py_files = []
    for item in folder.glob("**/*.py"):
        if (
            item.name == "__init__.py"
            or item.name.startswith("__")
            or "__pycache__" in item.parts
        ):
            continue
        py_files.append(item)
    return py_files

def build_import_path(base: Path, target: Path):
    relative_path = target.relative_to(base)
    parts = relative_path.with_suffix('').parts
    return ".".join(parts)

def generate_init_py(folder: Path, handler_files):
    lines = [TEMPLATE_HEADER]

    for file in handler_files:
        import_path = build_import_path(folder, file)
        var_name = import_path.split(".")[-1] + "_router"
        lines.append(f"from .{import_path} import router as {var_name}")

    lines.append(TEMPLATE_ROUTER_DEF)

    for file in handler_files:
        var_name = build_import_path(folder, file).split(".")[-1] + "_router"
        lines.append(f"router.include_router({var_name})")

    lines.append(TEMPLATE_EXPORT)

    init_file = folder / "__init__.py"
    with init_file.open("w", encoding="utf-8") as f:
        f.write("\n".join(lines))

    print(f"✅ Generated __init__.py in: {folder.relative_to(BASE_HANDLERS_DIR)}")

def run():
    for folder in BASE_HANDLERS_DIR.iterdir():
        if folder.is_dir() and folder.name != "__pycache__":
            handler_files = collect_handler_files(folder)
            if handler_files:
                generate_init_py(folder, handler_files)

if __name__ == "__main__":
    run()
