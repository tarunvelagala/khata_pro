import 'package:flutter/material.dart';

import '../constants/app_dimensions.dart';
import '../../l10n/app_localizations.dart';

/// Column header row for the two-column (Gave / Got) transaction layout.
/// Resolves its own theme and localization from [context].
class TxnColHeader extends StatelessWidget {
  const TxnColHeader({super.key, this.trailingWidth = 0});

  /// Extra width reserved at the trailing edge to align with a [MoreIconButton].
  /// Pass `AppDimensions.buttonStackGap + AppDimensions.iconSizeSmall` when
  /// the list tiles include a more-button.
  final double trailingWidth;

  @override
  Widget build(BuildContext context) {
    final cs   = Theme.of(context).colorScheme;
    final tt   = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    return Row(
      children: [
        const Spacer(),
        SizedBox(
          width: AppDimensions.txnColWidth,
          child: Text(
            l10n.txnColGave,
            style: tt.labelSmall?.copyWith(color: cs.tertiary),
            textAlign: TextAlign.end,
          ),
        ),
        SizedBox(width: AppDimensions.buttonStackGap * 2),
        SizedBox(
          width: AppDimensions.txnColWidth,
          child: Text(
            l10n.txnColGot,
            style: tt.labelSmall?.copyWith(color: cs.secondary),
            textAlign: TextAlign.end,
          ),
        ),
        if (trailingWidth > 0) SizedBox(width: trailingWidth),
      ],
    );
  }
}
