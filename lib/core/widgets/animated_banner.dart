import 'package:flutter/material.dart';

/// Shared animated show/hide wrapper used by status banners.
///
/// Wraps [child] in an [AnimatedSwitcher] + [SizeTransition] so banners
/// slide in and out smoothly when [visible] changes.
class AnimatedBanner extends StatelessWidget {
  const AnimatedBanner({
    super.key,
    required this.visible,
    required this.child,
    this.valueKey,
  });

  final bool visible;
  final Widget child;

  /// Stable key for [AnimatedSwitcher]'s diff logic — pass a unique
  /// [ValueKey] so the switcher can distinguish this banner from SizedBox.shrink().
  final Key? valueKey;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (c, animation) => SizeTransition(
        sizeFactor: animation,
        child: c,
      ),
      child: visible
          ? KeyedSubtree(key: valueKey, child: child)
          : const SizedBox.shrink(),
    );
  }
}
