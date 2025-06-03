#!/usr/bin/env python3
import os, json, argparse
from typing import Dict, Set

def load_keys(path: str):
    with open(path, 'r', encoding='utf-8') as f:
        data = json.load(f)  # ممکن است JSONDecodeError بدهد
    if isinstance(data, dict):
        return set(data.keys())
    return None

def main(directory: str):
    json_paths = []
    for root, _, files in os.walk(directory):
        for fn in files:
            if fn.lower().endswith('.json'):
                json_paths.append(os.path.join(root, fn))

    if not json_paths:
        print("❌ هیچ فایل JSON یافت نشد.")
        return

    key_map: Dict[str, Set[str]] = {}
    skipped = []

    for path in json_paths:
        try:
            keys = load_keys(path)
        except json.JSONDecodeError as e:
            print(f"❌ Syntax error in {path}: {e.msg} (line {e.lineno}, col {e.colno})")
            continue
        if keys is None:
            skipped.append(path)
        else:
            key_map[path] = keys

    if skipped:
        print("\n⚠️ فایل‌های لیست‌شده (ریشه‌شان JSON لیست است و ساختار مقایسه نمی‌شوند):")
        for p in skipped: print("   •", p)
    
    if not key_map:
        print("\n❌ هیچ JSON دیکشنری‌ای برای مقایسه پیدا نشد.")
        return

    ref_path, ref_keys = next(iter(key_map.items()))
    print(f"\n∘ مرجع: `{ref_path}` با {len(ref_keys)} کلید\n")

    any_issue = False
    for path, keys in key_map.items():
        if path == ref_path: continue
        missing = ref_keys - keys
        extra   = keys - ref_keys
        name = os.path.relpath(path, directory)
        if not missing and not extra:
            print(f"✅ `{name}` هماهنگ است.")
        else:
            any_issue = True
            print(f"❌ `{name}` نامتوازن:")
            if missing: print(f"    • گمشده: {sorted(missing)}")
            if extra:   print(f"    • اضافی:  {sorted(extra)}")

    print("\nنتیجه نهایی:")
    print("🎉 همهٔ دیکشنری‌ها یکسان‌اند!" if not any_issue else "❗ برخی نیاز به بازبینی دارند.")

if __name__ == '__main__':
    p = argparse.ArgumentParser()
    p.add_argument('directory', nargs='?', default=os.getcwd(),
                   help='مسیر ریشه پروژه (پیش‌فرض پوشهٔ فعلی)')
    args = p.parse_args()
    main(args.directory)
