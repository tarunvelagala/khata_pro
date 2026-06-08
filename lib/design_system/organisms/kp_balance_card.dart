import 'package:flutter/material.dart';

import '../../core/constants/app_dimensions.dart';
import '../../core/theme/kp_theme_extension.dart';
import '../../l10n/app_localizations.dart';
import '../atoms/kp_amount.dart';

abstract final class _Dims {
  static const double eyeIconSize      = 22.0;
  static const double labelToAmountGap = 6.0;
  static const double paddingV         = 20.0;
  static const double statRowGap       = 14.0;
  static const double statLabelGap     = 2.0;
}

// Unicode directional arrows — GPay style, inline with label.
const String _arrowDown = '↓';
const String _arrowUp   = '↑';

/// Generalized balance hero card showing net balance and income/expense sub-stats.
///
/// No coupling to any domain model — pass raw doubles.
/// Wrap in a [KpHeroBand] for the full-bleed gradient background.
class KpBalanceCard extends StatelessWidget {
  const KpBalanceCard({
    super.key,
    required this.netBalance,
    required this.incomeTotal,
    required this.expenseTotal,
    this.masked = false,
    this.onToggleMask,
    this.locale,
  });

  final double netBalance;
  final double incomeTotal;
  final double expenseTotal;
  final bool masked;
  final VoidCallback? onToggleMask;
  final String? locale;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final colorScheme   = Theme.of(context).colorScheme;
    final textTheme     = Theme.of(context).textTheme;
    final kpTextTheme   = Theme.of(context).kpTextTheme;
    final kpColorScheme = Theme.of(context).kpColorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.buttonPaddingH,
        vertical:   _Dims.paddingV,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Net balance row ───────────────────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizations.balanceCardLabel,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: _Dims.labelToAmountGap),
                    KpAmount(
                      amount:  netBalance,
                      variant: KpAmountVariant.balance,
                      masked:  masked,
                      locale:  locale,
                      style:   kpTextTheme.balanceHero,
                    ),
                  ],
                ),
              ),
              if (onToggleMask != null)
                IconButton(
                  onPressed: onToggleMask,
                  icon: Icon(
                    masked
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                    size:  _Dims.eyeIconSize,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  tooltip: masked
                      ? localizations.balanceShowTooltip
                      : localizations.balanceHideTooltip,
                ),
            ],
          ),

          const SizedBox(height: _Dims.statRowGap),

          // ── Income / expense sub-stats ────────────────────────────────
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: _StatItem(
                    arrow:   _arrowDown,
                    label:   localizations.summaryIncomeLabel,
                    amount:  incomeTotal,
                    variant: KpAmountVariant.expense, // they gave you = red
                    masked:  masked,
                    locale:  locale,
                    align:   CrossAxisAlignment.start,
                    arrowColor: kpColorScheme.expenseLabel,
                  ),
                ),
                Expanded(
                  child: _StatItem(
                    arrow:   _arrowUp,
                    label:   localizations.summaryExpenseLabel,
                    amount:  expenseTotal,
                    variant: KpAmountVariant.income,  // you gave them = green
                    masked:  masked,
                    locale:  locale,
                    align:   CrossAxisAlignment.end,
                    arrowColor: kpColorScheme.incomeLabel,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.arrow,
    required this.label,
    required this.amount,
    required this.variant,
    required this.masked,
    required this.align,
    required this.arrowColor,
    this.locale,
  });

  final String arrow;
  final String label;
  final double amount;
  final KpAmountVariant variant;
  final bool masked;
  final CrossAxisAlignment align;
  final Color arrowColor;
  final String? locale;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme   = Theme.of(context).textTheme;

    final labelStyle = textTheme.labelMedium?.copyWith(color: colorScheme.onSurfaceVariant);

    return Column(
      crossAxisAlignment: align,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text.rich(
          TextSpan(children: [
            TextSpan(text: '$arrow ', style: labelStyle?.copyWith(color: arrowColor)),
            TextSpan(text: label, style: labelStyle),
          ]),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: _Dims.statLabelGap),
        KpAmount(amount: amount, variant: variant, masked: masked, locale: locale),
      ],
    );
  }
}
