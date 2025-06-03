#!/usr/bin/env python3
import os
import sys
import psycopg2
from urllib.parse import urlparse

def main():
    url = os.getenv("DATABASE_URL")
    if not url:
        print("❌ لطفا اول متغیر محیطی DATABASE_URL رو ست کنید:")
        print("   export DATABASE_URL=\"postgresql://user:pass@host:port/dbname\"")
        sys.exit(1)

    # پِیرس کردن URL
    parsed = urlparse(url)
    dbname = parsed.path.lstrip("/")
    user = parsed.username
    password = parsed.password
    host = parsed.hostname
    port = parsed.port or 5432

    try:
        conn = psycopg2.connect(
            dbname=dbname, user=user,
            password=password, host=host, port=port
        )
    except Exception as e:
        print(f"❌ خطا در اتصال به دیتابیس: {e}")
        sys.exit(1)

    cur = conn.cursor()

    # ۱) لیست اسکیمَ‌ها و جداول
    cur.execute("""
        SELECT table_schema, table_name
        FROM information_schema.tables
        WHERE table_type='BASE TABLE'
          AND table_schema NOT IN ('pg_catalog','information_schema')
        ORDER BY table_schema, table_name
    """)
    tables = cur.fetchall()
    if not tables:
        print("❌ هیچ جدولی یافت نشد.")
        conn.close()
        return

    for schema, table in tables:
        print(f"\n=== Schema: {schema} | Table: {table} ===")

        # ۲) ستون‌ها
        cur.execute("""
            SELECT column_name, data_type, is_nullable, column_default
            FROM information_schema.columns
            WHERE table_schema=%s AND table_name=%s
            ORDER BY ordinal_position
        """, (schema, table))
        cols = cur.fetchall()
        print("ستون‌ها:")
        for col_name, data_type, is_nullable, col_def in cols:
            default = col_def or ""
            print(f"  - {col_name} :: {data_type} "
                  f"(nullable={is_nullable}) default={default}")

        # ۳) همه ردیف‌ها
        print("\nداده‌ها:")
        try:
            cur.execute(f'SELECT * FROM "{schema}"."{table}"')
            rows = cur.fetchall()
            if rows:
                # چاپ اولین  در header نام ستون‌ها
                headers = [c[0] for c in cur.description]
                print(" | ".join(headers))
                for row in rows:
                    print(" | ".join(str(item) for item in row))
            else:
                print("  (بدون داده)")
        except Exception as e:
            print(f"  ❌ خطا در SELECT * : {e}")

    conn.close()

if __name__ == "__main__":
    main()
