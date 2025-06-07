import json
from pathlib import Path

DATA_FILE = Path(__file__).with_name("support_data.json")

try:
    data = json.loads(DATA_FILE.read_text())
except Exception:
    data = {"operator_index": 0, "operators": []}

OPERATORS = data.get("operators", [])
operator_index = data.get("operator_index", 0)

def _save():
    DATA_FILE.write_text(json.dumps({
        "operator_index": operator_index,
        "operators": OPERATORS
    }))

def get_next_operator() -> int | None:
    global operator_index
    if not OPERATORS:
        return None
    op = OPERATORS[operator_index % len(OPERATORS)]
    operator_index = (operator_index + 1) % len(OPERATORS)
    _save()
    return op
