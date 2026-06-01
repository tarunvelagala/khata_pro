import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';

abstract final class _Dims {
  static const double cardPaddingV     = 18.0;
  static const double cardPaddingH     = 20.0;
  static const double labelToAmountGap = 2.0;
  static const double dividerHeight    = 48.0;
}

// Unicode arrows — inline with label, no container needed.
const String _arrowDown = '↓';
const String _arrowUp   = '↑';

class SummaryPills extends StatelessWidget {
  const SummaryPills({
    super.key,
    required this.totalIncome,
    required this.totalExpense,
    required this.isMasked,
  });

  final double totalIncome;
  final double totalExpense;
  final bool isMasked;

  @override
  Widget build(BuildContext context) {
    final l10n   = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    final cs     = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: cs.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowCard,
            blurRadius: AppDimensions.shadowBlurCard,
            offset: const Offset(0, AppDimensions.shadowOffsetCard),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: _Dims.cardPaddingH,
        vertical: _Dims.cardPaddingV,
      ),
      child: Row(
        children: [
          Expanded(
            child: _StatItem(
              arrow: _arrowDown,
              label: l10n.summaryIncomeLabel,
              amount: totalIncome,
              isMasked: isMasked,
              locale: locale,
              isIncome: true,
            ),
          ),
          SizedBox(
            height: _Dims.dividerHeight,
            child: VerticalDivider(
              width: 1,
              thickness: AppDimensions.borderDefault,
              color: cs.outlineVariant,
            ),
          ),
          Expanded(
            child: _StatItem(
              arrow: _arrowUp,
              label: l10n.summaryExpenseLabel,
              amount: totalExpense,
              isMasked: isMasked,
              locale: locale,
              isIncome: false,
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
    required this.isMasked,
    required this.locale,
    required this.isIncome,
  });

  final String arrow;
  final String label;
  final double amount;
  final bool isMasked;
  final String locale;
  final bool isIncome;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final amountColor = isIncome ? cs.secondary : cs.tertiary;
    final alignment   = isIncome ? CrossAxisAlignment.start : CrossAxisAlignment.end;
    final padding     = isIncome
        ? const EdgeInsets.only(right: _Dims.cardPaddingH)
        : const EdgeInsets.only(left: _Dims.cardPaddingH);

    final formatted = isMasked
        ? '₹ ••••'
        : NumberFormat.currency(
            locale: locale,
            symbol: '₹ ',
            decimalDigits: 0,
          ).format(amount);

    final labelStyle = tt.labelSmall?.copyWith(color: cs.onSurfaceVariant);

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: alignment,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '$arrow ',
                  style: labelStyle?.copyWith(color: amountColor),
                ),
                TextSpan(text: label, style: labelStyle),
              ],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: _Dims.labelToAmountGap),
          Text(
            formatted,
            style: tt.headlineSmall?.copyWith(
              color: amountColor,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
