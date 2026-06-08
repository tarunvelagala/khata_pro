import 'package:flutter/material.dart';

/// Connectivity / sync state represented visually.
enum KpStatusDotState {
  /// Connected and in sync — secondary green.
  online,

  /// Awaiting response or sync in progress — amber.
  pending,

  /// No connection or service unavailable — onSurfaceVariant.
  offline,
}

/// 8dp circular status indicator using semantic colors.
class KpStatusDot extends StatelessWidget {
  const KpStatusDot({super.key, required this.state});

  final KpStatusDotState state;

  // Named constants to avoid magic numbers in layout.
  static const double _diameter = 8.0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final Color dotColor = switch (state) {
      KpStatusDotState.online  => colorScheme.secondary,
      KpStatusDotState.pending => const Color(0xFFFFB300), // amber — no M3 slot
      KpStatusDotState.offline => colorScheme.onSurfaceVariant,
    };

    return Container(
      width: _diameter,
      height: _diameter,
      decoration: BoxDecoration(
        color: dotColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
