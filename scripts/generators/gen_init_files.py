import os

BASE_DIR = "vpn_bot/bot/handlers"

def collect_routers(folder):
    routers = []
    for filename in os.listdir(folder):
        full_path = os.path.join(folder, filename)
        if filename.endswith(".py") and filename != "__init__.py":
            name = filename.removesuffix(".py")
            routers.append(name)
        elif os.path.isdir(full_path):
            if "__init__.py" not in os.listdir(full_path):
                open(os.path.join(full_path, "__init__.py"), "w").close()
    return routers

def write_init(folder, routers, relative_path):
    lines = []
    all_list = []

    for router_file in routers:
        import_path = f".{router_file}"
        router_name = f"{router_file}_router"
        lines.append(f"from {import_path} import router as {router_name}")
        all_list.append(f'"{router_name}"')

    lines.append("\n__all__ = [\n    " + ",\n    ".join(all_list) + "\n]")

    init_path = os.path.join(folder, "__init__.py")
    with open(init_path, "w") as f:
        f.write("\n".join(lines))

    print(f"✅ Created: {init_path}")

def generate_all():
    for root, dirs, files in os.walk(BASE_DIR):
        routers = collect_routers(root)
        relative_path = os.path.relpath(root, BASE_DIR)
        if routers:
            write_init(root, routers, relative_path)

if __name__ == "__main__":
    generate_all()
