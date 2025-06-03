#!/usr/bin/env python3
import os
import json
import re
import asyncio
from pathlib import Path
from dotenv import load_dotenv
import openai
from openai.error import RateLimitError, OpenAIError

# ─── CONFIG ────────────────────────────────────────────────────────────────────
load_dotenv()
openai.api_key = os.getenv("OPENAI_API_KEY")
# Use "gpt-4" if you have access, otherwise fallback to 3.5
MODEL = os.getenv("OPENAI_MODEL", "gpt-3.5-turbo-16k")

INPUT_FILE   = Path("en.json")              # your source dictionary
OUTPUT_DIR   = Path("translations")         # where to write <lang>.json
OUTPUT_DIR.mkdir(exist_ok=True)

CHUNK_SIZE   = 1000   # keys per request => ~3 requests/lang for 2116 keys
CONCURRENCY  = 3      # parallel languages
INITIAL_BACKOFF = 1   # seconds
MAX_BACKOFF     = 300 # seconds
# ────────────────────────────────────────────────────────────────────────────────

# list of target languages
LANGUAGES = {
    "pt-BR": "Brazilian Portuguese", "hi": "Hindi",      "zh": "Chinese",
    "jp":    "Japanese",           "it": "Italian",    "ko": "Korean",
    "pt":    "European Portuguese","ku": "Kurdish",     "pl": "Polish",
    "el":    "Greek",              "ar": "Arabic",     "de": "German",
    "es":    "Spanish",            "ur": "Urdu",       "ru": "Russian",
    "fr":    "French",             "fa": "Persian",    "ckb": "Kurdish (Sorani)",
    "uk":    "Ukrainian",          "tl": "Tagalog",    "vi": "Vietnamese",
    "id":    "Indonesian",         "ms": "Malay"
}

def chunk_dict(d: dict, size: int):
    items = list(d.items())
    for i in range(0, len(items), size):
        yield dict(items[i:i+size])

def protect_placeholders(text):
    if isinstance(text, list):
        text = "\n".join(text)
    elif not isinstance(text, str):
        text = str(text)
    phs = re.findall(r"\{[^}]+\}", text)
    tmp = text
    for i,p in enumerate(phs):
        tmp = tmp.replace(p, f"__PH{i}__")
    return tmp, phs

def restore_placeholders(text, phs):
    out = text
    for i,p in enumerate(phs):
        out = out.replace(f"__PH{i}__", p)
    return out

async def translate_patch(patch: dict, lang_name: str):
    prompt = (
        f"Translate this JSON dictionary into {lang_name}. "
        "Keep keys unchanged, preserve placeholders __PH0__, __PH1__, etc., "
        "and return valid JSON object with translated values only:\n\n"
        + json.dumps(patch, ensure_ascii=False)
    )
    backoff = INITIAL_BACKOFF
    while True:
        try:
            resp = await openai.ChatCompletion.acreate(
                model=MODEL,
                messages=[
                    {"role":"system", "content":"You are a professional translator. Output valid JSON."},
                    {"role":"user",   "content":prompt}
                ],
                temperature=0.0,
                max_tokens=8000
            )
            return json.loads(resp.choices[0].message.content.strip())
        except RateLimitError:
            print(f"[!] Rate limit, retrying in {backoff}s…")
            await asyncio.sleep(backoff)
            backoff = min(backoff * 2, MAX_BACKOFF)
        except OpenAIError as e:
            print(f"[✘] OpenAI error: {e}")
            raise

async def translate_language(code: str, lang_name: str, en_dict: dict, sem: asyncio.Semaphore):
    out_path = OUTPUT_DIR / f"{code}.json"
    translated_all = {}
    # no cache: always fresh; remove next two lines to enable caching
    if out_path.exists():
        translated_all = json.loads(out_path.read_text(encoding="utf-8"))

    async with sem:
        for chunk in chunk_dict(en_dict, CHUNK_SIZE):
            # only translate keys not yet done
            pending = {k:v for k,v in chunk.items() if k not in translated_all}
            if not pending:
                continue
            tmp, placeholders = {}, {}
            for k,v in pending.items():
                p, phs = protect_placeholders(v)
                tmp[k], placeholders[k] = p, phs

            try:
                tr_patch = await translate_patch(tmp, lang_name)
            except Exception:
                print(f"[✘] {code}: failed patch, skipping.")
                continue

            for k,tr in tr_patch.items():
                translated_all[k] = restore_placeholders(tr, placeholders[k])

            # write incremental results
            out_path.write_text(json.dumps(translated_all, ensure_ascii=False, indent=2), encoding="utf-8")
            print(f"[✔] {code}: +{len(pending)} keys")

    print(f"[★] Done {code} ({len(translated_all)}/{len(en_dict)} keys)")

async def main():
    en_dict = json.loads(INPUT_FILE.read_text(encoding="utf-8"))
    sem = asyncio.Semaphore(CONCURRENCY)
    tasks = [ translate_language(c, n, en_dict, sem) for c,n in LANGUAGES.items() ]
    await asyncio.gather(*tasks)

if __name__=="__main__":
    asyncio.run(main())
