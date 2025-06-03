import os, sys
from sqlalchemy import create_engine, text
# اضافه کردن مسیر اصلی پروژه
sys.path.insert(0, os.getcwd())
from config import DATABASE_URL

# Sync driver
from sqlalchemy.engine.url import make_url
url = make_url(DATABASE_URL)
if url.drivername.endswith('+asyncpg'):
    url = url.set(drivername='postgresql+psycopg2')

engine = create_engine(url)

user_id = 2005217637
with engine.connect() as conn:
    result = conn.execute(text("""
        SELECT token
        FROM email_tokens
        WHERE user_id = :uid
          AND used = false
        ORDER BY created_at DESC
        LIMIT 1
    """), {"uid": user_id})
    row = result.fetchone()
    if row:
        print("Current valid token:", row[0])
    else:
        print("No unused token found. Generate a new one via /test in Telegram.")
