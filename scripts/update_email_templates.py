#!/usr/bin/env python3
import os
import json

# مقادیر ترجمه‌شده برای هر زبان
TRANSLATIONS = {
    "ar": {
        "email_subject": "تفعيل النسخة التجريبية المجانية",
        "email_body": "<p>مرحبًا!</p><p>لتفعيل النسخة التجريبية المجانية ذات الحجم المحدود والمدة المحددة، يرجى النقر على الرابط أدناه:</p><p><a href=\"{link}\">{link}</a></p><p>هذا الرابط صالح لمدة 24 ساعة.</p><p>شكرًا، فريق الدعم لدينا</p>"
    },
    "tr": {
        "email_subject": "Ücretsiz deneme etkinleştirme",
        "email_body": "<p>Merhaba!</p><p>Sınırlı hacimli ve belirli süreli ücretsiz denemeyi etkinleştirmek için lütfen aşağıdaki bağlantıya tıklayın:</p><p><a href=\"{link}\">{link}</a></p><p>Bu bağlantı 24 saat boyunca geçerlidir.</p><p>Teşekkürler, destek ekibimiz</p>"
    },
    "en": {
        "email_subject": "Free Trial Activation",
        "email_body": "<p>Hello!</p><p>To activate your free trial with limited volume and specified duration, please click the link below:</p><p><a href=\"{link}\">{link}</a></p><p>This link is valid for 24 hours.</p><p>Thank you, our support team</p>"
    },
    "es": {
        "email_subject": "Activación de prueba gratuita",
        "email_body": "<p>¡Hola!</p><p>Para activar tu prueba gratuita con volumen limitado y duración especificada, por favor haz clic en el siguiente enlace:</p><p><a href=\"{link}\">{link}</a></p><p>Este enlace es válido por 24 horas.</p><p>Gracias, nuestro equipo de soporte</p>"
    },
    "ur": {
        "email_subject": "مفت ٹرائل کی فعال‌سازی",
        "email_body": "<p>ہیلو!</p><p>محدود حجم اور مخصوص مدت کے ساتھ اپنا مفت ٹرائل فعال کرنے کے لیے براہ کرم نیچے دیے گئے لنک پر کلک کریں:</p><p><a href=\"{link}\">{link}</a></p><p>یہ لنک 24 گھنٹے تک مؤثر ہے۔</p><p>شکریہ، ہماری سپورٹ ٹیم</p>"
    },
    "ru": {
        "email_subject": "Активация бесплатного пробного периода",
        "email_body": "<p>Здравствуйте!</p><p>Чтобы активировать бесплатный пробный период с ограниченным объёмом и указанным сроком, пожалуйста, перейдите по ссылке ниже:</p><p><a href=\"{link}\">{link}</a></p><p>Эта ссылка действительна в течение 24 часов.</p><p>Спасибо, наша служба поддержки</p>"
    },
    "fr": {
        "email_subject": "Activation de l'essai gratuit",
        "email_body": "<p>Bonjour !</p><p>Pour activer votre essai gratuit avec un volume limité et une durée spécifiée, veuillez cliquer sur le lien ci-dessous :</p><p><a href=\"{link}\">{link}</a></p><p>Ce lien est valable 24 heures.</p><p>Merci, notre équipe de support</p>"
    },
    "de": {
        "email_subject": "Aktivierung der kostenlosen Testversion",
        "email_body": "<p>Hallo!</p><p>Um Ihre kostenlose Testversion mit begrenztem Volumen und festgelegter Laufzeit zu aktivieren, klicken Sie bitte auf den folgenden Link:</p><p><a href=\"{link}\">{link}</a></p><p>Dieser Link ist 24 Stunden gültig.</p><p>Vielen Dank, unser Support-Team</p>"
    }
}

LANG_DIR = os.path.join(os.path.dirname(__file__), os.pardir, "vpn_bot", "langs")

for fname in os.listdir(LANG_DIR):
    if not fname.endswith(".json"):
        continue
    lang = fname[:-5]  # "fa.json" → "fa"
    path = os.path.join(LANG_DIR, fname)
    with open(path, "r", encoding="utf-8") as f:
        data = json.load(f)
    # اضافه یا به‌روز کردن کلیدها
    if lang in TRANSLATIONS:
        data.update(TRANSLATIONS[lang])
    else:
        print(f"⚠️ عدم وجود ترجمه برای زبان `{lang}`؛ نادیده گرفته شد.")
        continue
    # بازنویسی فایل با فرمت استاندارد
    with open(path, "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
        f.write("\n")

print("✅ تمام فایل‌ها با موفقیت به‌روز شدند.")
