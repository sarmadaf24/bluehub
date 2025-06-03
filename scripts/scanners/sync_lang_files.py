import os
import json

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
LANG_DIR = os.path.join(BASE_DIR, "../vpn_bot/langs")

REFERENCE_LANG = "en"  # ← زبان مرجع
REFERENCE_FILE = os.path.join(LANG_DIR, f"{REFERENCE_LANG}.json")

def load_json(file_path):
    with open(file_path, "r", encoding="utf-8") as f:
        return json.load(f)

def save_json(file_path, data):
    with open(file_path, "w", encoding="utf-8") as f:
        json.dump(data, f, indent=2, ensure_ascii=False)

def sync_languages():
    print("🔍 Syncing language files using reference:", REFERENCE_LANG)
    
    ref_data = load_json(REFERENCE_FILE)

    for filename in os.listdir(LANG_DIR):
        if not filename.endswith(".json") or filename == f"{REFERENCE_LANG}.json":
            continue

        lang_code = filename.replace(".json", "")
        filepath = os.path.join(LANG_DIR, filename)
        lang_data = load_json(filepath)

        updated = False
        for key, value in ref_data.items():
            if key not in lang_data:
                lang_data[key] = value
                updated = True
                print(f"➕ Added missing key to {lang_code}: {key}")

        if updated:
            save_json(filepath, lang_data)
            print(f"✅ {lang_code}.json updated and saved.")
        else:
            print(f"✅ {lang_code}.json already synced.")

    print("🎉 All language files synced successfully!")

if __name__ == "__main__":
    sync_languages()

