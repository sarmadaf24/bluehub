# inspect_tables.py
import os, sys
from sqlalchemy import create_engine, inspect
from sqlalchemy.engine.url import make_url

# مسیر ریشه
ROOT = os.path.abspath(os.path.dirname(__file__))
sys.path.insert(0, ROOT)

# بارگذاری config
from config import DATABASE_URL

# تبدیل URL asyncpg به psycopg2
url = make_url(DATABASE_URL)
if url.drivername.endswith('+asyncpg'):
    url = url.set(drivername='postgresql+psycopg2')

engine = create_engine(url)
insp = inspect(engine)

for table_name in insp.get_table_names():
    print(f"\nTable: {table_name}")
    cols = insp.get_columns(table_name)
    for c in cols:
        default = c['default'] or ''
        print(f"  - {c['name']:20} | {c['type']!s:15} | nullable={c['nullable']:5} | default={default}")
    for fk in insp.get_foreign_keys(table_name):
        print(f"    FK: {fk['constrained_columns']} → {fk['referred_table']}({fk['referred_columns']})")
    for ix in insp.get_indexes(table_name):
        print(f"    Index: {ix['name']} columns={ix['column_names']} unique={ix['unique']}")
