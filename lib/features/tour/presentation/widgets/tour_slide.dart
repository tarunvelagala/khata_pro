import 'package:flutter/material.dart';

abstract final class _Dims {
  static const double horizontalPadding = 32.0;
  static const double topPadding        = 32.0;
  static const double maxBodyWidth      = 280.0;
  static const double illustrationGap   = 32.0;
  static const double headlineToBodyGap = 8.0;
}

class TourSlide extends StatelessWidget {
  const TourSlide({
    super.key,
    required this.illustration,
    required this.headline,
    required this.body,
  });

  final Widget illustration;
  final String headline;
  final String body;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: _Dims.horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: _Dims.topPadding),
          illustration,
          const SizedBox(height: _Dims.illustrationGap),
          Text(headline, style: tt.headlineMedium, textAlign: TextAlign.center),
          const SizedBox(height: _Dims.headlineToBodyGap),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: _Dims.maxBodyWidth),
            child: Text(
              body,
              style: tt.bodyLarge?.copyWith(color: cs.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
