import 'package:flutter/material.dart';

import '../../core/constants/app_dimensions.dart';

/// Compact loading indicator sized for placement inside a [FilledButton].
///
/// Color defaults to [ColorScheme.onPrimary] so it is visible on the filled
/// button background without additional styling.
class KpSpinner extends StatelessWidget {
  const KpSpinner({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colorScheme   = Theme.of(context).colorScheme;
    final resolvedColor = color ?? colorScheme.onPrimary;

    return SizedBox.square(
      dimension: AppDimensions.buttonSpinnerSize,
      child: CircularProgressIndicator(
        strokeWidth: AppDimensions.buttonSpinnerStroke,
        color: resolvedColor,
      ),
    );
  }
}
