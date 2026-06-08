import 'package:flutter/material.dart';

import '../../core/constants/app_dimensions.dart';

/// An icon button that switches between a plain (transparent) state and a
/// filled tonal state — matching GPay / M3 app-bar icon conventions.
///
/// When [isActive] is false the button renders as a standard icon button with
/// no background. When [isActive] is true the background becomes
/// [activeContainerColor] (defaults to [ColorScheme.secondaryContainer]) and
/// the foreground becomes [activeForegroundColor] (defaults to
/// [ColorScheme.onSecondaryContainer]).
///
/// [activeChild] overrides [icon] when active — useful for showing a text
/// initial or a different icon to communicate the active state.
class KpTonalIconButton extends StatelessWidget {
  const KpTonalIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.isActive = false,
    this.activeChild,
    this.activeContainerColor,
    this.activeForegroundColor,
    this.tooltip,
  });

  final Widget icon;
  final VoidCallback? onPressed;
  final bool isActive;

  /// Widget shown in place of [icon] when [isActive] is true.
  final Widget? activeChild;

  /// Container color when active. Defaults to [ColorScheme.secondaryContainer].
  final Color? activeContainerColor;

  /// Foreground (icon/text) color when active. Defaults to
  /// [ColorScheme.onSecondaryContainer].
  final Color? activeForegroundColor;

  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final containerColor = isActive
        ? (activeContainerColor ?? cs.secondaryContainer)
        : Colors.transparent;
    final foregroundColor = isActive
        ? (activeForegroundColor ?? cs.onSecondaryContainer)
        : cs.onSurfaceVariant;

    return IconButton(
      tooltip: tooltip,
      icon: isActive && activeChild != null ? activeChild! : icon,
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: containerColor,
        foregroundColor: foregroundColor,
        iconSize: AppDimensions.iconSizeMedium,
      ),
    );
  }
}
