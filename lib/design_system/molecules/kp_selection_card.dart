import 'package:flutter/material.dart';

import '../../core/constants/app_dimensions.dart';

abstract final class _Dims {
  static const double checkSize = 18.0;
  static const double paddingV  = 12.0;
  static const double paddingH  = 12.0;
  static const double badgeGap  = 12.0;
}

/// Bordered tappable card with animated selection state.
///
/// Shows a circular badge (initial letter or custom [badge]), title,
/// optional subtitle, and a check icon when [isSelected] is true.
class KpSelectionCard extends StatelessWidget {
  const KpSelectionCard({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.subtitle,
    this.badge,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final String? subtitle;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final colorScheme  = Theme.of(context).colorScheme;
    final textTheme    = Theme.of(context).textTheme;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final borderRadius = BorderRadius.circular(AppDimensions.radiusMedium);

    final backgroundColor = isSelected
        ? colorScheme.surfaceContainerLowest
        : colorScheme.surfaceContainerLow;
    final borderColor = isSelected ? colorScheme.primary : colorScheme.outlineVariant;
    final borderWidth = isSelected
        ? AppDimensions.borderFocused
        : AppDimensions.borderDefault;

    return AnimatedContainer(
      duration: reduceMotion ? Duration.zero : AppDimensions.animShort,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: borderRadius,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          splashColor: colorScheme.primary.withValues(alpha: AppDimensions.splashAlpha),
          highlightColor: colorScheme.primary.withValues(alpha: AppDimensions.highlightAlpha),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: _Dims.paddingH,
              vertical:   _Dims.paddingV,
            ),
            child: Row(
              children: [
                _BadgeCircle(
                  isSelected: isSelected,
                  label: badge ?? (title.isNotEmpty ? title[0] : '?'),
                ),
                const SizedBox(width: _Dims.badgeGap),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: textTheme.titleMedium?.copyWith(
                          color: isSelected ? colorScheme.onSurface : colorScheme.onSurfaceVariant,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (subtitle != null)
                        Text(
                          subtitle!,
                          style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
                if (isSelected)
                  Icon(Icons.check_circle_rounded, color: colorScheme.primary, size: _Dims.checkSize),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BadgeCircle extends StatelessWidget {
  const _BadgeCircle({required this.isSelected, required this.label});

  final bool isSelected;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme   = Theme.of(context).textTheme;

    return Container(
      width:  AppDimensions.avatarSize,
      height: AppDimensions.avatarSize,
      decoration: BoxDecoration(
        color: isSelected
            ? colorScheme.primaryContainer
            : colorScheme.onSurface.withValues(alpha: AppDimensions.badgeGlassAlpha),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: textTheme.titleSmall?.copyWith(
          color: colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
