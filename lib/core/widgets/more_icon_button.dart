import 'package:flutter/material.dart';

import '../constants/app_dimensions.dart';

/// Trailing ••• icon used on list tiles to open a context action sheet.
class MoreIconButton extends StatelessWidget {
  const MoreIconButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Icon(
        Icons.more_vert_rounded,
        size: AppDimensions.iconSizeSmall,
        color: cs.onSurfaceVariant,
      ),
    );
  }
}
