import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';

// ── Layout constants ───────────────────────────────────────────────────────────
abstract final class _Dims {
  static const double markSize      = 160.0;
  static const double wordmarkGap   = 20.0;
  static const double wordmarkSize  = 18.0;
}

// ── Animation timing (DESIGN.md § Splash "Opening the Ledger") ────────────────
// Phase A (0–400ms):   mark scales 0.85 → 1.0 ease-out
// Phase B (400–800ms): wordmark fades in (opacity 0 → 1)
// Phase C (800–1200ms): hold
// Phase D (1200–1400ms): settle pulse 1.0 → 1.02 → 1.0, then navigate
abstract final class _T {
  static const int phaseAMs  = 400;
  static const int phaseBMs  = 400;
  static const int phaseCMs  = 400;
  static const int phaseDMs  = 200;
  static const int totalMs   = phaseAMs + phaseBMs + phaseCMs + phaseDMs; // 1400

  static const double _aEnd  = phaseAMs / totalMs;              // 0.286
  static const double _bEnd  = (phaseAMs + phaseBMs) / totalMs; // 0.571

  static const double scaleFrom = 0.85;
  static const double pulsePeak = 1.02;

  static Animatable<double> markScale = TweenSequence([
    TweenSequenceItem(
      tween: Tween(begin: scaleFrom, end: 1.0).chain(CurveTween(curve: Curves.easeOut)),
      weight: phaseAMs.toDouble(),
    ),
    TweenSequenceItem(tween: ConstantTween(1.0), weight: (phaseBMs + phaseCMs).toDouble()),
    TweenSequenceItem(
      tween: TweenSequence([
        TweenSequenceItem(tween: Tween(begin: 1.0, end: pulsePeak), weight: 1),
        TweenSequenceItem(tween: Tween(begin: pulsePeak, end: 1.0), weight: 1),
      ]),
      weight: phaseDMs.toDouble(),
    ),
  ]);

  static const Interval wordmarkInterval = Interval(_aEnd, _bEnd, curve: Curves.easeOut);
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
  late final Animation<double> _markScale;
  late final Animation<double> _wordmarkOpacity;

  @override
  void initState() {
    super.initState();

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: _T.totalMs),
    );

    _markScale = _T.markScale.animate(_ctrl);

    _wordmarkOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _ctrl, curve: _T.wordmarkInterval),
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
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: Center(
        child: AnimatedBuilder(
          animation: _ctrl,
          builder: (context, _) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform.scale(
                scale: _markScale.value,
                child: SizedBox.square(
                  dimension: _Dims.markSize,
                  child: CustomPaint(painter: _KhataProMarkPainter(isDark: isDark)),
                ),
              ),
              const SizedBox(height: _Dims.wordmarkGap),
              Opacity(
                opacity: _wordmarkOpacity.value,
                child: Text(
                  'KhataPro',
                  style: tt.titleMedium?.copyWith(
                    fontSize: _Dims.wordmarkSize,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
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

  // Reference canvas: splash_fg.svg (1024×1024).
  // Geometry: 3-column pill design, mark centered slightly above midpoint.
  // Columns (left=blue×3, center=green, right=red), all equal width 119px,
  // gaps 26.5px, rx=59.5 (= half-width → perfect stadium pill).
  static const double _ref     = 1024;
  static const double _colW    = 119;
  // Column gap kept as geometry reference (not used in paint directly)
  // ignore: unused_field
  static const double _colGap  = 26.5; // kept for geometry documentation
  static const double _rx      = 59.5;

  // Blue pill positions (y, height)
  static const double _bx      = 307;
  static const double _bp1y    = 277;
  static const double _bp2y    = 419.5;
  static const double _bp3y    = 562;
  static const double _pillH   = 125;

  // Green / Red column
  static const double _gx      = 452.5;
  static const double _redX    = 598;
  static const double _tallY   = 277;
  static const double _tallH   = 410;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / _ref;
    canvas.scale(s, s);

    final Color blue  = isDark ? AppColors.darkPrimary   : AppColors.primary;
    final Color green = isDark ? AppColors.darkSecondary  : AppColors.secondary;
    final Color red   = isDark ? AppColors.darkTertiary   : AppColors.tertiary;

    void pill(double x, double y, double w, double h, Color c) =>
        canvas.drawRRect(
          RRect.fromRectXY(Rect.fromLTWH(x, y, w, h), _rx, _rx),
          Paint()..color = c,
        );

    // Blue stacked pills
    pill(_bx, _bp1y, _colW, _pillH, blue);
    pill(_bx, _bp2y, _colW, _pillH, blue);
    pill(_bx, _bp3y, _colW, _pillH, blue);
    // Green full-height pill
    pill(_gx, _tallY, _colW, _tallH, green);
    // Red full-height pill
    pill(_redX, _tallY, _colW, _tallH, red);
  }

  @override
  bool shouldRepaint(_KhataProMarkPainter old) => old.isDark != isDark;
}
