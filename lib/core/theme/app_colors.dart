import 'package:flutter/material.dart';

/// All color tokens for KhataPro.
///
/// Semantic financial mapping (never swap):
///   secondary (green) = income / credit
///   tertiary  (red)   = expense / debit
///   error             = validation errors and destructive actions only
///
/// Shadow and overlay tokens are purposely separate from the M3 ColorScheme —
/// they cover use-cases M3 doesn't model (card lift, hero gradient, modal scrim).
abstract final class AppColors {
  // ── Primary ──────────────────────────────────────────────────────────────
  static const primary             = Color(0xFF1565C0);
  static const onPrimary           = Color(0xFFFFFFFF);
  static const primaryContainer    = Color(0xFFD6E3FF);
  static const onPrimaryContainer  = Color(0xFF001B3D);
  static const primaryFixed        = Color(0xFFD6E3FF);
  static const primaryFixedDim     = Color(0xFFA9C7FF);
  static const onPrimaryFixed      = Color(0xFF001B3D);
  static const onPrimaryFixedVariant = Color(0xFF00468C);
  static const inversePrimary      = Color(0xFFA9C7FF);
  static const surfaceTint         = Color(0xFF1565C0);

  // ── Secondary (green — income / credit) ──────────────────────────────────
  static const secondary              = Color(0xFF2E7D32);
  static const onSecondary            = Color(0xFFFFFFFF);
  static const secondaryContainer     = Color(0xFFA3F69C);
  static const onSecondaryContainer   = Color(0xFF002204);
  static const secondaryFixed         = Color(0xFFA3F69C);
  static const secondaryFixedDim      = Color(0xFF88D982);
  static const onSecondaryFixed       = Color(0xFF002204);
  static const onSecondaryFixedVariant = Color(0xFF005312);

  // ── Tertiary (red — expense / debit) ─────────────────────────────────────
  static const tertiary              = Color(0xFFC62828);
  static const onTertiary            = Color(0xFFFFFFFF);
  static const tertiaryContainer     = Color(0xFFFFDAD6);
  static const onTertiaryContainer   = Color(0xFF410003);
  static const tertiaryFixed         = Color(0xFFFFDAD6);
  static const tertiaryFixedDim      = Color(0xFFFFB4AC);
  static const onTertiaryFixed       = Color(0xFF410003);
  static const onTertiaryFixedVariant = Color(0xFF93000E);

  // ── Error (validation / destructive — never financial) ───────────────────
  static const error            = Color(0xFFBA1A1A);
  static const onError          = Color(0xFFFFFFFF);
  static const errorContainer   = Color(0xFFFFDAD6);
  static const onErrorContainer = Color(0xFF410002);

  // ── Surface (light) ───────────────────────────────────────────────────────
  static const surface                  = Color(0xFFFAF9FD);
  static const onSurface                = Color(0xFF1A1B1E);
  static const surfaceDim               = Color(0xFFDAD9DD);
  static const surfaceBright            = Color(0xFFFAF9FD);
  static const surfaceContainerLowest   = Color(0xFFFFFFFF);
  static const surfaceContainerLow      = Color(0xFFF4F3F7);
  static const surfaceContainer         = Color(0xFFEFEDF1);
  static const surfaceContainerHigh     = Color(0xFFE9E7EC);
  static const surfaceContainerHighest  = Color(0xFFE3E2E6);
  static const surfaceVariant           = Color(0xFFE0E2EC);
  static const onSurfaceVariant         = Color(0xFF44474E);
  static const inverseSurface           = Color(0xFF2F3033);
  static const inverseOnSurface         = Color(0xFFF1F0F4);
  static const background               = Color(0xFFFAF9FD);
  static const onBackground             = Color(0xFF1A1B1E);

  // ── Outline (light) ───────────────────────────────────────────────────────
  static const outline        = Color(0xFF74777F);
  static const outlineVariant = Color(0xFFC4C6CF);

  // =========================================================================
  // Dark theme tokens
  // =========================================================================

  // ── Primary (dark) ────────────────────────────────────────────────────────
  static const darkPrimary              = Color(0xFFA9C7FF);
  static const darkOnPrimary            = Color(0xFF003063);
  static const darkPrimaryContainer     = Color(0xFF1A4F8C); // was #00468C — lifted for visibility
  static const darkOnPrimaryContainer   = Color(0xFFD6E3FF);

  // ── Secondary — income / credit (dark) ───────────────────────────────────
  static const darkSecondary              = Color(0xFF88D982);
  static const darkOnSecondary            = Color(0xFF003909);
  static const darkSecondaryContainer     = Color(0xFF1E5C27); // was #005312 — lifted so containers read as green
  static const darkOnSecondaryContainer   = Color(0xFFA3F69C);

  // ── Tertiary — expense / debit (dark) ────────────────────────────────────
  static const darkTertiary              = Color(0xFFFFB4AC);
  static const darkOnTertiary            = Color(0xFF690007);
  static const darkTertiaryContainer     = Color(0xFF93000E);
  static const darkOnTertiaryContainer   = Color(0xFFFFDAD6);

  // ── Error (dark) ─────────────────────────────────────────────────────────
  static const darkError            = Color(0xFFFFB4AB);
  static const darkOnError          = Color(0xFF690005);
  static const darkErrorContainer   = Color(0xFF93000A);
  static const darkOnErrorContainer = Color(0xFFFFB4AB);

  // ── Surface (dark) ────────────────────────────────────────────────────────
  // Surfaces carry a subtle blue undertone seeded from primary (#1565C0),
  // producing the "ink-dark" feel described in DESIGN.md rather than flat charcoal.
  static const darkSurface                  = Color(0xFF0F1117);
  static const darkOnSurface               = Color(0xFFE3E2E6);
  static const darkSurfaceDim               = Color(0xFF0F1117);
  static const darkSurfaceBright            = Color(0xFF353840);
  static const darkSurfaceContainerLowest   = Color(0xFF0A0C13);
  static const darkSurfaceContainerLow      = Color(0xFF161923);
  static const darkSurfaceContainer         = Color(0xFF1B1E27);
  static const darkSurfaceContainerHigh     = Color(0xFF262931);
  static const darkSurfaceContainerHighest  = Color(0xFF31343C);
  static const darkOnSurfaceVariant         = Color(0xFFC4C6CF);
  static const darkInverseSurface           = Color(0xFFE3E2E6);
  static const darkInverseOnSurface         = Color(0xFF2F3033);
  static const darkInversePrimary           = Color(0xFF1565C0);
  static const darkBackground               = Color(0xFF0F1117);
  static const darkOnBackground             = Color(0xFFE3E2E6);

  // ── Outline (dark) ────────────────────────────────────────────────────────
  static const darkOutline        = Color(0xFF8E9099);
  static const darkOutlineVariant = Color(0xFF44474E);

  // =========================================================================
  // Semantic tokens outside the M3 ColorScheme
  //
  // These cover layout concerns M3 doesn't model: card elevation shadows,
  // full-bleed hero gradients on the dashboard, and modal overlay scrims.
  // Named by purpose, not by visual inspiration.
  // =========================================================================

  // ── Card shadow ───────────────────────────────────────────────────────────
  /// Ambient shadow color for elevated cards.
  /// Apply via BoxShadow; see AppDimensions.shadowBlurCard / shadowOffsetCard.
  static const shadowCard = Color(0x1A000000); // black @ 10%

  // ── Hero gradient (dashboard header band) ────────────────────────────────
  /// Start and end stops for the full-bleed dark header gradient.
  /// Intentionally dark so that white text and icons remain legible at all times.
  static const heroGradientStart = Color(0xFF0D1117);
  static const heroGradientEnd   = Color(0xFF1A1D2E);

  // ── Modal / bottom-sheet scrim ────────────────────────────────────────────
  /// Semi-transparent overlay behind modal surfaces and bottom sheets.
  static const overlayScrim = Color(0x80000000); // black @ 50%
}
