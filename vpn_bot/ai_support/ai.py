"""GPT-4 Turbo client and response helper.

If the optional ``openai`` dependency is missing, all completion calls will
gracefully return an empty string instead of raising errors.
"""

import logging
from functools import lru_cache

logger = logging.getLogger("ai-support")

try:  # pragma: no cover - optional dependency
    import openai  # type: ignore
except ImportError:  # pragma: no cover - openai not installed
    logger.warning("OpenAI package not available; AI features disabled.")
    openai = None  # type: ignore

FA_TEMPLATE = "کاربر پرسید: {question}\nپاسخ کوتاه:"  # فارسی
EN_TEMPLATE = "User asked: {question}\nShort answer:"

THRESHOLD = 0.7

@lru_cache(maxsize=128)
def _cached_completion(prompt: str) -> str:
    """Return a cached completion or an empty string if OpenAI is unavailable."""
    if openai is None:  # library missing
        logger.warning("OpenAI module not installed; returning empty completion.")
        return ""

    try:
        resp = openai.ChatCompletion.create(
            model="gpt-4-turbo", messages=[{"role": "user", "content": prompt}]
        )
        return resp.choices[0].message.content
    except Exception as e:  # pragma: no cover - network failures
        logger.exception("OpenAI request failed: %s", e)
        return ""

def get_ai_reply(text: str, lang: str = "fa") -> dict:
    template = FA_TEMPLATE if lang.startswith("fa") else EN_TEMPLATE
    answer = _cached_completion(template.format(question=text))
    confidence = 0.8 if answer else 0.0
    return {"answer": answer, "confidence": confidence}
