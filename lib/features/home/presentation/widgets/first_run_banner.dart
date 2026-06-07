import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/prefs_keys.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/shell_nav_provider.dart';

abstract final class _Dims {
  static const double cardRadius  = 16.0;
  static const double cardPadH    = 16.0;
  static const double cardPadV    = 14.0;
  static const double chipSpacing = 8.0;
  static const double sectionGap  = 10.0;
  static const double titleGap    = 4.0;
}

final _firstRunBannerProvider = AsyncNotifierProvider<_FirstRunNotifier, bool>(() {
  return _FirstRunNotifier();
});

class _FirstRunNotifier extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PrefsKeys.firstRunBannerDismissed) ?? false;
  }

  Future<void> dismiss() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PrefsKeys.firstRunBannerDismissed, true);
    state = const AsyncData(true);
  }
}

class FirstRunBanner extends ConsumerWidget {
  const FirstRunBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dismissed = ref.watch(_firstRunBannerProvider).asData?.value ?? false;
    if (dismissed) return const SizedBox.shrink();

    final l10n = AppLocalizations.of(context)!;
    final cs   = Theme.of(context).colorScheme;
    final tt   = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.buttonPaddingH,
        AppDimensions.buttonPaddingH,
        AppDimensions.buttonPaddingH,
        0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: cs.primaryContainer,
          borderRadius: BorderRadius.circular(_Dims.cardRadius),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: _Dims.cardPadH,
          vertical: _Dims.cardPadV,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.firstRunTitle,
                        style: tt.titleSmall?.copyWith(
                          color: cs.onPrimaryContainer,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: _Dims.titleGap),
                      Text(
                        l10n.firstRunBody,
                        style: tt.bodySmall?.copyWith(
                          color: cs.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () =>
                      ref.read(_firstRunBannerProvider.notifier).dismiss(),
                  icon: Icon(Icons.close_rounded,
                      size: AppDimensions.iconSizeSmall,
                      color: cs.onPrimaryContainer),
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: _Dims.sectionGap),
            Wrap(
              spacing: _Dims.chipSpacing,
              runSpacing: _Dims.chipSpacing,
              children: [
                _StepChip(
                  label: l10n.firstRunStep1,
                  icon: Icons.person_add_rounded,
                  onTap: () => context.push('/customers/add'),
                ),
                _StepChip(
                  label: l10n.firstRunStep2,
                  icon: Icons.receipt_long_rounded,
                  onTap: () =>
                      ref.read(shellNavProvider.notifier).select(1),
                ),
                _StepChip(
                  label: l10n.firstRunStep3,
                  icon: Icons.notifications_rounded,
                  onTap: () =>
                      ref.read(shellNavProvider.notifier).select(1),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StepChip extends StatelessWidget {
  const _StepChip({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return ActionChip(
      avatar: Icon(icon, size: 14, color: cs.primary),
      label: Text(label,
          style: tt.labelSmall?.copyWith(color: cs.primary)),
      backgroundColor: cs.surface,
      side: BorderSide(color: cs.outline.withValues(alpha: 0.4)),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      onPressed: onTap,
    );
  }
}
