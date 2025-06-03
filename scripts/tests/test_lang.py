# 📁 tests/test_lang.py

import pytest
from utils.translate import t

# لیست زبان‌های ساپورت‌شده
SUPPORTED_LANGS = ["en", "fa", "ar", "tr", "ru", "fr", "de", "es", "ur"]

# یک کلید که باید تو همه زبان‌ها باشه
CRITICAL_KEYS = [
    "buy_config", "choose_protocol", "my_configs",
    "trial", "wallet", "referral", "support"
]

@pytest.mark.parametrize("key", CRITICAL_KEYS)
@pytest.mark.parametrize("lang", SUPPORTED_LANGS)
def test_key_exists_in_all_languages(key, lang):
    value = t(key, lang)
    assert value != key, f"❌ key '{key}' missing in lang '{lang}'"

def test_translation_fallback():
    # زبان ناشناخته باید بیفته روی en
    assert t("buy_config", "xx") == t("buy_config", "en")

def test_unknown_key_returns_key():
    assert t("non_existing_key", "fa") == "non_existing_key"
