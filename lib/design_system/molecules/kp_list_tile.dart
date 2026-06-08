import 'package:flutter/material.dart';

import '../../core/constants/app_dimensions.dart';

/// Generalized list tile with avatar + title + optional subtitle + optional trailing.
///
/// No coupling to any domain model — pass raw strings and widgets.
/// Use [KpTransactionTile] or a feature-level wrapper when domain-specific
/// formatting (e.g. amount colors, relative dates) is needed.
class KpListTile extends StatelessWidget {
  const KpListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.selected = false,
    this.contentPadding,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool selected;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme   = Theme.of(context).textTheme;
    final padding     = contentPadding ??
        const EdgeInsets.symmetric(
          horizontal: AppDimensions.inputPaddingH,
          vertical:   AppDimensions.segmentPaddingV + AppDimensions.borderDefault,
        );

    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      splashColor: colorScheme.primary.withValues(alpha: AppDimensions.splashAlpha),
      highlightColor: colorScheme.primary.withValues(alpha: AppDimensions.highlightAlpha),
      child: Padding(
        padding: padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: AppDimensions.inputPaddingH),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: textTheme.titleSmall?.copyWith(
                      color: selected ? colorScheme.primary : colorScheme.onSurface,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                ],
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: AppDimensions.buttonStackGap),
              trailing!,
            ],
          ],
        ),
      ),
    );
  }
}
