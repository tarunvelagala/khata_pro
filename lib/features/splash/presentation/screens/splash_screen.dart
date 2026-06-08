import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';

// ── Layout constants ───────────────────────────────────────────────────────────
abstract final class _Dims {
  static const double tileSize        = 173.0;  // Android splash icon canvas = 288dp; mark = 360/1024*288 = 101dp; 598/1024*173 = 101dp
  static const double wordmarkSize    = 24.0;
  static const double wordmarkBottom  = 56.0;
}

// ── Animation timing — GPay style ─────────────────────────────────────────────
// Phase A (0–300ms):  tile settles from 0.85 → 1.0, ease-out spring
//   Starting near full size matches native splash's static icon → seamless handoff
// Phase B (300–800ms): wordmark fades in, hold
// Navigate immediately after (no fade-out; app UI appears on top)
abstract final class _T {
  static const int animMs  = 300;
  static const int holdMs  = 500;
  static const int totalMs = animMs + holdMs; // 800 ms

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
  late final Animation<double> _scale;
  late final Animation<double> _wordmarkOpacity;

  @override
  void initState() {
    super.initState();

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: _T.totalMs),
    );

    _scale = Tween<double>(begin: _T.scaleFrom, end: _T.scaleTo).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0, _T.animMs / _T.totalMs, curve: Curves.easeOutBack),
      ),
    );

    _wordmarkOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: Interval(_T.animMs / _T.totalMs, (_T.animMs + 200) / _T.totalMs, curve: Curves.easeOut),
      ),
    );

    _ctrl.addStatusListener((status) {
      if (status == AnimationStatus.completed) _navigate();
    });

    // Start immediately — no postFrameCallback delay.
    // First painted frame is already at scaleFrom (0.85), matching the native
    // splash icon size so the handoff is seamless with no size jump.
    if (WidgetsBinding.instance.platformDispatcher.accessibilityFeatures.disableAnimations) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _navigate());
    } else {
      _ctrl.forward();
    }
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
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: Stack(
        children: [
          // ── Centered icon tile ─────────────────────────────────────────
          Center(
            child: AnimatedBuilder(
              animation: _scale,
              builder: (context, child) => Transform.scale(
                scale: _scale.value,
                child: const _IconTile(),
              ),
            ),
          ),

          // ── Bottom wordmark ────────────────────────────────────────────
          Positioned(
            bottom: _Dims.wordmarkBottom,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _wordmarkOpacity,
              builder: (context, child) => Opacity(
                opacity: _wordmarkOpacity.value,
                child: Text(
                  'KhataPro',
                  textAlign: TextAlign.center,
                  style: tt.titleMedium?.copyWith(
                    fontSize: _Dims.wordmarkSize,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Icon tile: pill mark directly on background, no tile or shadow ────────────

class _IconTile extends StatelessWidget {
  const _IconTile();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox.square(
      dimension: _Dims.tileSize,
      child: CustomPaint(painter: _MarkPainter(isDark: isDark)),
    );
  }
}

// ── Mark painter — theme-aware pill colors ────────────────────────────────────

class _MarkPainter extends CustomPainter {
  const _MarkPainter({required this.isDark});

  final bool isDark;

  static const double _ref   = 1024;
  static const double _colW  = 174;
  static const double _rx    = 87;
  static const double _pad   = 213;

  static const double _bx    = _pad;
  static const double _bph   = 182;
  static const double _bpg   = 26;
  static const double _bp1y  = _pad;
  static const double _bp2y  = _pad + _bph + _bpg;
  static const double _bp3y  = _pad + 2 * (_bph + _bpg);

  static const double _gx    = _pad + _colW + 39;
  static const double _rx2   = _pad + 2 * (_colW + 39);
  static const double _tallY = _pad;
  static const double _tallH = 598;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / _ref;
    canvas.scale(s, s);

    final blue  = isDark ? AppColors.darkPrimary   : AppColors.primary;
    final green = isDark ? AppColors.darkSecondary  : AppColors.secondary;
    final red   = isDark ? AppColors.darkTertiary   : AppColors.tertiary;

    void pill(double x, double y, double w, double h, Color c) =>
        canvas.drawRRect(
          RRect.fromRectXY(Rect.fromLTWH(x, y, w, h), _rx, _rx),
          Paint()..color = c,
        );

    pill(_bx,   _bp1y,  _colW, _bph,   blue);
    pill(_bx,   _bp2y,  _colW, _bph,   blue);
    pill(_bx,   _bp3y,  _colW, _bph,   blue);
    pill(_gx,   _tallY, _colW, _tallH, green);
    pill(_rx2,  _tallY, _colW, _tallH, red);
  }

  @override
  bool shouldRepaint(_MarkPainter old) => old.isDark != isDark;
}
