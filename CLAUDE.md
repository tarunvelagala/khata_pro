# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

KhataPro — a cross-platform (iOS + Android) Flutter app for small business bookkeeping. "Khata" means ledger in Hindi/Urdu. Target users are small business owners across South Asia, many transitioning from paper ledgers.

## Commands

```bash
flutter run                              # Run the app
dart analyze                             # Lint (must pass clean)
flutter test                             # Run all tests
flutter test test/core/theme/theme_test.dart  # Run a single test file
flutter gen-l10n                         # Regenerate localization files after editing .arb
flutter build apk --debug               # Verify Android builds
flutter build ios --no-codesign         # Verify iOS builds
dart format .                            # Format all code
dart fix --apply                         # Auto-fix common issues
```

## Repository Structure

```
lib/
  core/
    constants/   # AppDimensions — shared spacing/radius tokens
    theme/       # AppColors, AppTextStyles, AppTheme
    widgets/     # Design-system-level widgets (AppButton, AppCard, EmptyStateView…)
  features/<name>/
    data/        # Repositories, data sources
    domain/      # Models, enums
    presentation/
      providers/ # Riverpod notifiers (_provider.dart)
      screens/   # Full-page widgets (_screen.dart)
      widgets/   # Sub-widgets shared within this feature
  l10n/          # ARB files + generated localizations
  router/        # app_router.dart (go_router)
  main.dart
```

## How to Work in This Repo

### Architecture first

Plan the full slice before writing code: domain models → repository interface → Riverpod provider → screen → tests. Get alignment on the approach, then implement end-to-end.

### Production patterns first

Before implementing any new screen, component, or UX flow, invoke `/research <topic>` to check how production apps (PhonePe, OkCredit, Khatabook, Google Pay, Duolingo) have solved the same problem. This prevents reinventing the wheel and grounds decisions in proven patterns.

Examples:
- `/research empty state for customer list`
- `/research PIN entry screen`
- `/research bottom sheet vs full screen for add entry`

### Design system — DESIGN.md is the single source of truth

**`DESIGN.md`** contains the complete design system (YAML tokens + prose rationale) and all engineering standards. When Dart code conflicts with DESIGN.md, DESIGN.md wins.

**Screen implementation workflow:**
1. Check DESIGN.md § Screens — every screen is registered there with its route, Stitch frame link, and feature-specific UI rules. If the screen isn't listed, add it to the table before writing any code.
2. Open the Stitch frame or the local `.stitch/designs/` folder for layout intent. See `.stitch/README.md` for the asset index and token reconciliation notes.
3. Apply DESIGN.md tokens — colors, typography, spacing, radii. DESIGN.md overrides Stitch on any conflict.
4. Satisfy the Production Validation checklist in DESIGN.md § Engineering Standards before marking done.

**Non-negotiable rules (full detail in DESIGN.md):**
- **Semantic colors:** Secondary (green) = income/credit. Tertiary (red) = expense/debit. Primary (blue) = neutral. Never swap.
- **No magic numbers:** Named constants only. Shared → `AppDimensions`. Screen-specific → file-private `_Dims`.
- **Screen skeleton:** `Scaffold → SafeArea → Column[Expanded scroll area + sticky CTA bar]`. Shared widgets → `widgets/`, never copied between screens.
- **Effective Dart:** `dart format` before every commit, `dart analyze` must pass clean.
- **AsyncValue:** All three states (data / loading / error) handled explicitly on every async screen.
- **Riverpod only** — no `setState`, `ChangeNotifier`, `Bloc`, `GetX`.
- **go_router only** — no `Navigator.push/pop`.

### Automated guardrails

`.claude/hooks` runs automatically — no need to invoke manually:
- **Post-edit:** `dart analyze`
- **Pre-commit:** `dart analyze` → `flutter test` → Android build → iOS build → design token review

## Architecture Reference

### Theme

`lib/core/theme/` — three `abstract final` classes, never instantiated:
- `AppColors` — every M3 color token as `const Color`. Light + dark variants. Must match DESIGN.md YAML exactly.
- `AppTextStyles` — full M3 type scale. No colors on TextStyle — resolved from ThemeData at runtime.
- `AppTheme` — builds `ThemeData` light/dark via private helpers.

### State (Riverpod)

Root `ProviderScope` in `main.dart`. Screens extend `ConsumerWidget`. Pattern: `Notifier` + `NotifierProvider`. Immutable state uses `copyWith`. Widget tests wrap with `ProviderScope` + overrides.

### Routing

`go_router` in `lib/router/app_router.dart`. Initial route: `/home`. Use `context.go()`, `context.push()`, `context.pop()` — never imperative Navigator. Router redirect logic: on first launch (`tourSeen = false` in `SharedPreferences`), redirect to `/tour`; thereafter go to `/home`.

### Localization

8 languages: `en hi kn ta bn mr ml te`. ARB template: `lib/l10n/app_en.arb`. Run `flutter gen-l10n` after any ARB edit. Zero hard-coded user-visible strings — always use `AppLocalizations.of(context)!`.

**iOS** — `ios/Runner/Info.plist` must declare `CFBundleLocalizations` (explicit list of all 8 locale codes) and `CFBundleDevelopmentRegion: en`. Without this, iOS ignores the Flutter locale entirely.

**Android** — `android:label` in `AndroidManifest.xml` must be `@string/app_name` (not hard-coded). Put the default in `res/values/strings.xml` and per-language overrides in `res/values-<code>/strings.xml`. For Android 13+, also wire `android:localeConfig="@xml/locales_config"` with a matching `res/xml/locales_config.xml`.

**`main.dart`** — all four delegates required: `AppLocalizations.delegate`, `GlobalMaterialLocalizations.delegate`, `GlobalCupertinoLocalizations.delegate`, `GlobalWidgetsLocalizations.delegate`. Use `AppLocalizations.supportedLocales` as the locale list — single source of truth.

**Date/number formatting** — always pass the active locale explicitly to `DateFormat` and `NumberFormat`; never rely on the system default (it differs between Android and iOS). Full rules and widget table: DESIGN.md § Internationalization.

### Testing

`ProviderContainer` for isolated provider tests. `makeContainer()` helper with `addTearDown(container.dispose)`. Do not test private methods, trivial getters, or generated code.

### Test coverage — non-negotiable

**Every change to `lib/features/` or `lib/core/widgets/` must ship with tests in the same commit.** No exceptions.

- New widget → widget test covering overflow on at least 360×640 and 390×844 viewports, all 8 locales where text is involved
- New provider/notifier → unit test via `ProviderContainer`
- Bug fix → regression test that would have caught the bug
- ARB change → run `flutter gen-l10n`, confirm `locale_render_test.dart` still passes

The pre-commit hook (`.claude/hooks/test-coverage.sh`) enforces this automatically and will block commits that touch `lib/features/` or `lib/core/widgets/` without a corresponding test file.

