import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';

// ── Layout constants ───────────────────────────────────────────────────────────
abstract final class _Dims {
  static const double tileSize        = 120.0;  // launcher icon tile (dp)
  static const double tileRadius      = 26.0;   // rounded-square corner radius
  static const double wordmarkSize    = 17.0;
  static const double wordmarkBottom  = 56.0;   // distance from screen bottom
}

// ── Animation timing — GPay style ─────────────────────────────────────────────
// Phase A (0–500ms):  tile + wordmark scale from 0.2 → 1.0, ease-out spring
// Phase B (500–800ms): hold
// Navigate immediately after (no fade-out; app UI appears on top)
abstract final class _T {
  static const int animMs  = 500;
  static const int holdMs  = 300;
  static const int totalMs = animMs + holdMs; // 800 ms

  static const double scaleFrom = 0.2;
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
        curve: Interval(0, _T.animMs / _T.totalMs, curve: Curves.easeOut),
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
    final tt = Theme.of(context).textTheme;

    // GPay-style: always dark background regardless of system theme
    const bg = AppColors.darkSurface;
    const wordmarkColor = AppColors.darkOnSurface;

    return Scaffold(
      backgroundColor: bg,
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
                    color: wordmarkColor,
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

// ── Icon tile: rounded square + pill mark ─────────────────────────────────────

class _IconTile extends StatelessWidget {
  const _IconTile();

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: _Dims.tileSize,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.surface,   // #FAF9FD — light tile on dark bg
          borderRadius: BorderRadius.circular(_Dims.tileRadius),
          boxShadow: const [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 24,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: CustomPaint(painter: _MarkPainter()),
        ),
      ),
    );
  }
}

// ── Mark painter — same-color logo for both themes ────────────────────────────

class _MarkPainter extends CustomPainter {
  const _MarkPainter();

  // Reference: icon fg.svg geometry (1024×1024, 102px padding, 820×820 mark).
  // 3 columns, width=238, gap=53, rx=119.
  // Blue pills: h=250, gap=35. Green/Red: h=820, full-height.
  static const double _ref   = 1024;
  static const double _colW  = 238;
  static const double _rx    = 119;
  static const double _pad   = 102;

  // Blue
  static const double _bx    = _pad;
  static const double _bph   = 250;
  static const double _bpg   = 35;
  static const double _bp1y  = _pad;
  static const double _bp2y  = _pad + _bph + _bpg;           // 387
  static const double _bp3y  = _pad + 2 * (_bph + _bpg);     // 672

  // Green / Red
  static const double _gx    = _pad + _colW + 53;            // 393
  static const double _rx2   = _pad + 2 * (_colW + 53);      // 684
  static const double _tallY = _pad;
  static const double _tallH = 820;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / _ref;
    canvas.scale(s, s);

    void pill(double x, double y, double w, double h, Color c) =>
        canvas.drawRRect(
          RRect.fromRectXY(Rect.fromLTWH(x, y, w, h), _rx, _rx),
          Paint()..color = c,
        );

    pill(_bx,   _bp1y,  _colW, _bph,   AppColors.primary);
    pill(_bx,   _bp2y,  _colW, _bph,   AppColors.primary);
    pill(_bx,   _bp3y,  _colW, _bph,   AppColors.primary);
    pill(_gx,   _tallY, _colW, _tallH, AppColors.secondary);
    pill(_rx2,  _tallY, _colW, _tallH, AppColors.tertiary);
  }

  @override
  bool shouldRepaint(_MarkPainter old) => false;
}
