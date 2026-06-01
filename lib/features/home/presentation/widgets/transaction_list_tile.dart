import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/widgets/avatar_palette.dart';
import '../../domain/models/transaction.dart';
import '../../../../l10n/app_localizations.dart';

abstract final class _Dims {
  static const double avatarRadius   = 22.0;
  static const double avatarFontSize = 14.0;
  static const double tileMinHeight  = 64.0;
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
    final cs     = Theme.of(context).colorScheme;
    final tt     = Theme.of(context).textTheme;
    final locale = Localizations.localeOf(context).toString();
    final l10n   = AppLocalizations.of(context)!;

    final amountColor  = transaction.isCredit ? cs.secondary : cs.tertiary;
    final amountPrefix = transaction.isCredit ? '+ ' : '- ';

    final formattedAmount = isMasked
        ? '₹ ••••'
        : '$amountPrefix₹ ${NumberFormat.currency(
            locale: locale,
            symbol: '',
            decimalDigits: 0,
          ).format(transaction.amount).trim()}';

    final formattedDate = _formatDate(transaction.timestamp, l10n);
    final bg = avatarColorFor(transaction.avatarLabel);

    return Container(
      constraints: const BoxConstraints(minHeight: _Dims.tileMinHeight),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.buttonPaddingH,
        vertical: AppDimensions.inputPaddingH,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: _Dims.avatarRadius,
            backgroundColor: bg,
            child: Text(
              transaction.avatarLabel,
              style: tt.labelMedium?.copyWith(
                fontSize: _Dims.avatarFontSize,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: AppDimensions.inputPaddingH),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  transaction.customerName,
                  style: tt.bodyMedium?.copyWith(
                    color: cs.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (transaction.shopName != null)
                  Text(
                    transaction.shopName!,
                    style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                    overflow: TextOverflow.ellipsis,
                  ),
                Text(
                  formattedDate,
                  style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppDimensions.inputPaddingH),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                formattedAmount,
                style: tt.titleMedium?.copyWith(
                  color: amountColor,
                  fontWeight: FontWeight.w700,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
              Text(
                transaction.isCredit ? l10n.txnTypeReceived : l10n.txnTypePaid,
                style: tt.labelSmall?.copyWith(color: amountColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime dt, AppLocalizations l10n) {
    final now  = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inMinutes < 60) return l10n.txnTimeMinutesAgo(diff.inMinutes);
    if (diff.inHours < 24)   return l10n.txnTimeToday(DateFormat.jm().format(dt));
    if (diff.inDays == 1)    return l10n.txnTimeYesterday(DateFormat.jm().format(dt));
    return DateFormat('d MMM, hh:mm a').format(dt);
  }
}
