import 'package:flutter/material.dart';

import '../../core/constants/app_dimensions.dart';

/// Wraps any input widget with a static label above it — GPay / PhonePe style.
///
/// Use instead of [InputDecoration.labelText] so the label never floats or
/// competes with regional-script hint text inside the field.
class KpLabeledField extends StatelessWidget {
  const KpLabeledField({
    super.key,
    required this.label,
    required this.child,
    this.gap = AppDimensions.labelFieldGap,
  });

  final String label;
  final Widget child;

  /// Vertical space between the label text and the field widget.
  final double gap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme   = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: gap),
        child,
      ],
    );
  }
}
