import 'package:flutter/material.dart';

import '../constants/app_dimensions.dart';

/// Wraps any input widget with a static label above it — GPay / PhonePe style.
///
/// Use instead of [InputDecoration.labelText] so the label never floats or
/// competes with regional-script hint text inside the field.
class LabeledField extends StatelessWidget {
  const LabeledField({
    super.key,
    required this.label,
    required this.child,
    this.gap = AppDimensions.labelFieldGap,
  });

  final String label;
  final Widget child;

  /// Vertical space between the label and the field. Defaults to
  /// [AppDimensions.labelFieldGap].
  final double gap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: tt.labelMedium?.copyWith(color: cs.onSurfaceVariant),
        ),
        SizedBox(height: gap),
        child,
      ],
    );
  }
}
