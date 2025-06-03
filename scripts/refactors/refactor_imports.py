import os

OLD = "db.models"
NEW = "db.models"
TARGET_DIR = "."

def refactor_file(path):
    try:
        with open(path, "r", encoding="utf-8") as f:
            content = f.read()
    except UnicodeDecodeError:
        with open(path, "r", encoding="latin-1") as f:
            content = f.read()

    if OLD not in content:
        return

    new_content = content.replace(OLD, NEW)

    with open(path, "w", encoding="utf-8") as f:
        f.write(new_content)

    print(f"🔧 Fixed import in {path}")

def walk_and_refactor(root):
    for subdir, _, files in os.walk(root):
        for file in files:
            if file.endswith(".py"):
                file_path = os.path.join(subdir, file)
                refactor_file(file_path)

if __name__ == "__main__":
    walk_and_refactor(TARGET_DIR)
