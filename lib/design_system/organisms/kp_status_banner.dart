import 'package:flutter/material.dart';

import '../../core/constants/app_dimensions.dart';
import '../../core/widgets/animated_banner.dart';

abstract final class _Dims {
  static const double bannerPaddingH = 16.0;
  static const double bannerPaddingV = 10.0;
  static const double bannerIconGap  = 8.0;
}

/// Merged status banner covering offline, unsynced, and guest states.
///
/// Priority: offline > unsynced > guest. Only the highest-priority active
/// state is shown at a time.
///
/// **No providers** — all state flows in as constructor parameters. Wire
/// in the screen/shell layer via Riverpod watch calls.
///
/// ```dart
/// KpStatusBanner(
///   isOffline:    ref.watch(connectivityProvider).isOffline,
///   isGuest:      !ref.watch(authProvider).valueOrNull.isSignedIn,
///   hasUnsynced:  ref.watch(syncStatusProvider).hasPending,
///   unsyncedCount: ref.watch(syncStatusProvider).pendingCount,
///   onSignIn: () => context.push('/auth/sign-in'),
/// )
/// ```
class KpStatusBanner extends StatelessWidget {
  const KpStatusBanner({
    super.key,
    required this.isOffline,
    required this.isGuest,
    required this.hasUnsynced,
    this.unsyncedCount = 0,
    this.onSignIn,
    this.onDismissGuest,
  });

  final bool isOffline;
  final bool isGuest;
  final bool hasUnsynced;
  final int unsyncedCount;
  final VoidCallback? onSignIn;
  final VoidCallback? onDismissGuest;

  @override
  Widget build(BuildContext context) {
    // Offline takes highest priority; show nothing if all clear.
    if (isOffline) {
      return AnimatedBanner(
        visible: true,
        valueKey: const ValueKey('offline'),
        child: _BannerRow(
          icon: Icons.wifi_off_rounded,
          message: _offlineMessage(context),
          background: Theme.of(context).colorScheme.errorContainer,
          foreground: Theme.of(context).colorScheme.onErrorContainer,
        ),
      );
    }

    if (hasUnsynced) {
      return AnimatedBanner(
        visible: true,
        valueKey: const ValueKey('unsynced'),
        child: _BannerRow(
          icon: Icons.cloud_upload_outlined,
          message: _unsyncedMessage(context),
          background: Theme.of(context).colorScheme.tertiaryContainer,
          foreground: Theme.of(context).colorScheme.onTertiaryContainer,
        ),
      );
    }

    if (isGuest) {
      return AnimatedBanner(
        visible: true,
        valueKey: const ValueKey('guest'),
        child: _GuestBannerRow(
          onSignIn: onSignIn,
          onDismiss: onDismissGuest,
        ),
      );
    }

    return const AnimatedBanner(visible: false, child: SizedBox.shrink());
  }

  String _offlineMessage(BuildContext context) {
    // Fallback string — screens using this widget supply their own l10n keys.
    return 'No internet connection';
  }

  String _unsyncedMessage(BuildContext context) {
    if (unsyncedCount > 0) return '$unsyncedCount changes pending sync';
    return 'Changes pending sync';
  }
}

class _BannerRow extends StatelessWidget {
  const _BannerRow({
    required this.icon,
    required this.message,
    required this.background,
    required this.foreground,
  });

  final IconData icon;
  final String message;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      color: background,
      padding: const EdgeInsets.symmetric(
        horizontal: _Dims.bannerPaddingH,
        vertical:   _Dims.bannerPaddingV,
      ),
      child: Row(
        children: [
          Icon(icon, size: AppDimensions.iconSizeSmall, color: foreground),
          const SizedBox(width: _Dims.bannerIconGap),
          Expanded(
            child: Text(
              message,
              style: textTheme.labelMedium?.copyWith(color: foreground),
            ),
          ),
        ],
      ),
    );
  }
}

class _GuestBannerRow extends StatelessWidget {
  const _GuestBannerRow({this.onSignIn, this.onDismiss});

  final VoidCallback? onSignIn;
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme   = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      color: colorScheme.primaryContainer,
      padding: const EdgeInsets.symmetric(
        horizontal: _Dims.bannerPaddingH,
        vertical:   _Dims.bannerPaddingV,
      ),
      child: Row(
        children: [
          Icon(Icons.cloud_outlined, size: AppDimensions.iconSizeSmall, color: colorScheme.onPrimaryContainer),
          const SizedBox(width: _Dims.bannerIconGap),
          Expanded(
            child: Text(
              'Sign in to back up your data',
              style: textTheme.labelMedium?.copyWith(color: colorScheme.onPrimaryContainer),
            ),
          ),
          if (onSignIn != null)
            TextButton(
              onPressed: onSignIn,
              style: TextButton.styleFrom(
                foregroundColor: colorScheme.primary,
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text('Sign in'),
            ),
          if (onDismiss != null)
            IconButton(
              icon: Icon(Icons.close_rounded, size: AppDimensions.iconSizeSmall),
              color: colorScheme.onPrimaryContainer,
              onPressed: onDismiss,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
        ],
      ),
    );
  }
}
