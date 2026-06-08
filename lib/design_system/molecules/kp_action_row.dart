import 'package:flutter/material.dart';

import '../../core/constants/app_dimensions.dart';

abstract final class _Dims {
  static const double leadingGap = 10.0; // gap between leading and text
}

/// Generic icon + title + optional subtitle + optional trailing row.
///
/// Use instead of Flutter's [ListTile] when you need precise padding control
/// and don't want the ListTile density / height constraints.
class KpActionRow extends StatelessWidget {
  const KpActionRow({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.contentPadding,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme   = Theme.of(context).textTheme;
    final padding     = contentPadding ??
        const EdgeInsets.symmetric(
          horizontal: AppDimensions.inputPaddingH,
          vertical:   AppDimensions.segmentPaddingV,
        );

    Widget content = Padding(
      padding: padding,
      child: Row(
        children: [
          if (leading != null) ...[leading!, const SizedBox(width: _Dims.leadingGap)],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
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
          if (trailing != null) ...[const SizedBox(width: _Dims.leadingGap), trailing!],
        ],
      ),
    );

    if (onTap == null) return content;

    return InkWell(
      onTap: onTap,
      splashColor: colorScheme.primary.withValues(alpha: AppDimensions.splashAlpha),
      highlightColor: colorScheme.primary.withValues(alpha: AppDimensions.highlightAlpha),
      child: content,
    );
  }
}
