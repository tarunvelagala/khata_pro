import 'package:flutter/material.dart';

import '../../core/constants/app_dimensions.dart';

abstract final class _Dims {
  static const double tileLeadingW  = 40.0;
  static const double tileTextH1    = 14.0;
  static const double tileTextH2    = 12.0;
  static const double tileTextGap   = 6.0;
  static const double cardHeight    = 140.0;
  static const double textLineH     = 14.0;
  static const double textLineGap   = 6.0;
}

/// Shimmer loading placeholder that preserves the spatial structure of
/// the content it replaces.
///
/// Animates between [ColorScheme.surfaceContainerLow] and
/// [ColorScheme.surfaceContainerHighest]. Respects
/// [MediaQuery.disableAnimationsOf] — static when reduce-motion is active.
///
/// Named constructors:
/// - [KpSkeleton.text] — single or multi-line text block
/// - [KpSkeleton.card] — full card rectangle
/// - [KpSkeletonTile] — list tile with leading circle + two text lines
class KpSkeleton extends StatefulWidget {
  const KpSkeleton({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  /// Single-line (or multi-line) text placeholder.
  factory KpSkeleton.text({
    Key? key,
    double width = double.infinity,
    int lines = 1,
  }) => _TextSkeleton(key: key, width: width, lines: lines);

  /// Card-shaped placeholder.
  factory KpSkeleton.card({Key? key, double height = _Dims.cardHeight}) =>
      KpSkeleton(
        key: key,
        width: double.infinity,
        height: height,
        borderRadius: AppDimensions.radiusXLarge,
      );

  final double width;
  final double height;
  final double? borderRadius;

  @override
  State<KpSkeleton> createState() => _KpSkeletonState();
}

class _KpSkeletonState extends State<KpSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final colorScheme  = Theme.of(context).colorScheme;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    _controller = AnimationController(
      vsync: this,
      duration: AppDimensions.animMedium,
    );

    _colorAnimation = ColorTween(
      begin: colorScheme.surfaceContainerLow,
      end:   colorScheme.surfaceContainerHighest,
    ).animate(_controller);

    if (!reduceMotion) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, _) => Container(
        width:  widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: _colorAnimation.value,
          borderRadius: BorderRadius.circular(
            widget.borderRadius ?? AppDimensions.radiusSmall,
          ),
        ),
      ),
    );
  }
}

// ── Named constructor implementations ────────────────────────────────────────

class _TextSkeleton extends KpSkeleton {
  // ignore: prefer_const_constructors_in_immutables
  _TextSkeleton({super.key, required super.width, required this.lines})
      : super(
          height: _Dims.textLineH * lines + _Dims.textLineGap * (lines - 1),
          borderRadius: AppDimensions.radiusSmall,
        );

  final int lines;
}

/// Standard list-tile shimmer placeholder: circle leading + two text lines.
class KpSkeletonTile extends StatelessWidget {
  const KpSkeletonTile({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.inputPaddingH,
          vertical:   AppDimensions.segmentPaddingV,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            KpSkeleton(
              width:  _Dims.tileLeadingW,
              height: _Dims.tileLeadingW,
              borderRadius: AppDimensions.radiusPill,
            ),
            const SizedBox(width: AppDimensions.inputPaddingH),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  KpSkeleton(width: double.infinity, height: _Dims.tileTextH1),
                  const SizedBox(height: _Dims.tileTextGap),
                  KpSkeleton(width: 120, height: _Dims.tileTextH2),
                ],
              ),
            ),
          ],
        ),
      );
}
