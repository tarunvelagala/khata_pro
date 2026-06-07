import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/presentation/providers/sync_status_provider.dart';
import '../constants/app_dimensions.dart';
import '../../l10n/app_localizations.dart';
import 'animated_banner.dart';

/// A banner shown at the top of the home screen when there are local writes
/// that haven't been synced to Firestore yet.
class UnsyncedBanner extends ConsumerWidget {
  const UnsyncedBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(syncStatusProvider).asData?.value;
    final hasPending = status?.hasPending ?? false;

    return AnimatedBanner(
      visible:  hasPending,
      valueKey: const ValueKey('unsynced'),
      child: _BannerContent(pendingCount: status?.pendingCount ?? 0),
    );
  }
}

class _BannerContent extends StatelessWidget {
  const _BannerContent({required this.pendingCount});

  final int pendingCount;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs   = Theme.of(context).colorScheme;
    final tt   = Theme.of(context).textTheme;

    return Material(
      color: cs.tertiaryContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.buttonPaddingH,
          vertical:   AppDimensions.buttonStackGap,
        ),
        child: Row(
          children: [
            Icon(
              Icons.cloud_off_rounded,
              size:  AppDimensions.iconSizeSmall,
              color: cs.onTertiaryContainer,
            ),
            const SizedBox(width: AppDimensions.buttonStackGap),
            Expanded(
              child: Text(
                l10n.syncUnsyncedBanner,
                style: tt.labelSmall?.copyWith(color: cs.onTertiaryContainer),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

