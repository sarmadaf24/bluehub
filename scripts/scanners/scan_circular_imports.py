# ✅ scripts/scan_circular_imports.py
import os
import ast

project_root = "vpn_bot"
import_graph = {}
visited = set()

def scan_imports(filepath):
    with open(filepath, 'r', encoding="utf-8") as f:
        node = ast.parse(f.read(), filename=filepath)
        imports = []

        for n in ast.walk(node):
            if isinstance(n, ast.ImportFrom):
                if n.module:
                    imports.append(n.module)
            elif isinstance(n, ast.Import):
                for alias in n.names:
                    imports.append(alias.name)
        return imports

def walk_files():
    for root, dirs, files in os.walk(project_root):
        for f in files:
            if f.endswith(".py"):
                full = os.path.join(root, f)
                mod = full.replace("/", ".").replace(".py", "")
                imports = scan_imports(full)
                import_graph[mod] = imports

def detect_cycles():
    def dfs(node, path):
        if node in path:
            print(f"🔁 Circular Import Detected: {' → '.join(path + [node])}")
            return
        if node in visited:
            return
        visited.add(node)
        for imp in import_graph.get(node, []):
            dfs(imp, path + [node])

    for module in import_graph:
        dfs(module, [])

if __name__ == "__main__":
    print("🔍 Scanning for circular imports and redundant ones...")
    walk_files()
    detect_cycles()
