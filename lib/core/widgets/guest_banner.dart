import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/providers/auth_provider.dart';
import '../constants/app_dimensions.dart';
import '../../l10n/app_localizations.dart';

/// Session-scoped dismissed state — resets on every app launch.
final _guestBannerDismissedProvider =
    NotifierProvider<_DismissedNotifier, bool>(_DismissedNotifier.new);

class _DismissedNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void dismiss() => state = true;
}

/// Inline card shown in the dashboard scroll content when the user is not
/// signed in. Scrolls with the page — GPay style.
class GuestBanner extends ConsumerWidget {
  const GuestBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSignedIn = ref.watch(authProvider).value != null;
    final dismissed  = ref.watch(_guestBannerDismissedProvider);

    if (isSignedIn || dismissed) return const SizedBox.shrink();

    final l10n = AppLocalizations.of(context)!;
    final cs   = Theme.of(context).colorScheme;
    final tt   = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.buttonPaddingH,
        AppDimensions.buttonStackGap,
        AppDimensions.buttonPaddingH,
        0,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: cs.primaryContainer,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.inputPaddingH,
            vertical: AppDimensions.inputPaddingV / 2,
          ),
          child: Row(
            children: [
              Icon(
                Icons.cloud_off_rounded,
                size:  AppDimensions.iconSizeMedium,
                color: cs.onPrimaryContainer,
              ),
              const SizedBox(width: AppDimensions.inputPaddingH),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.guestBannerBody,
                      style: tt.bodySmall?.copyWith(
                        color: cs.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 2),
                    GestureDetector(
                      onTap: () => context.push('/auth/sign-in', extra: false),
                      child: Text(
                        l10n.guestBannerCta,
                        style: tt.labelSmall?.copyWith(
                          color: cs.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () =>
                    ref.read(_guestBannerDismissedProvider.notifier).dismiss(),
                icon: Icon(
                  Icons.close,
                  size:  AppDimensions.iconSizeSmall,
                  color: cs.onPrimaryContainer,
                ),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
