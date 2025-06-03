#!/usr/bin/env python3
import os
from dotenv import load_dotenv
from sqlalchemy import create_engine, inspect

# 1. بارگذاری .env
load_dotenv("/root/bluehub/.env")  # مسیر دقیق فایل .env

# 2. خواندن DATABASE_URL
db_url = os.getenv("DATABASE_URL")
if not db_url:
    raise RuntimeError("❌ متغیر DATABASE_URL یافت نشد!")

# 3. ساخت engine و inspector
engine = create_engine(db_url)
insp = inspect(engine)

# 4. پیمایش اسکیمای public برای یافتن جداولی که کلید خارجی به users دارند
fks = insp.get_foreign_keys("email_tokens")  # مثال برای یک جدول
# یا می‌توانید تمام جداول را لیست کنید:
for table_name in insp.get_table_names(schema="public"):
    fkeys = insp.get_foreign_keys(table_name, schema="public")
    for fk in fkeys:
        if fk['referred_table'] == 'users' and fk['referred_columns'] == ['user_id']:
            print(f"Table `{table_name}` ➔ Column `{fk['constrained_columns'][0]}`")

# و اگر می‌خواهید جزئیات کامل همه جداول را ببینید:
for schema in insp.get_schema_names():
    for table in insp.get_table_names(schema=schema):
        print(f"\nSchema: {schema} | Table: {table}")
        cols = insp.get_columns(table, schema=schema)
        for col in cols:
            print(f"  - {col['name']} ({col['type']}) Nullable={col['nullable']}")
