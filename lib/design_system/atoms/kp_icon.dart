import 'package:flutter/material.dart';

import '../../core/constants/app_dimensions.dart';

/// Semantic size variants for [KpIcon].
enum KpIconSize {
  /// 20dp — contextual icons: trailing actions, search prefix, clear button.
  small,

  /// 24dp — standard action icons in buttons and list tiles.
  medium,

  /// 32dp — prominent icons in empty states, hero band actions.
  large,
}

/// Constrained icon with semantic size and optional color override.
///
/// Defaults to [KpIconSize.medium] and [ColorScheme.onSurfaceVariant].
class KpIcon extends StatelessWidget {
  const KpIcon(
    this.icon, {
    super.key,
    this.size = KpIconSize.medium,
    this.color,
    this.semanticLabel,
  });

  final IconData icon;
  final KpIconSize size;
  final Color? color;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colorScheme   = Theme.of(context).colorScheme;
    final resolvedColor = color ?? colorScheme.onSurfaceVariant;

    final double resolvedSize = switch (size) {
      KpIconSize.small  => AppDimensions.iconSizeSmall,
      KpIconSize.medium => AppDimensions.iconSizeMedium,
      KpIconSize.large  => AppDimensions.emptyIconSize / 2,
    };

    return Icon(
      icon,
      size: resolvedSize,
      color: resolvedColor,
      semanticLabel: semanticLabel,
    );
  }
}
