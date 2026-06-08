import 'package:flutter/material.dart';

import '../../core/constants/app_dimensions.dart';
import '../atoms/kp_amount.dart';
import '../atoms/kp_avatar.dart';

abstract final class _Dims {
  static const double tileMinHeight = 64.0;
  static const double subtitleGap   = 2.0;
}

/// Generalized transaction list tile: avatar + name + subtitle + inline amount.
///
/// No coupling to the Transaction domain model — pass raw strings and doubles.
/// Feature-level wrappers (e.g. TransactionListTile in features/home) are
/// responsible for mapping the domain model to these parameters.
class KpTransactionTile extends StatelessWidget {
  const KpTransactionTile({
    super.key,
    required this.avatarLabel,
    required this.title,
    required this.amount,
    required this.isCredit,
    this.subtitle,
    this.masked = false,
    this.onTap,
    this.locale,
  });

  /// Single character used to generate the avatar color and initial.
  final String avatarLabel;

  /// Primary line — typically customer name.
  final String title;

  /// Secondary line — typically relative date or note.
  final String? subtitle;

  final double amount;
  final bool isCredit;
  final bool masked;
  final VoidCallback? onTap;
  final String? locale;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme   = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      splashColor: colorScheme.primary.withValues(alpha: AppDimensions.splashAlpha),
      child: Container(
        constraints: const BoxConstraints(minHeight: _Dims.tileMinHeight),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.buttonPaddingH,
          vertical:   AppDimensions.inputPaddingH,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            KpAvatar.listTile(label: avatarLabel),
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
                          title,
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(width: AppDimensions.buttonStackGap),
                      KpAmount(
                        amount:     amount,
                        variant:    isCredit
                            ? KpAmountVariant.expense
                            : KpAmountVariant.income,
                        masked:     masked,
                        locale:     locale,
                        showPrefix: true,
                      ),
                    ],
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: _Dims.subtitleGap),
                    Text(
                      subtitle!,
                      style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
