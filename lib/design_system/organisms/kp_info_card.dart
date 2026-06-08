import 'package:flutter/material.dart';

import '../../core/constants/app_dimensions.dart';

abstract final class _Dims {
  static const double iconContainerSize   = 40.0;
  static const double iconContainerRadius = 10.0;
  static const double textGap            = 6.0;
  static const double paddingH           = 16.0;
  static const double paddingV           = 16.0;
}

/// Icon + title + body descriptive card.
///
/// Used for feature highlights, onboarding tips, and informational sections.
/// Pass [action] (e.g. a `TextButton`) to add a trailing interaction.
class KpInfoCard extends StatelessWidget {
  const KpInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
    this.action,
  });

  final IconData icon;
  final String title;
  final String body;
  final Widget? action;

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
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width:  _Dims.iconContainerSize,
            height: _Dims.iconContainerSize,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(_Dims.iconContainerRadius),
            ),
            alignment: Alignment.center,
            child: Icon(
              icon,
              size:  AppDimensions.iconSizeMedium,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(width: _Dims.paddingH),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: textTheme.titleSmall?.copyWith(color: colorScheme.onSurface),
                ),
                const SizedBox(height: _Dims.textGap),
                Text(
                  body,
                  style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                ),
                if (action != null) ...[
                  const SizedBox(height: _Dims.textGap),
                  action!,
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
