import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../providers/connectivity_provider.dart';
import 'animated_banner.dart';

abstract final class _Dims {
  static const double bannerV    = 6.0;
  static const double bannerH    = 12.0;
  static const double iconSize   = 16.0;
  static const double iconGap    = 6.0;
}

class OfflineBanner extends ConsumerWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOnline = ref.watch(connectivityProvider).asData?.value ?? true;
    final cs       = Theme.of(context).colorScheme;
    final tt       = Theme.of(context).textTheme;

    return AnimatedBanner(
      visible:  !isOnline,
      valueKey: const ValueKey('offline'),
      child: ColoredBox(
        color: cs.errorContainer,
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: _Dims.bannerH,
              vertical:   _Dims.bannerV,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.wifi_off_rounded,
                  size:  _Dims.iconSize,
                  color: cs.onErrorContainer,
                ),
                const SizedBox(width: _Dims.iconGap),
                Text(
                  AppLocalizations.of(context)!.offlineBar,
                  style: tt.labelSmall?.copyWith(
                    color:      cs.onErrorContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

