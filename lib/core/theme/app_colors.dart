import 'package:flutter/material.dart';

/// AppColors defines the color palette for the KhataMitra application,
/// meticulously mapped from the Stitch design system.
///
/// Ref: Digital Bahi Khata Design System
abstract class AppColors {
  // Light Mode - Core Palette
  static const Color primary = Color(0xFF004D99);
  static const Color primaryContainer = Color(0xFF1565C0);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryContainer = Color(0xFFDAE5FF);

  static const Color secondary = Color(0xFF1B6D24);
  static const Color secondaryContainer = Color(0xFFA0F399);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onSecondaryContainer = Color(0xFF217128);

  static const Color tertiary = Color(0xFFA00312);
  static const Color tertiaryContainer = Color(0xFFC42627);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color onTertiaryContainer = Color(0xFFFFDDD9);

  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);

  static const Color background = Color(0xFFF9F9F9);
  static const Color onBackground = Color(0xFF1A1C1C);

  static const Color surface = Color(0xFFF9F9F9);
  static const Color onSurface = Color(0xFF1A1C1C);
  static const Color surfaceVariant = Color(0xFFE2E2E2);
  static const Color onSurfaceVariant = Color(0xFF424752);

  static const Color outline = Color(0xFF727783);
  static const Color outlineVariant = Color(0xFFC2C6D4);

  // Surface Hierarchy (Tonal Layering)
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF3F3F3);
  static const Color surfaceContainer = Color(0xFFEEEEEE);
  static const Color surfaceContainerHigh = Color(0xFFE8E8E8);
  static const Color surfaceContainerHighest = Color(0xFFE2E2E2);

  // Dark Mode - Derived/Specific (Stitch provided some, others can be derived for M3)
  // For the purpose of initial implementation, we focus on the provided 'LIGHT' theme.
  // Dark mode can be further refined as per M3 standards.
  static const Color darkPrimary = Color(0xFFA9C7FF);
  static const Color darkOnPrimary = Color(0xFF002204);
  static const Color darkPrimaryContainer = Color(0xFF00468C);
  
  // Custom fixed colors from design system
  static const Color primaryFixed = Color(0xFFD6E3FF);
  static const Color primaryFixedDim = Color(0xFFA9C7FF);
  static const Color onPrimaryFixed = Color(0xFF001B3D);
  static const Color onPrimaryFixedVariant = Color(0xFF00468C);

  static const Color secondaryFixed = Color(0xFFA3F69C);
  static const Color secondaryFixedDim = Color(0xFF88D982);
  static const Color onSecondaryFixed = Color(0xFF002204);
  static const Color onSecondaryFixedVariant = Color(0xFF005312);

  static const Color tertiaryFixed = Color(0xFFFFDAD6);
  static const Color tertiaryFixedDim = Color(0xFFFFB4AC);
  static const Color onTertiaryFixed = Color(0xFF410003);
  static const Color onTertiaryFixedVariant = Color(0xFF93000E);

  // Missing M3 colors
  static const Color inverseSurface = Color(0xFF2F3131);
  static const Color inverseOnSurface = Color(0xFFF1F1F1);
  static const Color inversePrimary = Color(0xFFA9C7FF);

  static const Color darkSecondary = Color(0xFF88D982);
  static const Color darkTertiary = Color(0xFFFFB4AC);
  static const Color darkInversePrimary = Color(0xFF005DB7);

  // Dark Mode - Tonal Surfaces
  static const Color darkSurface = Color(0xFF111414);
  static const Color darkOnSurface = Color(0xFFE2E2E2);
  static const Color darkSurfaceContainerLowest = Color(0xFF0C0F0F);
  static const Color darkSurfaceContainerLow = Color(0xFF191C1C);
  static const Color darkSurfaceContainer = Color(0xFF1D2020);
  static const Color darkSurfaceContainerHigh = Color(0xFF282B2B);
  static const Color darkSurfaceContainerHighest = Color(0xFF333535);
}
