import 'package:flutter/material.dart';

import '../../core/constants/app_dimensions.dart';
import '../atoms/kp_amount.dart';

abstract final class _Dims {
  static const double iconContainerSize = 32.0;
  static const double iconContainerRadius = 8.0;
  static const double paddingH = 12.0;
  static const double paddingV = 12.0;
  static const double iconGap  = 8.0;
}

/// KPI stat card: amount + descriptive label.
///
/// Used in dashboard summary rows and report totals.
/// Pass [icon] for an optional leading icon container.
class KpStatTile extends StatelessWidget {
  const KpStatTile({
    super.key,
    required this.label,
    required this.amount,
    required this.variant,
    this.icon,
    this.locale,
  });

  final String label;
  final double amount;
  final KpAmountVariant variant;
  final IconData? icon;
  final String? locale;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme   = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: _Dims.paddingH,
        vertical:   _Dims.paddingV,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Container(
              width: _Dims.iconContainerSize,
              height: _Dims.iconContainerSize,
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(_Dims.iconContainerRadius),
              ),
              alignment: Alignment.center,
              child: Icon(icon, size: AppDimensions.iconSizeSmall, color: colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: _Dims.iconGap),
          ],
          KpAmount(amount: amount, variant: variant, locale: locale),
          const SizedBox(height: AppDimensions.borderDefault),
          Text(
            label,
            style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
