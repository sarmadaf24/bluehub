#!/usr/bin/env python3
import os
import json
import re
import time
from pathlib import Path

import openai
from dotenv import load_dotenv
from openai.error import RateLimitError, APIError

# ─── CONFIG ────────────────────────────────────────────────────────────────────
load_dotenv()  # اگر .env دارید
openai.api_key = os.getenv("OPENAI_API_KEY")
MODEL = os.getenv("OPENAI_MODEL", "gpt-3.5-turbo-16k")

INPUT_FILE = Path("en.json")
OUTPUT_DIR = Path("translations_sync")
OUTPUT_DIR.mkdir(exist_ok=True)

# کمتر تماس بخواهیم، اندازه پچ را بزرگ‌تر می‌گیریم
CHUNK_SIZE   = 1000   # حدود دو پچ برای 2116 کلید
THROTTLE_SEC = 5      # مکث اجباری بین پچ‌‌ها
MAX_RETRIES  = 8      # تلاش برای RateLimit
# ────────────────────────────────────────────────────────────────────────────────

# زبان‌ها
LANGUAGES = {
    "pt-BR":"Brazilian Portuguese","hi":"Hindi","zh":"Chinese","jp":"Japanese","it":"Italian",
    "ko":"Korean","pt":"European Portuguese","ku":"Kurdish","pl":"Polish","el":"Greek",
    "ar":"Arabic","de":"German","es":"Spanish","ur":"Urdu","ru":"Russian","fr":"French",
    "fa":"Persian","ckb":"Kurdish (Sorani)","uk":"Ukrainian","tl":"Tagalog","vi":"Vietnamese",
    "id":"Indonesian","ms":"Malay"
}

# ─── Helpers ────────────────────────────────────────────────────────────────────
def chunk_dict(d: dict, size: int):
    items = list(d.items())
    for i in range(0, len(items), size):
        yield dict(items[i:i+size])

def protect(text):
    # لیست یا غیررشته را str کن، placeholderها را موقتاً __PHn__ کن
    if isinstance(text, list):
        text = "\n".join(text)
    elif not isinstance(text, str):
        text = str(text)
    phs = re.findall(r"\{[^}]+\}", text)
    tmp = text
    for i,p in enumerate(phs):
        tmp = tmp.replace(p, f"__PH{i}__")
    return tmp, phs

def restore(text, phs):
    out = text
    for i,p in enumerate(phs):
        out = out.replace(f"__PH{i}__", p)
    return out

def translate_patch(patch: dict, lang_name: str) -> dict:
    prompt = (
        f"Translate this JSON dictionary into {lang_name}. "
        "Keep keys unchanged, preserve placeholders __PH0__, __PH1__, etc., "
        "and return exactly a valid JSON object with only translated values.\n\n"
        + json.dumps(patch, ensure_ascii=False)
    )
    backoff = 5
    for attempt in range(1, MAX_RETRIES+1):
        try:
            resp = openai.ChatCompletion.create(
                model=MODEL,
                messages=[
                    {"role":"system","content":"You are a professional translator. Output valid JSON."},
                    {"role":"user",  "content":prompt}
                ],
                temperature=0.0,
                max_tokens=8000
            )
            return json.loads(resp.choices[0].message.content.strip())
        except RateLimitError:
            print(f"[{lang_name}] RateLimit, retry {attempt}/{MAX_RETRIES} after {backoff}s")
            time.sleep(backoff)
            backoff = min(backoff*2, 300)
        except APIError as e:
            print(f"[{lang_name}] API error: {e}. retrying in {backoff}s")
            time.sleep(backoff)
    raise RuntimeError(f"{lang_name}: failed after {MAX_RETRIES} retries")

# ─── Main ───────────────────────────────────────────────────────────────────────
def main():
    en_dict = json.loads(INPUT_FILE.read_text(encoding="utf-8"))
    total = len(en_dict)
    print(f"Source keys: {total}")

    for code, lang in LANGUAGES.items():
        out_path = OUTPUT_DIR/f"{code}.json"
        # بارگذاری کش
        if out_path.exists():
            translated = json.loads(out_path.read_text(encoding="utf-8"))
        else:
            translated = {}

        print(f"\n=== Translating to {code} ({lang}), already {len(translated)}/{total} ===")
        for patch in chunk_dict(en_dict, CHUNK_SIZE):
            # فقط آن‌هایی که باقی‌مانده
            need = {k:v for k,v in patch.items() if k not in translated}
            if not need:
                continue

            # محافظت placeholder
            tmp, phmap = {}, {}
            for k,v in need.items():
                p, phs = protect(v)
                tmp[k], phmap[k] = p, phs

            # ترجمه
            translated_patch = translate_patch(tmp, lang)

            # بازگردانی و merge
            for k, val in translated_patch.items():
                translated[k] = restore(val, phmap[k])

            # ذخیره‌ی موقت
            out_path.write_text(json.dumps(translated, ensure_ascii=False, indent=2), encoding="utf-8")
            done = len(translated)
            print(f"[{code}] +{len(need)} => {done}/{total}")
            time.sleep(THROTTLE_SEC)

        print(f"[{code}] Complete: {len(translated)}/{total} keys.")

if __name__ == "__main__":
    main()
