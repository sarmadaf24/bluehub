#!/usr/bin/env python3
import os
import re

# 📁 Root path of the project
ROOT = "/root/bluehub"

# 🎯 Import targets to refactor
OLD_IMPORTS = [
    "vpn_bot.utils.lang",
    "vpn_bot.utils.language",
    "vpn_bot.utils.translate"
]

# ✅ What to replace them with
NEW_IMPORT = "vpn_bot.utils.i18n"

# 🔍 File extensions to scan
VALID_EXT = (".py",)

# 🚀 Refactor function
def refactor_utils_lang_imports():
    for root, _, files in os.walk(ROOT):
        for filename in files:
            if filename.endswith(VALID_EXT):
                path = os.path.join(root, filename)

                with open(path, 'r', encoding='utf-8') as f:
                    original_code = f.read()

                new_code = original_code
                for old in OLD_IMPORTS:
                    # Match 'from vpn_bot.utils.i18n import ...'
                    new_code = re.sub(
                        rf"from\s+{re.escape(old)}\s+import\s+(.*)",
                        rf"from {NEW_IMPORT} import \1",
                        new_code
                    )

                    # Match 'import vpn_bot.utils.i18n'
                    new_code = re.sub(
                        rf"import\s+{re.escape(old)}",
                        rf"import {NEW_IMPORT}",
                        new_code
                    )

                if new_code != original_code:
                    with open(path, 'w', encoding='utf-8') as f:
                        f.write(new_code)
                    print(f"✅ Patched: {path}")

# 🎬 Run
if __name__ == "__main__":
    print("🚀 Starting utils lang imports refactor...\n")
    refactor_utils_lang_imports()
    print("\n🎯 Done. Imports refactored to use `vpn_bot.utils.i18n`.")
