import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/widgets/amount_text.dart';
import '../../../../core/widgets/app_avatar.dart';
import '../../domain/models/transaction.dart';
import '../../../../l10n/app_localizations.dart';

abstract final class _Dims {
  static const double tileMinHeight = 64.0;
  static const double subtitleGap   = 2.0;
}

class TransactionListTile extends StatelessWidget {
  const TransactionListTile({
    super.key,
    required this.transaction,
    required this.isMasked,
  });

  final Transaction transaction;
  final bool isMasked;

  @override
  Widget build(BuildContext context) {
    final cs   = Theme.of(context).colorScheme;
    final tt   = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    final formattedDate = DateFormatter.relativeTime(transaction.timestamp, l10n);
    final initial       = transaction.avatarLabel;
    final isCredit      = transaction.isCredit;

    return Container(
      constraints: const BoxConstraints(minHeight: _Dims.tileMinHeight),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.buttonPaddingH,
        vertical: AppDimensions.inputPaddingH,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTileAvatar(initial: initial),
          const SizedBox(width: AppDimensions.inputPaddingH),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Expanded(
                      child: Text(
                        transaction.customerName,
                        style: tt.bodyMedium?.copyWith(
                          color: cs.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(width: AppDimensions.buttonStackGap),
                    AmountText.transaction(
                      amount: transaction.amount,
                      isCredit: isCredit,
                      isMasked: isMasked,
                    ),
                  ],
                ),
                const SizedBox(height: _Dims.subtitleGap),
                Text(
                  formattedDate,
                  style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
