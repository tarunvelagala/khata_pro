import 'package:flutter/material.dart';

import '../../core/constants/app_dimensions.dart';

/// Color variant that drives badge background and text colors.
enum KpBadgeVariant {
  /// Primary container tint — default for counts and notifications.
  primary,

  /// Error container tint — for alerts and warnings.
  error,

  /// Surface container — for neutral / inactive badges.
  neutral,
}

/// Pill-shaped count badge.
///
/// Truncates to `[max]+` when the count exceeds [max].
class KpBadge extends StatelessWidget {
  const KpBadge({
    super.key,
    required this.count,
    this.max = 99,
    this.variant = KpBadgeVariant.primary,
  });

  final int count;
  final int max;
  final KpBadgeVariant variant;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme   = Theme.of(context).textTheme;

    final String label = count > max ? '$max+' : '$count';

    final Color background;
    final Color foreground;
    switch (variant) {
      case KpBadgeVariant.primary:
        background = colorScheme.primaryContainer;
        foreground = colorScheme.onPrimaryContainer;
      case KpBadgeVariant.error:
        background = colorScheme.errorContainer;
        foreground = colorScheme.onErrorContainer;
      case KpBadgeVariant.neutral:
        background = colorScheme.surfaceContainerHighest;
        foreground = colorScheme.onSurfaceVariant;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.inputPaddingH / 2,
        vertical: AppDimensions.borderDefault,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
      ),
      child: Text(
        label,
        style: textTheme.labelSmall?.copyWith(
          color: foreground,
          fontWeight: FontWeight.w700,
          letterSpacing: AppDimensions.letterSpacingLabel,
        ),
      ),
    );
  }
}
