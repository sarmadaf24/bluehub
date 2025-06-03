import os
import json
import argparse

def validate_json_file(path: str) -> tuple[bool, str]:
    try:
        with open(path, 'r', encoding='utf-8') as f:
            json.load(f)
        return True, ''
    except json.JSONDecodeError as e:
        return False, f'JSONDecodeError: {e.msg} (at line {e.lineno} column {e.colno})'
    except Exception as e:
        return False, str(e)

def validate_directory(directory: str) -> dict[str, tuple[bool, str]]:
    results = {}
    for root, _, files in os.walk(directory):
        for fname in files:
            if fname.lower().endswith('.json'):
                fullpath = os.path.join(root, fname)
                ok, err = validate_json_file(fullpath)
                results[fullpath] = (ok, err)
    return results

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Validate all JSON files in a directory')
    parser.add_argument('directory', help='Path to directory containing JSON files')
    args = parser.parse_args()

    results = validate_directory(args.directory)
    has_error = False
    for path, (ok, err) in results.items():
        if ok:
            print(f'✅  {path}')
        else:
            has_error = True
            print(f'❌  {path}\n    Error: {err}')
    if not has_error:
        print('\nAll JSON files are valid!')
    else:
        print('\nSome files have errors. Please fix and re-run.')
