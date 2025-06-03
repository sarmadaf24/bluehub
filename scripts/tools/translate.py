#!/usr/bin/env python3
import os
import json
import re
import asyncio
from pathlib import Path
from dotenv import load_dotenv
import openai
from openai.error import RateLimitError, APIError

# ─── CONFIG ────────────────────────────────────────────────────────────────────
load_dotenv()  # if you keep OPENAI_API_KEY / OPENAI_MODEL in .env
openai.api_key = os.getenv("OPENAI_API_KEY")
MODEL = os.getenv("OPENAI_MODEL", "gpt-3.5-turbo-16k")  # or "gpt-4" if available

INPUT_FILE   = Path("en.json")         # your source file (2116 keys)
OUTPUT_DIR   = Path("translations")    # where to write <lang>.json
OUTPUT_DIR.mkdir(exist_ok=True)

LANGUAGES = {
    "pt-BR":"Brazilian Portuguese","hi":"Hindi","zh":"Chinese","jp":"Japanese","it":"Italian",
    "ko":"Korean","pt":"European Portuguese","ku":"Kurdish","pl":"Polish","el":"Greek",
    "ar":"Arabic","de":"German","es":"Spanish","ur":"Urdu","ru":"Russian","fr":"French",
    "fa":"Persian","ckb":"Kurdish (Sorani)","uk":"Ukrainian","tl":"Tagalog",
    "vi":"Vietnamese","id":"Indonesian","ms":"Malay"
}

CHUNK_SIZE   = 500    # keys per request
CONCURRENCY  = 4      # parallel requests
MAX_TOKENS   = 8000
INITIAL_BACKOFF = 1   # seconds
# ────────────────────────────────────────────────────────────────────────────────

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
    for idx, p in enumerate(phs):
        tmp = tmp.replace(p, f"__PH{idx}__")
    return tmp, phs

def restore_placeholders(text, phs):
    out = text
    for idx, p in enumerate(phs):
        out = out.replace(f"__PH{idx}__", p)
    return out

async def translate_patch(patch: dict, lang_name: str):
    prompt = (
        f"Translate this JSON dictionary into {lang_name}. "
        "Keep keys unchanged, preserve placeholders __PH0__, __PH1__, etc., "
        "and return only a valid JSON mapping of values.\n\n"
        + json.dumps(patch, ensure_ascii=False)
    )
    backoff = INITIAL_BACKOFF
    while True:
        try:
            resp = await openai.ChatCompletion.acreate(
                model=MODEL,
                messages=[
                    {"role":"system","content":"You are a professional translator. Output valid JSON."},
                    {"role":"user","content": prompt}
                ],
                temperature=0.0,
                max_tokens=MAX_TOKENS
            )
            return json.loads(resp.choices[0].message.content.strip())
        except (RateLimitError, APIError) as e:
            # on rate limit or transient API error, wait and retry
            await asyncio.sleep(backoff)
            backoff = min(backoff * 2, 300)

async def translate_language(code: str, lang_name: str, en_dict: dict, sem: asyncio.Semaphore):
    out_path = OUTPUT_DIR / f"{code}.json"
    if out_path.exists():
        translated_all = json.loads(out_path.read_text(encoding="utf-8"))
    else:
        translated_all = {}

    async with sem:
        for patch in chunk_dict(en_dict, CHUNK_SIZE):
            pending = {k:v for k,v in patch.items() if k not in translated_all}
            if not pending:
                continue

            tmp_patch, placeholders = {}, {}
            for k, v in pending.items():
                prot, phs = protect_placeholders(v)
                tmp_patch[k], placeholders[k] = prot, phs

            translated_chunk = await translate_patch(tmp_patch, lang_name)
            for k, tr in translated_chunk.items():
                translated_all[k] = restore_placeholders(tr, placeholders[k])

            # write incremental cache
            out_path.write_text(json.dumps(translated_all, ensure_ascii=False, indent=2), encoding="utf-8")
            print(f"[{code}] +{len(pending)} keys")

    print(f"[{code}] done ({len(translated_all)}/{len(en_dict)} keys)")

async def main():
    en_dict = json.loads(INPUT_FILE.read_text(encoding="utf-8"))
    sem = asyncio.Semaphore(CONCURRENCY)
    tasks = [
        translate_language(code, name, en_dict, sem)
        for code, name in LANGUAGES.items()
    ]
    await asyncio.gather(*tasks)

if __name__ == "__main__":
    asyncio.run(main())
