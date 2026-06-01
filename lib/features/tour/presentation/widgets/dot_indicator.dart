import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';

abstract final class _Dims {
  static const double activeWidth    = 24.0;
  static const double dotHeight      = 8.0;
  static const double inactiveWidth  = 8.0;
  static const double dotRadius      = 4.0;
  static const double gap            = 6.0;
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    required this.currentPage,
    required this.count,
  });

  final int currentPage;
  final int count;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (i) {
        final isActive = i == currentPage;
        final width  = isActive ? _Dims.activeWidth : _Dims.inactiveWidth;
        final color  = isActive ? cs.primary : cs.outlineVariant;
        final radius = BorderRadius.circular(_Dims.dotRadius);

        return Padding(
          padding: EdgeInsets.only(right: i < count - 1 ? _Dims.gap : 0),
          child: reduceMotion
              ? _Dot(width: width, color: color, radius: radius)
              : AnimatedContainer(
                  duration: AppDimensions.animShort,
                  curve: Curves.easeInOut,
                  width: width,
                  height: _Dims.dotHeight,
                  decoration: BoxDecoration(color: color, borderRadius: radius),
                ),
        );
      }),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({
    required this.width,
    required this.color,
    required this.radius,
  });

  final double width;
  final Color color;
  final BorderRadius radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: _Dims.dotHeight,
      child: DecoratedBox(
        decoration: BoxDecoration(color: color, borderRadius: radius),
      ),
    );
  }
}
