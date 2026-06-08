import 'package:flutter/material.dart';

import '../../core/constants/app_dimensions.dart';

/// A single selectable chip — filled when [selected], outlined when not.
///
/// Used in filter rows, tag selectors, and option pickers.
class KpChip extends StatelessWidget {
  const KpChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onTap,
    this.leadingIcon,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final IconData? leadingIcon;

  @override
  Widget build(BuildContext context) {
    final colorScheme    = Theme.of(context).colorScheme;
    final textTheme      = Theme.of(context).textTheme;
    final reduceMotion   = MediaQuery.disableAnimationsOf(context);
    final borderRadius   = BorderRadius.circular(AppDimensions.radiusPill);

    final Color backgroundColor = selected
        ? colorScheme.secondaryContainer
        : Colors.transparent;
    final Color borderColor = selected
        ? colorScheme.secondary
        : colorScheme.outlineVariant;
    final Color textColor = selected
        ? colorScheme.onSecondaryContainer
        : colorScheme.onSurfaceVariant;
    final double borderWidth = selected
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
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.segmentPaddingH,
              vertical: AppDimensions.segmentPaddingV,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (leadingIcon != null) ...[
                  Icon(leadingIcon, size: AppDimensions.iconSizeSmall, color: textColor),
                  const SizedBox(width: AppDimensions.buttonStackGap),
                ],
                Text(
                  label,
                  style: textTheme.labelLarge?.copyWith(
                    color: textColor,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
