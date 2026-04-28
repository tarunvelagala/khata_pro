#!/bin/bash
# Brand guidelines enforcement — blocks commit on design system violations.
# Checks: magic numbers, semantic color misuse, hard-coded strings, AppBar/Navigator usage.

cd "$CLAUDE_PROJECT_DIR"

STAGED=$(git diff --cached --name-only --diff-filter=ACM 2>/dev/null | grep '\.dart$' || true)
[ -z "$STAGED" ] && exit 0

ERRORS=0

err() { echo "  ERROR: $1"; ERRORS=$((ERRORS + 1)); }

# Check staged additions in $1 for ERE pattern $2; report as $3 if found.
check_pattern() {
  local file="$1" pattern="$2" label="$3"
  local hits
  hits=$(git diff --cached -U0 -- "$file" 2>/dev/null \
    | grep '^+' | grep -v '^+++' \
    | grep -En "$pattern" || true)
  if [ -n "$hits" ]; then
    err "$file — $label"
    echo "$hits" | head -5 | sed 's/^/    /'
    local count
    count=$(echo "$hits" | wc -l | tr -d ' ')
    [ "$count" -gt 5 ] && echo "    ... ($count total)"
  fi
}

# Token source files are exempt (they define the raw values).
SKIP='app_colors\.dart|app_dimensions\.dart|app_text_styles\.dart|app_theme\.dart|\.g\.dart|\.freezed\.dart|generated/|l10n/'

for file in $STAGED; do
  [ ! -f "$file" ] && continue
  echo "$file" | grep -qE "$SKIP" && continue

  echo "Checking $file ..."

  # 1. Magic numbers — raw numeric literals in layout properties
  check_pattern "$file" \
    '(SizedBox|EdgeInsets[^(]*\(|BorderRadius\.circular|\.circular\(|width:\s*[0-9]|height:\s*[0-9]|size:\s*[0-9]|spacing:\s*[0-9]|top:\s*[0-9]|bottom:\s*[0-9]|left:\s*[0-9]|right:\s*[0-9]|gap:\s*[0-9])\s*[1-9]' \
    "magic number — use AppDimensions.* or file-private _Dims.*"

  # 2. Semantic color misuse
  check_pattern "$file" \
    '(debit|expense|loss|outgoing|paid).*cs\.secondary|cs\.secondary.*(debit|expense|loss|outgoing|paid)' \
    "semantic color misuse — cs.secondary (green) is income/credit only"

  check_pattern "$file" \
    '(credit|income|received|incoming).*cs\.tertiary|cs\.tertiary.*(credit|income|received|incoming)' \
    "semantic color misuse — cs.tertiary (red) is expense/debit only"

  # 3. Hard-coded user-visible strings in Text() or label:
  check_pattern "$file" \
    "Text\('[A-Z][a-zA-Z ]{3,}'\)|Text\(\"[A-Z][a-zA-Z ]{3,}\"\)|label:\s*'[A-Z][a-zA-Z ]{3,}'" \
    "hard-coded string — use AppLocalizations.of(context)!.*"

  # 4. AppBar widget
  check_pattern "$file" \
    '\bAppBar\s*\(' \
    "AppBar widget — use custom Row header per DESIGN.md screen skeleton"

  # 5. Imperative Navigator
  check_pattern "$file" \
    'Navigator\.(push|pop|pushNamed|pushReplacement)\s*\(' \
    "Navigator.push/pop — use context.go() / context.push() / context.pop() (go_router)"

done

echo ""
if [ "$ERRORS" -gt 0 ]; then
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "  Brand guidelines FAILED: $ERRORS error(s)"
  echo "  DESIGN.md is the source of truth."
  echo "  Fix the issues above before committing."
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  exit 2
fi

echo "Brand guidelines: passed"
exit 0
