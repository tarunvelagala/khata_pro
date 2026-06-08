import 'package:flutter/material.dart';

import '../../core/constants/app_dimensions.dart';
import '../../core/theme/kp_theme_extension.dart';

/// Full-bleed gradient header band used by the dashboard and any screen
/// that needs a dark hero section.
///
/// The gradient colors resolve through [KpColorsExtension] so they adapt to
/// light/dark mode and future brand themes without widget changes.
///
/// ```dart
/// KpHeroBand(child: KpBalanceCard(...))
/// ```
class KpHeroBand extends StatelessWidget {
  const KpHeroBand({
    super.key,
    required this.child,
    this.padding,
  });

  final Widget child;

  /// Padding inside the gradient container. Defaults to hero band token values.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final kpColorScheme = Theme.of(context).kpColorScheme;
    final safePadding   = MediaQuery.paddingOf(context);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end:   Alignment.bottomCenter,
          colors: [kpColorScheme.heroGradientStart, kpColorScheme.heroGradientEnd],
        ),
      ),
      padding: padding ??
          EdgeInsets.only(
            top:    AppDimensions.heroContentPaddingTop + safePadding.top,
            bottom: AppDimensions.heroContentPaddingBottom,
          ),
      child: child,
    );
  }
}
