import 'package:flutter/material.dart';

import '../../core/constants/app_dimensions.dart';
import '../atoms/kp_amount.dart';

/// Two-column gave/got amount block used on transaction list rows.
///
/// "You Gave" (isCredit=true) appears in the left column — expense/red.
/// "You Got"  (isCredit=false) appears in the right column — income/green.
/// The inactive column shows a neutral `₹ 0` to preserve column alignment.
class KpAmountTile extends StatelessWidget {
  const KpAmountTile({
    super.key,
    required this.amount,
    required this.isCredit,
    this.masked = false,
    this.locale,
  });

  final double amount;
  final bool isCredit;
  final bool masked;
  final String? locale;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme   = Theme.of(context).textTheme;

    Widget zeroPlaceholder() => Align(
          alignment: Alignment.centerRight,
          child: Text(
            '₹ 0',
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
          ),
        );

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left column: "You Gave" (credit = expense = red)
        SizedBox(
          width: AppDimensions.txnColWidth,
          child: isCredit
              ? Align(
                  alignment: Alignment.centerRight,
                  child: KpAmount(
                    amount: amount,
                    variant: KpAmountVariant.expense,
                    masked: masked,
                    locale: locale,
                    showPrefix: true,
                  ),
                )
              : zeroPlaceholder(),
        ),
        const SizedBox(width: AppDimensions.buttonStackGap * 2),
        // Right column: "You Got" (not credit = income = green)
        SizedBox(
          width: AppDimensions.txnColWidth,
          child: isCredit
              ? zeroPlaceholder()
              : Align(
                  alignment: Alignment.centerRight,
                  child: KpAmount(
                    amount: amount,
                    variant: KpAmountVariant.income,
                    masked: masked,
                    locale: locale,
                    showPrefix: true,
                  ),
                ),
        ),
      ],
    );
  }
}
