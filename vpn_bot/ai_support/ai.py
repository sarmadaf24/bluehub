"""GPT-4 Turbo client and response helper."""

import logging
from functools import lru_cache

import openai

logger = logging.getLogger("ai-support")

FA_TEMPLATE = "کاربر پرسید: {question}\nپاسخ کوتاه:"  # فارسی
EN_TEMPLATE = "User asked: {question}\nShort answer:"

THRESHOLD = 0.7

@lru_cache(maxsize=128)
def _cached_completion(prompt: str) -> str:
    try:
        resp = openai.ChatCompletion.create(model="gpt-4-turbo", messages=[{"role": "user", "content": prompt}])
        return resp.choices[0].message.content
    except Exception as e:
        logger.exception("OpenAI request failed: %s", e)
        return ""

def get_ai_reply(text: str, lang: str = "fa") -> dict:
    template = FA_TEMPLATE if lang.startswith("fa") else EN_TEMPLATE
    answer = _cached_completion(template.format(question=text))
    confidence = 0.8 if answer else 0.0
    return {"answer": answer, "confidence": confidence}
