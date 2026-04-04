# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Non-Negotiable Engineering Standards

These rules apply to **every line of code written in this project**, without exception.

### Effective Dart — https://dart.dev/effective-dart
Follow all four pillars:
- **Style**: `lowerCamelCase` for members/vars, `UpperCamelCase` for types/enums, `snake_case` for files/dirs/packages. Prefix private with `_`. Annotate overrides with `@override`.
- **Documentation**: Public API members get `///` doc comments. Explain *why*, not just what.
- **Usage**: Prefer `final` and `const` everywhere possible. Use collection literals over constructors. Avoid `dynamic`; use generics or sealed types. Use `?.` / `??` / `!` only where semantically clear.
- **Design**: Small, focused classes and functions. Prefer named parameters for 2+ args. Return `Future<void>` not `Future<Null>`. Avoid positional booleans; use enums or named params instead.

### No Magic Constants
- Every literal number, string key, or asset path that is used more than once **must** be a named constant.
- Dimension tokens → `AppDimensions` (`lib/core/constants/app_dimensions.dart`)
- Colors → `ColorScheme` tokens via `Theme.of(context).colorScheme`
- Text styles → `TextTheme` roles via `Theme.of(context).textTheme`
- Route paths → `AppRoutes` constants (`lib/core/routes/`)
- Asset paths → `AppAssets` constants (`lib/core/constants/app_assets.dart`) — create if needed
- String keys (prefs, analytics) → dedicated constants files per feature

### Cross-Platform (Android + iOS)
- Never use platform-specific APIs directly. Abstract behind an interface if platform behavior differs.
- Use Flutter's built-in adaptive widgets (`Switch.adaptive`, `AlertDialog.adaptive`, etc.) where appropriate.
- Test on both platforms before marking a feature done. No Android-only or iOS-only code paths unless explicitly behind a platform check with a comment explaining why.
- Respect safe area insets (`SafeArea`, `MediaQuery.of(context).padding`).
- Use `flutter_localizations` for all user-visible strings — never hardcode text.

### Modularity & Extensibility
- **Feature modules are self-contained**: `lib/features/<feature>/` owns its own `application/` (providers/logic) and `presentation/` (screens/widgets). Features may not import from sibling features directly — route via Go Router.
- **Core is infrastructure only**: `lib/core/` contains only primitives (widgets, theme, routing, constants) that have zero business logic.
- **Barrel exports**: Each `lib/core/<subdir>/` exposes a single `<subdir>.dart` barrel. Import the barrel, not individual files.
- **One responsibility per class**: Riverpod notifiers own state transitions; widgets own rendering; repository classes own I/O. No mixing.
- **Dependency injection via Riverpod**: Never instantiate services manually in widget trees. Pass via `ref.watch` / `ref.read`.

### Readability
- Keep functions ≤ 30 lines and files ≤ 300 lines. Split if larger.
- Descriptive names: `fetchUserProfile()` not `getData()`. Avoid abbreviations except universally accepted ones (`ctx`, `ref`, `idx`).
- Prefer early returns over deeply nested `if` blocks.
- Each widget's `build` method should be scannable — extract sub-widgets into private methods or classes when `build` exceeds ~25 lines.

### Code Review Checklist (before every commit)
Before writing any code, ask: does this change satisfy all of the above? Specifically:
- [ ] No hardcoded literals (colors, sizes, strings, asset paths)
- [ ] No platform-specific code without an abstraction layer
- [ ] Effective Dart naming and doc conventions followed
- [ ] Feature doesn't reach into another feature's internals
- [ ] `flutter analyze` passes with zero warnings
- [ ] New public API has `///` doc comments

## Commands

```bash
# Development
flutter pub get                          # Install dependencies + auto-generates l10n
flutter run                              # Run app

# Code generation (required after modifying @riverpod annotated files or routes)
flutter pub run build_runner build       # Generate .g.dart files (Riverpod providers, go_router)
flutter pub run build_runner watch       # Watch mode for code gen during development

# Localization (required after modifying .arb files)
flutter gen-l10n                         # Generate AppLocalizations from lib/l10n/*.arb

# Quality
flutter analyze                          # Static analysis (must pass before commit)
flutter test                             # All tests (must pass before commit)
flutter test test/path/to/test.dart      # Run a single test file
flutter test --update-goldens            # Regenerate golden test baselines
flutter test --coverage                  # Generate coverage metrics
```

## Code Review Workflow

A pre-commit hook at `scripts/pre-commit` enforces quality gates on **every commit**:
1. ✅ `flutter analyze` — All lints must pass (Effective Dart + flutter_lints)
2. ✅ `flutter test` — All tests must pass
3. 📊 `flutter test --coverage` — Coverage metrics collected → `coverage/lcov.info`

**For detailed Senior SDE reviews** (85%+ coverage validation, architecture review, Riverpod patterns):
- In VS Code Chat: **Agent Picker** (Cmd+I) → **"Flutter SDE Reviewer"**
- Prompt: `"Review lib/features/<feature> for coverage and SDE standards"`
- Output: Structured report with severity levels, uncovered lines, and actionable fixes

The agent validates coverage compliance, enforces Effective Dart patterns, and ensures production-quality code before merge.

## Architecture

KhataMitra is a bookkeeping/accounting Flutter app (v0.1.0) targeting small shop owners in India, currently in early development (theme + language selection implemented; auth, onboarding, ledger are placeholders).

### Structure

```
lib/
├── core/           # Shared infrastructure: theme, routing, widgets, constants
│   ├── constants/  # Dimension tokens (app_dimensions.dart)
│   ├── routes/     # Go Router config (app_router.dart + generated .g.dart)
│   ├── theme/      # Color tokens, typography scale, ThemeData builders
│   └── widgets/    # Reusable primitives: AppButton, AppCard, AppTextField
├── features/       # Domain feature modules (each has application/ + presentation/)
│   ├── theme/      # Theme mode selection + persistence
│   ├── language/   # Language/locale selection + persistence
│   ├── auth/       # Placeholder (OTP-based login)
│   ├── onboarding/ # Placeholder (shop details)
│   ├── dashboard/  # Placeholder
│   └── ledger/     # Placeholder
└── l10n/           # ARB source files (app_en.arb, app_hi.arb, app_te.arb) + generated classes
```

### State Management — Riverpod

All state uses `flutter_riverpod` with code generation:
- Providers are annotated with `@riverpod` (or `@Riverpod(keepAlive: true)`) on top-level class definitions
- Running `build_runner build` generates the corresponding `.g.dart` file
- **Never edit `.g.dart` files manually** — they are fully generated
- User preferences (theme mode, locale) are persisted via `shared_preferences` inside Riverpod notifiers

### Routing — Go Router

`lib/core/routes/app_router.dart` defines the route table as a Riverpod provider. Current flow: `/theme` → `/language` → `/login` → `/shop-details` → `/dashboard`. Use `context.go()` for navigation (not `context.push()`).

### Design System

**⚠️ CRITICAL**: Read [`.stitch/DESIGN.md`](.stitch/DESIGN.md) before implementing any screens. It defines:
- Visual atmosphere (density, variance, motion)
- Complete color palette (light & dark themes)
- Typography hierarchy and rules
- Component specifications (buttons, cards, inputs, lists, badges, modals)
- Layout & spacing principles
- Motion & interaction patterns
- Dark mode guidelines
- Banned styles & anti-patterns

**Colors** (`lib/core/theme/app_colors.dart`): Material Design 3 color scheme. Brand primary is `#004D99` (navy blue); secondary is `#1B6D24` (green for credits); tertiary is `#A00312` (red for debits). Dark theme equivalents use lighter tints. Always use `Theme.of(context).colorScheme` tokens — never hardcode colors.

**Typography** (`lib/core/theme/app_text_styles.dart`): Plus Jakarta Sans for headlines/display, Inter for body/labels. Always use `Theme.of(context).textTheme` roles — never hardcode font families or sizes.

**Dimensions** (`lib/core/constants/app_dimensions.dart`): Border radii (12px / 16px), button heights (56px), input padding (20px v / 16px h), spacing scale (4px–48px). Use these constants for layout consistency — never inline magic numbers.

**Core Widgets** (`lib/core/widgets/`):
- `AppButton` — Primary, secondary, ghost, success, danger variants
- `AppCard` — Standard, instruction, success, warning variants
- `AppTextField` — Text, phone, rupee, search, email, textarea types
- `AppBadge` — Status badges and chips (pill-shaped)
- `AppListTile` — Transaction rows with avatar, amount (semantic color), date

**Import convention**: `import 'package:khata_mitra/core/widgets.dart';` (barrel export)

### Localization

Supported: English (`en`), Hindi (`hi`), Telugu (`te`). Add new strings to all three `.arb` files, then run `flutter gen-l10n`. Access strings via `AppLocalizations.of(context)!`.

### Testing

- **Unit/widget tests**: `test/core/` and `test/features/`
- **Golden tests**: Use the `alchemist` package. Run `flutter test --update-goldens` to regenerate baselines after intentional visual changes. Golden tests for screens with `google_fonts` network calls are currently skipped (annotated with `skip: true`) due to font loading instability in test environments.
- Mock `SharedPreferences` in tests with `SharedPreferences.setMockInitialValues({})` before calling providers.

## Plan
- [x] **Phase 1: Foundation Setup**
  - [x] Add latest `flutter_riverpod`, `riverpod_annotation`, `riverpod_generator`, `build_runner`, `go_router`, and `alchemist` (for golden testing) to pubspec.yaml.
  - [x] Configure `.agents/code_reviewer.md` and `.agents/ui_tester.md`.
  - [x] Define global design tokens (`lib/core/theme`) extending from Stitch screens.
  - [x] Implement atomic UI components (`AppCard`, `AppButton`, `AppTextField`, etc.).
  - [x] Configure `go_router` base setup in `lib/core/routes`.
  - [x] Verify everything through the Code Reviewer agent checks.
- [x] **Phase 2: Theme Screen Sequence**
  - [x] Create ThemeProvider with persistent state in `lib/features/theme/application/theme_provider.dart`
  - [x] Implement `ThemeSelectionScreen` at `lib/features/theme/presentation/theme_selection_screen.dart` using design from `9_Theme_Selection.html`
  - [x] Implement local agents for tests on commit
  - [x] Code Reviewer analysis and UI Tester boundary checks
- [x] **Phase 3: Language Screen Sequence**
  - [x] Establish `LanguageProvider` with flutter_localizations
  - [x] Implement `LanguageSelectionScreen` mimicking `stitch_screens/11_Language_Selection.html`
  - [x] Register new screen in `go_router`
- [ ] **Phase 4: Login OTP Verification Sequence**
  - [ ] Implement Login UI with interactive elements.
  - [ ] Code Reviewer analysis.
  - [ ] UI Tester agent execution.
  - [ ] Reversible Git Commit.
- [ ] **Phase 5: Shop Details Onboarding Sequence**
  - [ ] Implement Shop Details Input Screen UI.
  - [ ] Hook up state and save to local storage (simulating progression to dashboard).
  - [ ] Code Reviewer analysis.
  - [ ] UI Tester agent execution.
  - [ ] Reversible Git Commit.
- [ ] **Phase 6: Main Dashboard & Ledgers Sequence**
  - [ ] Implement Main Dashboard UI.
  - [ ] Implement Customer Ledger & Transaction Sheets.
  - [ ] Run comprehensive Code Review & UI checks for all sub-components.
  - [ ] Final integrations & Walkthrough artifact generation.
