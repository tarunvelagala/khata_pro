#!/bin/bash
# Test coverage enforcement — blocks commit when lib/ changes have no corresponding test changes.
# Rule: every staged lib/features/ or lib/core/widgets/ dart file must have at least one
# staged or existing test file that covers it.

cd "$CLAUDE_PROJECT_DIR"

STAGED_LIB=$(git diff --cached --name-only --diff-filter=ACM 2>/dev/null \
  | grep '\.dart$' \
  | grep -E '^lib/(features|core/widgets)/' || true)

[ -z "$STAGED_LIB" ] && exit 0

STAGED_TESTS=$(git diff --cached --name-only --diff-filter=ACM 2>/dev/null \
  | grep '\.dart$' \
  | grep '^test/' || true)

ERRORS=0
WARNINGS=0

err()  { echo "  ERROR: $1";   ERRORS=$((ERRORS + 1)); }
warn() { echo "  WARNING: $1"; WARNINGS=$((WARNINGS + 1)); }

echo "Checking test coverage for staged changes..."
echo ""

for file in $STAGED_LIB; do
  # Skip generated files, providers (pure wiring), and domain models (pure data).
  echo "$file" | grep -qE '\.g\.dart|\.freezed\.dart|generated/|l10n/' && continue

  # Derive the base name for test lookup (e.g. balance_card.dart → balance_card).
  base=$(basename "$file" .dart)
  feature_path=$(echo "$file" | sed 's|^lib/||' | sed 's|/[^/]*$||')

  # Check if any test file (staged or already committed) references this widget/class.
  existing_test=$(find test/ -name "*${base}*" -o -name "locale_render_test.dart" 2>/dev/null \
    | head -1 || true)
  staged_test=$(echo "$STAGED_TESTS" | grep -i "$base" || true)

  # Also accept if the locale_render_test covers the screen (it covers all screens/widgets).
  locale_coverage=""
  if echo "$file" | grep -qE '_screen\.dart|_shell\.dart|quick_actions|summary_pills|balance_card|transaction_list|dashboard_app_bar|home_empty'; then
    locale_coverage=$(find test/ -name "locale_render_test.dart" 2>/dev/null | head -1 || true)
  fi

  if [ -z "$existing_test" ] && [ -z "$staged_test" ] && [ -z "$locale_coverage" ]; then
    err "$file — no test file found. Add tests in test/ before committing."
  elif [ -n "$staged_test" ] || [ -n "$existing_test" ] || [ -n "$locale_coverage" ]; then
    echo "  ✓ $file"
  fi
done

echo ""
if [ "$ERRORS" -gt 0 ]; then
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "  Test coverage FAILED: $ERRORS file(s) with no tests"
  echo ""
  echo "  Every change to lib/features/ or lib/core/widgets/"
  echo "  must ship with a test in the same commit."
  echo ""
  echo "  Add widget tests in test/features/ or extend"
  echo "  test/features/locale_render_test.dart."
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  exit 2
fi

echo "Test coverage: passed"
exit 0
