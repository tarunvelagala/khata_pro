import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';

// ── File-private layout constants ─────────────────────────────────────────────
abstract final class _Dims {
  static const double markSize = 160.0;
}

// ── Animation timing ──────────────────────────────────────────────────────────
// Three-phase controller:
//   Phase A (scale-in):  0 ms – 200 ms   mark scales 0.85 → 1.0
//   Phase B (hold):    200 ms – 800 ms   fully visible, no change
//   Phase C (fade-out): 800 ms – 1100 ms  mark fades to 0
// Flutter starts here after the native splash (which showed the static mark).
abstract final class _T {
  static const int scaleMs = 200;
  static const int holdMs  = 600;
  static const int fadeMs  = 300;
  static const int totalMs = scaleMs + holdMs + fadeMs; // 1100 ms

  static const double scaleEnd  = scaleMs / totalMs; // ≈ 0.182
  static const double fadeStart = (scaleMs + holdMs) / totalMs; // ≈ 0.727
  static const double fadeEnd   = 1.0;

  static const double scaleFrom = 0.85;
  static const double scaleTo   = 1.0;
}

// ── SplashScreen ──────────────────────────────────────────────────────────────

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _markOpacity;
  late final Animation<double> _markScale;

  @override
  void initState() {
    super.initState();

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: _T.totalMs),
    );

    _markOpacity = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(_T.fadeStart, _T.fadeEnd, curve: Curves.easeIn),
      ),
    );

    _markScale = Tween<double>(begin: _T.scaleFrom, end: _T.scaleTo).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0, _T.scaleEnd, curve: Curves.easeOut),
      ),
    );

    _ctrl.addStatusListener((status) {
      if (status == AnimationStatus.completed) _navigate();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (MediaQuery.of(context).disableAnimations) {
        _navigate();
        return;
      }
      _ctrl.forward();
    });
  }

  void _navigate() {
    if (!mounted) return;
    try {
      context.go('/redirect');
    } catch (e) {
      log('SplashScreen navigate error: $e', name: 'SplashScreen');
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: Center(
        child: AnimatedBuilder(
          animation: _ctrl,
          builder: (context, _) => Opacity(
            opacity: _markOpacity.value,
            child: Transform.scale(
              scale: _markScale.value,
              child: SizedBox.square(
                dimension: _Dims.markSize,
                child: CustomPaint(painter: _KhataProMarkPainter(isDark: isDark)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── CustomPainter ─────────────────────────────────────────────────────────────

class _KhataProMarkPainter extends CustomPainter {
  const _KhataProMarkPainter({required this.isDark});

  final bool isDark;

  // Geometry from splash_fg.svg (1024×1024 canvas, no safe-zone transform).
  // Normalised to a 1024×1024 reference — scaled to actual canvas in paint().
  static const double _ref = 1024;

  static const Rect _leftBar = Rect.fromLTWH(180, 174, 160, 676);
  static const Rect _rightBar = Rect.fromLTWH(380, 174, 160, 676);
  static const Rect _topBar = Rect.fromLTWH(580, 212, 264, 120);
  static const Rect _midBar = Rect.fromLTWH(580, 452, 264, 120);
  static const Rect _botBar = Rect.fromLTWH(580, 692, 264, 120);
  static const double _rx = 16;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / _ref;
    canvas.scale(s, s);

    final Color colorLeft = isDark
        ? AppColors.darkSecondary
        : AppColors.secondary;
    final Color colorRight = isDark
        ? AppColors.darkTertiary
        : AppColors.tertiary;
    final Color colorH = isDark ? AppColors.darkPrimary : AppColors.primary;

    final rr = const Radius.circular(_rx);

    void drawBar(Rect r, Color color) => canvas.drawRRect(
      RRect.fromRectAndRadius(r, rr),
      Paint()..color = color,
    );

    drawBar(_leftBar, colorLeft);
    drawBar(_rightBar, colorRight);
    drawBar(_topBar, colorH);
    drawBar(_midBar, colorH);
    drawBar(_botBar, colorH);
  }

  @override
  bool shouldRepaint(_KhataProMarkPainter old) => old.isDark != isDark;
}
