import 'package:flutter/material.dart';

import '../../core/constants/app_dimensions.dart';

/// Thin horizontal rule using design token colors and thickness.
class KpDivider extends StatelessWidget {
  const KpDivider({super.key, this.indent, this.endIndent});

  final double? indent;
  final double? endIndent;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Divider(
      color: colorScheme.outlineVariant,
      thickness: AppDimensions.dividerThickness,
      height: AppDimensions.dividerSpace,
      indent: indent,
      endIndent: endIndent,
    );
  }
}
