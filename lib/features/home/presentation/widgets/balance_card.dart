import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../l10n/app_localizations.dart';

abstract final class _Dims {
  static const double eyeIconSize      = 22.0;
  static const double labelToAmountGap = 6.0;
  static const double paddingV         = 28.0;
}

class BalanceCard extends StatelessWidget {
  const BalanceCard({
    super.key,
    required this.netBalance,
    required this.isMasked,
    required this.onToggleMask,
  });

  final double netBalance;
  final bool isMasked;
  final VoidCallback onToggleMask;

  @override
  Widget build(BuildContext context) {
    final l10n   = AppLocalizations.of(context)!;
    final cs     = Theme.of(context).colorScheme;
    final locale = Localizations.localeOf(context).toString();

    final Color amountColor;
    if (netBalance > 0) {
      amountColor = cs.secondary;
    } else if (netBalance < 0) {
      amountColor = cs.tertiary;
    } else {
      amountColor = cs.onSurface;
    }

    final formatted = isMasked
        ? '₹ ••••'
        : NumberFormat.currency(
            locale: locale,
            symbol: '₹ ',
            decimalDigits: 0,
          ).format(netBalance.abs());

    // No borderRadius — the dashboard screen owns the hero band shape.
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.buttonPaddingH,
        vertical: _Dims.paddingV,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.balanceCardLabel,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: _Dims.labelToAmountGap),
                Text(
                  formatted,
                  style: AppTextStyles.balanceHero.copyWith(color: amountColor),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onToggleMask,
            icon: Icon(
              isMasked ? Icons.visibility_off_rounded : Icons.visibility_rounded,
              size: _Dims.eyeIconSize,
              color: cs.onSurfaceVariant,
            ),
            tooltip: isMasked ? l10n.balanceShowTooltip : l10n.balanceHideTooltip,
          ),
        ],
      ),
    );
  }
}
