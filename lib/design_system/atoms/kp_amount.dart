import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/theme/kp_theme_extension.dart';

/// Semantic variant that drives color and prefix rendering.
enum KpAmountVariant {
  /// Income / credit — secondary green, `+ ₹` prefix when [showPrefix] is true.
  income,

  /// Expense / debit — tertiary red, `- ₹` prefix when [showPrefix] is true.
  expense,

  /// Zero or unknown direction — onSurfaceVariant, no prefix.
  neutral,

  /// Net balance (signed double) — positive=tertiary, negative=secondary, zero=neutral.
  balance,
}

/// Renders a rupee amount with semantic color from [KpAmountVariant].
///
/// All color semantics are resolved through [KpColorsExtension] — never
/// hardcoded — so white-label themes work without touching this widget.
///
/// ```dart
/// KpAmount(amount: 1200, variant: KpAmountVariant.income)
/// KpAmount(amount: customer.netBalance, variant: KpAmountVariant.balance)
/// KpAmount(amount: txn.amount, variant: txn.isCredit ? KpAmountVariant.expense : KpAmountVariant.income)
/// ```
class KpAmount extends StatelessWidget {
  const KpAmount({
    super.key,
    required this.amount,
    required this.variant,
    this.style,
    this.currencySymbol = '₹',
    this.compact = false,
    this.masked = false,
    this.locale,
    this.showPrefix = false,
  });

  final double amount;
  final KpAmountVariant variant;

  /// Override text style. Color is still applied from [variant] — only size,
  /// weight, and other non-color properties are taken from [style].
  final TextStyle? style;

  final String currencySymbol;

  /// When true, formats as compact notation (e.g. ₹1.2L) for KPI tiles.
  final bool compact;

  /// When true, renders `₹ ••••` regardless of amount.
  final bool masked;

  /// BCP-47 locale string for number formatting. Defaults to widget locale.
  final String? locale;

  /// When true, prepends `+ ` or `- ` based on variant.
  final bool showPrefix;

  @override
  Widget build(BuildContext context) {
    final kpColorScheme = Theme.of(context).kpColorScheme;
    final textTheme     = Theme.of(context).textTheme;
    final resolvedLocale = locale ?? Localizations.localeOf(context).toString();

    final Color color = _resolveColor(kpColorScheme);

    final String text = masked
        ? '$currencySymbol ••••'
        : _formatAmount(resolvedLocale);

    final resolvedStyle = (style ?? textTheme.titleMedium)?.copyWith(
      color: color,
      fontWeight: FontWeight.w700,
      fontFeatures: const [FontFeature.tabularFigures()],
    );

    return Text(
      text,
      style: resolvedStyle,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  Color _resolveColor(KpColorsExtension kpColorScheme) {
    return switch (variant) {
      KpAmountVariant.income  => kpColorScheme.incomeLabel,
      KpAmountVariant.expense => kpColorScheme.expenseLabel,
      KpAmountVariant.neutral => kpColorScheme.balanceNeutral,
      KpAmountVariant.balance => amount > 0
          ? kpColorScheme.balancePositive
          : amount < 0
              ? kpColorScheme.balanceNegative
              : kpColorScheme.balanceNeutral,
    };
  }

  String _formatAmount(String resolvedLocale) {
    if (compact) {
      final absAmount = amount.abs();
      final String formatted;
      if (absAmount >= 100000) {
        formatted = '$currencySymbol${(absAmount / 100000).toStringAsFixed(1)}L';
      } else if (absAmount >= 1000) {
        formatted = '$currencySymbol${(absAmount / 1000).toStringAsFixed(1)}K';
      } else {
        formatted = '$currencySymbol${absAmount.toStringAsFixed(0)}';
      }
      return formatted;
    }

    final formatted = NumberFormat.currency(
      locale: resolvedLocale,
      symbol: '',
      decimalDigits: 0,
    ).format(amount.abs()).trim();

    if (showPrefix) {
      final prefix = variant == KpAmountVariant.expense ? '- ' : '+ ';
      return '$prefix$currencySymbol $formatted';
    }
    return '$currencySymbol $formatted';
  }
}
