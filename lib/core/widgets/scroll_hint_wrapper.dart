import 'package:flutter/material.dart';

import '../constants/app_dimensions.dart';

abstract final class _Dims {
  static const double hintHeight   = 48.0;
  static const double hintIconSize = 18.0;
  static const double hintTextGap  = 4.0;
}

/// Wraps a scrollable child and overlays a fade + "scroll for more" hint at the
/// bottom. The hint is shown on first render and dismissed once the user scrolls
/// past [dismissThreshold] pixels. Only shown when content actually overflows
/// (detected via [ScrollMetrics.maxScrollExtent] > 0).
class ScrollHintWrapper extends StatefulWidget {
  const ScrollHintWrapper({
    super.key,
    required this.child,
    required this.hintLabel,
    this.dismissThreshold = 8.0,
  });

  final Widget child;
  final String hintLabel;
  final double dismissThreshold;

  @override
  State<ScrollHintWrapper> createState() => _ScrollHintWrapperState();
}

class _ScrollHintWrapperState extends State<ScrollHintWrapper> {
  bool _visible    = true;
  bool _overflows  = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Stack(
      children: [
        NotificationListener<ScrollNotification>(
          onNotification: (n) {
            final overflows = n.metrics.maxScrollExtent > 0;
            final scrolled  = n.metrics.pixels > widget.dismissThreshold;
            if (overflows != _overflows || (scrolled && _visible)) {
              setState(() {
                _overflows = overflows;
                if (scrolled) _visible = false;
              });
            }
            return false;
          },
          child: widget.child,
        ),

        // ── Fade + label ───────────────────────────────────────────────
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: AnimatedOpacity(
            opacity: (_visible && _overflows) ? 1.0 : 0.0,
            duration: AppDimensions.animMedium,
            child: IgnorePointer(
              child: Container(
                height: _Dims.hintHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      cs.surface.withValues(alpha: 0),
                      cs.surface,
                    ],
                  ),
                ),
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(
                  bottom: AppDimensions.buttonStackGap,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: _Dims.hintIconSize,
                      color: cs.onSurfaceVariant,
                    ),
                    const SizedBox(width: _Dims.hintTextGap),
                    Text(
                      widget.hintLabel,
                      style: tt.labelSmall?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
