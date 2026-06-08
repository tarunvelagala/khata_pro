import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

// ── KpColorsExtension ─────────────────────────────────────────────────────────
//
// Semantic color tokens that extend beyond the M3 ColorScheme.
// Covers fintech-specific slots (balance sign, hero gradient, overlays) that
// M3 does not model.  All widgets should resolve colors through this extension
// (via Theme.of(context).kpColorScheme) rather than importing AppColors directly,
// so white-label themes and future accessibility overrides require no widget changes.

@immutable
class KpColorsExtension extends ThemeExtension<KpColorsExtension> {
  const KpColorsExtension({
    required this.balancePositive,
    required this.balanceNegative,
    required this.balanceNeutral,
    required this.heroGradientStart,
    required this.heroGradientEnd,
    required this.shadowCard,
    required this.overlayScrim,
    required this.incomeLabel,
    required this.expenseLabel,
  });

  /// Net balance > 0 — secondary green.
  final Color balancePositive;

  /// Net balance < 0 — tertiary red.
  final Color balanceNegative;

  /// Net balance = 0 — onSurfaceVariant.
  final Color balanceNeutral;

  /// Start stop of the full-bleed dark header gradient (dashboard hero band).
  final Color heroGradientStart;

  /// End stop of the full-bleed dark header gradient.
  final Color heroGradientEnd;

  /// Ambient shadow color for elevated cards.
  final Color shadowCard;

  /// Semi-transparent overlay behind modal surfaces and bottom sheets.
  final Color overlayScrim;

  /// Income / credit label color (= secondary green).
  final Color incomeLabel;

  /// Expense / debit label color (= tertiary red).
  final Color expenseLabel;

  // ── Static instances ───────────────────────────────────────────────────────

  static const KpColorsExtension light = KpColorsExtension(
    balancePositive:   AppColors.secondary,
    balanceNegative:   AppColors.tertiary,
    balanceNeutral:    AppColors.onSurfaceVariant,
    heroGradientStart: AppColors.heroGradientStart,
    heroGradientEnd:   AppColors.heroGradientEnd,
    shadowCard:        AppColors.shadowCard,
    overlayScrim:      AppColors.overlayScrim,
    incomeLabel:       AppColors.secondary,
    expenseLabel:      AppColors.tertiary,
  );

  static const KpColorsExtension dark = KpColorsExtension(
    balancePositive:   AppColors.darkSecondary,
    balanceNegative:   AppColors.darkTertiary,
    balanceNeutral:    AppColors.darkOnSurfaceVariant,
    heroGradientStart: Color(0xFF080B0F),
    heroGradientEnd:   Color(0xFF111422),
    shadowCard:        Color(0x33000000), // 20% on dark surfaces
    overlayScrim:      AppColors.overlayScrim,
    incomeLabel:       AppColors.darkSecondary,
    expenseLabel:      AppColors.darkTertiary,
  );

  // ── ThemeExtension overrides ───────────────────────────────────────────────

  @override
  KpColorsExtension copyWith({
    Color? balancePositive,
    Color? balanceNegative,
    Color? balanceNeutral,
    Color? heroGradientStart,
    Color? heroGradientEnd,
    Color? shadowCard,
    Color? overlayScrim,
    Color? incomeLabel,
    Color? expenseLabel,
  }) => KpColorsExtension(
    balancePositive:   balancePositive   ?? this.balancePositive,
    balanceNegative:   balanceNegative   ?? this.balanceNegative,
    balanceNeutral:    balanceNeutral    ?? this.balanceNeutral,
    heroGradientStart: heroGradientStart ?? this.heroGradientStart,
    heroGradientEnd:   heroGradientEnd   ?? this.heroGradientEnd,
    shadowCard:        shadowCard        ?? this.shadowCard,
    overlayScrim:      overlayScrim      ?? this.overlayScrim,
    incomeLabel:       incomeLabel       ?? this.incomeLabel,
    expenseLabel:      expenseLabel      ?? this.expenseLabel,
  );

  @override
  KpColorsExtension lerp(KpColorsExtension? other, double t) {
    if (other == null) return this;
    return KpColorsExtension(
      balancePositive:   Color.lerp(balancePositive,   other.balancePositive,   t)!,
      balanceNegative:   Color.lerp(balanceNegative,   other.balanceNegative,   t)!,
      balanceNeutral:    Color.lerp(balanceNeutral,    other.balanceNeutral,    t)!,
      heroGradientStart: Color.lerp(heroGradientStart, other.heroGradientStart, t)!,
      heroGradientEnd:   Color.lerp(heroGradientEnd,   other.heroGradientEnd,   t)!,
      shadowCard:        Color.lerp(shadowCard,        other.shadowCard,        t)!,
      overlayScrim:      Color.lerp(overlayScrim,      other.overlayScrim,      t)!,
      incomeLabel:       Color.lerp(incomeLabel,       other.incomeLabel,       t)!,
      expenseLabel:      Color.lerp(expenseLabel,      other.expenseLabel,      t)!,
    );
  }
}

// ── KpTextThemeExtension ──────────────────────────────────────────────────────
//
// Custom text styles that extend beyond the M3 TextTheme.
// Currently only balanceHero (42px, w700) — larger than headlineLarge so the
// dashboard balance amount has dominant visual weight.

@immutable
class KpTextThemeExtension extends ThemeExtension<KpTextThemeExtension> {
  const KpTextThemeExtension({required this.balanceHero});

  /// Primary balance display — 42sp w700.  Color must be applied by the caller
  /// using kpColorScheme.balancePositive/Negative/Neutral.
  final TextStyle balanceHero;

  static const KpTextThemeExtension instance = KpTextThemeExtension(
    balanceHero: AppTextStyles.balanceHero,
  );

  @override
  KpTextThemeExtension copyWith({TextStyle? balanceHero}) =>
      KpTextThemeExtension(balanceHero: balanceHero ?? this.balanceHero);

  @override
  KpTextThemeExtension lerp(KpTextThemeExtension? other, double t) {
    if (other == null) return this;
    return KpTextThemeExtension(
      balanceHero: TextStyle.lerp(balanceHero, other.balanceHero, t)!,
    );
  }
}

// ── ThemeData convenience getters ─────────────────────────────────────────────
//
// Allows widgets to write Theme.of(context).kpColorScheme instead of
// Theme.of(context).extension<KpColorsExtension>()!

extension KpColorsThemeExtension on ThemeData {
  KpColorsExtension get kpColorScheme => extension<KpColorsExtension>()!;
}

extension KpTextThemeThemeExtension on ThemeData {
  KpTextThemeExtension get kpTextTheme => extension<KpTextThemeExtension>()!;
}
