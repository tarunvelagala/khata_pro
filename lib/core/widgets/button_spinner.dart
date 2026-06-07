import 'package:flutter/material.dart';

import '../constants/app_dimensions.dart';

/// Compact [CircularProgressIndicator] sized to sit inside a [FilledButton].
class ButtonSpinner extends StatelessWidget {
  const ButtonSpinner({super.key});

  @override
  Widget build(BuildContext context) => SizedBox.square(
        dimension: AppDimensions.buttonSpinnerSize,
        child: CircularProgressIndicator(
          strokeWidth: AppDimensions.buttonSpinnerStroke,
        ),
      );
}
