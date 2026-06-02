import 'package:flutter/material.dart';

import '../constants/app_dimensions.dart';

abstract final class _Dims {
  static const double checkSize = 18.0;
  static const double paddingV  = 12.0;
  static const double paddingH  = 12.0;
  static const double badgeGap  = 12.0;
}

class SelectionCard extends StatelessWidget {
  const SelectionCard({
    super.key,
    required this.title,
    this.subtitle,
    this.badge,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String? subtitle;
  final String? badge;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs           = Theme.of(context).colorScheme;
    final tt           = Theme.of(context).textTheme;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    final borderRadius = BorderRadius.circular(AppDimensions.radiusMedium);

    final bgColor = isSelected ? cs.surfaceContainerLowest : cs.surfaceContainerLow;
    final borderColor = isSelected ? cs.primary : cs.outlineVariant;
    final borderWidth = isSelected
        ? AppDimensions.borderFocused
        : AppDimensions.borderDefault;

    // Material must wrap InkWell so the splash is clipped to the card shape
    // and composited correctly over the animated background. Without Material,
    // the ripple either escapes the rounded corners or renders behind the
    // BoxDecoration and becomes invisible.
    return AnimatedContainer(
      duration: reduceMotion ? Duration.zero : AppDimensions.animShort,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: borderRadius,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: borderRadius,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          // Contained highlight — no spreading ring, just a tonal overlay
          // that fades within the card boundary. Matches GPay's tap feedback.
          splashColor: cs.primary.withValues(alpha: AppDimensions.splashAlpha),
          highlightColor: cs.primary.withValues(alpha: AppDimensions.highlightAlpha),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: _Dims.paddingH,
              vertical: _Dims.paddingV,
            ),
            child: Row(
              children: [
                _Badge(isSelected: isSelected, label: badge ?? title.characters.first),
                const SizedBox(width: _Dims.badgeGap),
                Expanded(
                  child: Text(
                    title,
                    style: tt.titleMedium?.copyWith(
                      color: isSelected ? cs.onSurface : cs.onSurfaceVariant,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (isSelected)
                  Icon(Icons.check_circle_rounded, color: cs.primary, size: _Dims.checkSize),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.isSelected, required this.label});

  final bool isSelected;
  final String label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      width: AppDimensions.avatarSize,
      height: AppDimensions.avatarSize,
      decoration: BoxDecoration(
        color: isSelected
            ? cs.primaryContainer
            : cs.onSurface.withValues(alpha: AppDimensions.badgeGlassAlpha),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: tt.titleSmall?.copyWith(
          color: cs.onSurfaceVariant,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
