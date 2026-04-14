# KhataPro

A Flutter app for small business bookkeeping (khata = ledger in Hindi/Urdu).

## Design Reference

UI designs are in Google Stitch: https://stitch.withgoogle.com/project/3823020204310937544

Always refer to this project when implementing or reviewing UI screens.

## Tech Stack

- Flutter / Dart (SDK ^3.11.1)
- State management: Riverpod (`flutter_riverpod`, `riverpod_annotation`)
- Navigation: `go_router`
- Fonts: `google_fonts`
- Design system: Material 3

## Project Structure

```
lib/
  core/
    constants/   # App-wide constants
    theme/       # Material 3 theme config
  features/
    onboarding/  # Shop setup & theme selection screens
  router/        # go_router configuration
  main.dart
```

## Development Notes

- Run with `flutter run`
- Analyze with `dart analyze`
- Test with `flutter test`
