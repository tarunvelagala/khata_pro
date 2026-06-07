import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/widgets/amount_text.dart';
import '../../../../l10n/app_localizations.dart';

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

class BalanceCard extends StatelessWidget {
  const BalanceCard({
    super.key,
    required this.netBalance,
    required this.totalIncome,
    required this.totalExpense,
    required this.isMasked,
    required this.onToggleMask,
  });

  final double netBalance;
  final double totalIncome;
  final double totalExpense;
  final bool isMasked;
  final VoidCallback onToggleMask;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs   = Theme.of(context).colorScheme;
    final tt   = Theme.of(context).textTheme;

    // No borderRadius — the dashboard screen owns the hero band shape.
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.buttonPaddingH,
        vertical: _Dims.paddingV,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Main balance row ────────────────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.balanceCardLabel,
                      style: tt.bodyMedium?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: _Dims.labelToAmountGap),
                    AmountText.balance(
                      balance: netBalance,
                      isMasked: isMasked,
                      style: tt.displaySmall?.copyWith(
                        fontSize: 42,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onToggleMask,
                icon: Icon(
                  isMasked
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                  size: _Dims.eyeIconSize,
                  color: cs.onSurfaceVariant,
                ),
                tooltip: isMasked
                    ? l10n.balanceShowTooltip
                    : l10n.balanceHideTooltip,
              ),
            ],
          ),

          const SizedBox(height: _Dims.statRowGap),

          // ── Income / expense sub-stats ──────────────────────────────
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: _StatItem(
                    arrow: _arrowDown,
                    label: l10n.summaryIncomeLabel,
                    balance: totalIncome,
                    isMasked: isMasked,
                    align: CrossAxisAlignment.start,
                    style: tt.titleLarge,
                    color: cs.tertiary,
                  ),
                ),
                Expanded(
                  child: _StatItem(
                    arrow: _arrowUp,
                    label: l10n.summaryExpenseLabel,
                    balance: -totalExpense,
                    isMasked: isMasked,
                    align: CrossAxisAlignment.end,
                    style: tt.titleLarge,
                    color: cs.secondary,
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
    required this.balance,
    required this.isMasked,
    required this.align,
    required this.style,
    required this.color,
  });

  final String arrow;
  final String label;
  final double balance;
  final bool isMasked;
  final CrossAxisAlignment align;
  final TextStyle? style;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final labelStyle = tt.labelMedium?.copyWith(color: cs.onSurfaceVariant);

    return Column(
      crossAxisAlignment: align,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '$arrow ',
                style: labelStyle?.copyWith(color: color),
              ),
              TextSpan(text: label, style: labelStyle),
            ],
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: _Dims.statLabelGap),
        AmountText.balance(
          balance: balance,
          isMasked: isMasked,
          style: style,
        ),
      ],
    );
  }
}
