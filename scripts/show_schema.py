import os
from dotenv import load_dotenv
from sqlalchemy import create_engine, inspect

# بارگذاری متغیرهای محیطی از .env
load_dotenv(dotenv_path="/root/bluehub/.env")
DATABASE_URL = os.getenv("DATABASE_URL")
if not DATABASE_URL:
    raise RuntimeError("DATABASE_URL not found in .env")

def main():
    # ساخت Engine همگام با psycopg2
    engine = create_engine(DATABASE_URL.replace("asyncpg", "psycopg2"))
    inspector = inspect(engine)

    # جمع‌آوری اطلاعات اسکیم‌ها و جداول
    for schema in inspector.get_schema_names():
        tables = inspector.get_table_names(schema=schema)
        for table in tables:
            columns = inspector.get_columns(table, schema=schema)
            pks = inspector.get_pk_constraint(table, schema=schema)
            fks = inspector.get_foreign_keys(table, schema=schema)
            indexes = inspector.get_indexes(table, schema=schema)

            print(f"\nSchema: {schema} | Table: {table}")
            print(" Columns:")
            for col in columns:
                print(f"  - {col['name']} ({col['type']}) | Nullable={col['nullable']} | Default={col.get('default')}")
            print(" Primary Key:", pks.get("constrained_columns"))
            if fks:
                print(" Foreign Keys:")
                for fk in fks:
                    print(f"  - {fk['constrained_columns']} -> {fk['referred_schema']}.{fk['referred_table']}({fk['referred_columns']})")
            if indexes:
                print(" Indexes:")
                for idx in indexes:
                    print(f"  - {idx['name']}: columns={idx['column_names']} | unique={idx['unique']}")
            print("-" * 80)

if __name__ == "__main__":
    main()
