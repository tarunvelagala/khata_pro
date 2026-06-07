import 'package:flutter/material.dart';

import '../constants/app_dimensions.dart';
import 'amount_text.dart';

/// Two-column debit/credit amount block used on transaction list tiles.
///
/// "You Gave" (isCredit=true) sits in the left column (red).
/// "You Got"  (isCredit=false) sits in the right column (green).
/// The inactive column shows a grey ₹ 0 so alignment is always preserved.
class TxnTwoColAmount extends StatelessWidget {
  const TxnTwoColAmount({
    super.key,
    required this.amount,
    required this.isCredit,
    required this.isMasked,
  });

  final double amount;
  final bool isCredit;
  final bool isMasked;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    Widget zeroPlaceholder() => Align(
          alignment: Alignment.centerRight,
          child: Text(
            '₹ 0',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: cs.onSurfaceVariant),
          ),
        );

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // "You Gave" column (isCredit = true → red)
        SizedBox(
          width: AppDimensions.txnColWidth,
          child: isCredit
              ? Align(
                  alignment: Alignment.centerRight,
                  child: AmountText.transaction(
                    amount: amount,
                    isCredit: true,
                    isMasked: isMasked,
                  ),
                )
              : zeroPlaceholder(),
        ),
        SizedBox(width: AppDimensions.buttonStackGap * 2),
        // "You Got" column (isCredit = false → green)
        SizedBox(
          width: AppDimensions.txnColWidth,
          child: isCredit
              ? zeroPlaceholder()
              : Align(
                  alignment: Alignment.centerRight,
                  child: AmountText.transaction(
                    amount: amount,
                    isCredit: false,
                    isMasked: isMasked,
                  ),
                ),
        ),
      ],
    );
  }
}
