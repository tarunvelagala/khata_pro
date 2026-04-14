import 'package:flutter/material.dart';

/// All color tokens extracted from the KhataPro Stitch design system.
/// Based on Material Design 3 color roles.
abstract final class AppColors {
  // --- Primary ---
  static const primary = Color(0xFF004D99);
  static const onPrimary = Color(0xFFFFFFFF);
  static const primaryContainer = Color(0xFF1565C0);
  static const onPrimaryContainer = Color(0xFFDAE5FF);
  static const primaryFixed = Color(0xFFD6E3FF);
  static const primaryFixedDim = Color(0xFFA9C7FF);
  static const onPrimaryFixed = Color(0xFF001B3D);
  static const onPrimaryFixedVariant = Color(0xFF00468C);
  static const inversePrimary = Color(0xFFA9C7FF);
  static const surfaceTint = Color(0xFF005DB7);

  // --- Secondary (Green — credit/income) ---
  static const secondary = Color(0xFF1B6D24);
  static const onSecondary = Color(0xFFFFFFFF);
  static const secondaryContainer = Color(0xFFA0F399);
  static const onSecondaryContainer = Color(0xFF217128);
  static const secondaryFixed = Color(0xFFA3F69C);
  static const secondaryFixedDim = Color(0xFF88D982);
  static const onSecondaryFixed = Color(0xFF002204);
  static const onSecondaryFixedVariant = Color(0xFF005312);

  // --- Tertiary (Red — debit/expense) ---
  static const tertiary = Color(0xFFA00312);
  static const onTertiary = Color(0xFFFFFFFF);
  static const tertiaryContainer = Color(0xFFC42627);
  static const onTertiaryContainer = Color(0xFFFFDDD9);
  static const tertiaryFixed = Color(0xFFFFDAD6);
  static const tertiaryFixedDim = Color(0xFFFFB4AC);
  static const onTertiaryFixed = Color(0xFF410003);
  static const onTertiaryFixedVariant = Color(0xFF93000E);

  // --- Error ---
  static const error = Color(0xFFBA1A1A);
  static const onError = Color(0xFFFFFFFF);
  static const errorContainer = Color(0xFFFFDAD6);
  static const onErrorContainer = Color(0xFF93000A);

  // --- Surface & Background ---
  static const background = Color(0xFFF9F9F9);
  static const onBackground = Color(0xFF1A1C1C);
  static const surface = Color(0xFFF9F9F9);
  static const onSurface = Color(0xFF1A1C1C);
  static const surfaceDim = Color(0xFFDADADA);
  static const surfaceBright = Color(0xFFF9F9F9);
  static const surfaceContainerLowest = Color(0xFFFFFFFF);
  static const surfaceContainerLow = Color(0xFFF3F3F3);
  static const surfaceContainer = Color(0xFFEEEEEE);
  static const surfaceContainerHigh = Color(0xFFE8E8E8);
  static const surfaceContainerHighest = Color(0xFFE2E2E2);
  static const surfaceVariant = Color(0xFFE2E2E2);
  static const onSurfaceVariant = Color(0xFF424752);
  static const inverseSurface = Color(0xFF2F3131);
  static const inverseOnSurface = Color(0xFFF1F1F1);

  // --- Outline ---
  static const outline = Color(0xFF727783);
  static const outlineVariant = Color(0xFFC2C6D4);

  // ------------------------------------------------------------------ //
  // Dark theme tokens
  // Derived from the M3 dark tonal palette for this seed color scheme.
  // Surfaces use zinc-900/950 per the Stitch dark mode preview.
  // ------------------------------------------------------------------ //

  // --- Primary (dark) ---
  static const darkPrimary = Color(0xFFA9C7FF);
  static const darkOnPrimary = Color(0xFF001B3D);
  static const darkPrimaryContainer = Color(0xFF00468C);
  static const darkOnPrimaryContainer = Color(0xFFD6E3FF);

  // --- Secondary (dark — credit/income) ---
  static const darkSecondary = Color(0xFF88D982);
  static const darkOnSecondary = Color(0xFF002204);
  static const darkSecondaryContainer = Color(0xFF005312);
  static const darkOnSecondaryContainer = Color(0xFFA3F69C);

  // --- Tertiary (dark — debit/expense) ---
  static const darkTertiary = Color(0xFFFFB4AC);
  static const darkOnTertiary = Color(0xFF410003);
  static const darkTertiaryContainer = Color(0xFF93000E);
  static const darkOnTertiaryContainer = Color(0xFFFFDAD6);

  // --- Error (dark) ---
  static const darkError = Color(0xFFFFB4AB);
  static const darkOnError = Color(0xFF690005);
  static const darkErrorContainer = Color(0xFF93000A);
  static const darkOnErrorContainer = Color(0xFFFFDAD6);

  // --- Surface (dark) — zinc-950/900 per Stitch dark preview ---
  static const darkBackground = Color(0xFF0A0A0A);
  static const darkOnBackground = Color(0xFFE2E2E2);
  static const darkSurface = Color(0xFF111111);
  static const darkOnSurface = Color(0xFFE2E2E2);
  static const darkSurfaceDim = Color(0xFF0A0A0A);
  static const darkSurfaceBright = Color(0xFF2A2A2A);
  static const darkSurfaceContainerLowest = Color(0xFF090909);
  static const darkSurfaceContainerLow = Color(0xFF161616);
  static const darkSurfaceContainer = Color(0xFF1C1C1C);
  static const darkSurfaceContainerHigh = Color(0xFF242424);
  static const darkSurfaceContainerHighest = Color(0xFF2E2E2E);
  static const darkOnSurfaceVariant = Color(0xFFC2C6D4);
  static const darkInverseSurface = Color(0xFFE2E2E2);
  static const darkInverseOnSurface = Color(0xFF2F3131);
  static const darkInversePrimary = Color(0xFF004D99);

  // --- Outline (dark) ---
  static const darkOutline = Color(0xFF8C9099);
  static const darkOutlineVariant = Color(0xFF424752);
}
