#!/usr/bin/env bash
# Run tests with coverage, strip generated/l10n files, then enforce ≥80%.
set -euo pipefail

flutter test --coverage

python3 - <<'PY'
import re, sys

with open('coverage/lcov.info') as f:
    data = f.read()

# Patterns to exclude (generated code — no manual tests required)
EXCLUDE = [
    r'\.g\.dart$',
    r'/l10n/app_localizations',
    r'/core/database/tables/',   # Drift Table schema declarations; exercised via AppDatabase
]

def should_exclude(path):
    return any(re.search(p, path) for p in EXCLUDE)

# Parse blocks
total_lf = total_lh = 0
below = []

for block in data.split('end_of_record'):
    sf = re.search(r'SF:(.*)', block)
    if not sf:
        continue
    path = sf.group(1).strip()
    if should_exclude(path):
        continue
    lf_m = re.search(r'^LF:(\d+)', block, re.M)
    lh_m = re.search(r'^LH:(\d+)', block, re.M)
    if not lf_m or not lh_m:
        continue
    lf = int(lf_m.group(1))
    lh = int(lh_m.group(1))
    total_lf += lf
    total_lh += lh
    if lf > 0 and 100 * lh / lf < 80:
        below.append((path, 100 * lh / lf, lh, lf))

if total_lf == 0:
    print('No coverable lines found.')
    sys.exit(0)

pct = 100 * total_lh / total_lf
print(f'Coverage (excl. generated): {total_lh}/{total_lf} lines = {pct:.1f}%')

if below:
    print('\nFiles below 80%:')
    for path, p, h, total in sorted(below, key=lambda x: x[1]):
        print(f'  {p:.0f}%  {path}  ({h}/{total})')

if pct < 80:
    print(f'\nFAIL: coverage {pct:.1f}% is below the 80% threshold.')
    sys.exit(1)
else:
    print('\nPASS: coverage meets the 80% threshold.')
PY
