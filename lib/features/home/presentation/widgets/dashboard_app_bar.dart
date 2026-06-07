import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../settings/presentation/providers/profile_provider.dart';

abstract final class _Dims {
  static const double greetingGap    = 4.0;
  static const double avatarFontSize = 16.0;
}

const String _kBrandFallback = 'KhataPro';

String _greeting(AppLocalizations l10n) {
  final hour = DateTime.now().hour;
  if (hour < 12) return l10n.appBarGreetingMorning;
  if (hour < 17) return l10n.appBarGreetingAfternoon;
  return l10n.appBarGreetingEvening;
}

class DashboardHeader extends ConsumerWidget {
  const DashboardHeader({super.key, required this.foregroundColor});

  final Color foregroundColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n    = AppLocalizations.of(context)!;
    final cs      = Theme.of(context).colorScheme;
    final tt      = Theme.of(context).textTheme;
    final profile = ref.watch(profileProvider).value;

    final subtleColor = foregroundColor.withValues(alpha: AppDimensions.subtleLabelAlpha);

    final hasProfile = profile != null && profile.name.isNotEmpty;
    final p = hasProfile ? profile : null;

    final headlineText = p != null ? p.name : _kBrandFallback;
    final subtitleText = p != null
        ? (p.shopName?.isNotEmpty == true ? p.shopName! : _greeting(l10n))
        : _greeting(l10n);

    final avatarContent = p != null
        ? Text(
            p.name.characters.first.toUpperCase(),
            style: TextStyle(
              fontSize: _Dims.avatarFontSize,
              fontWeight: FontWeight.w700,
              color: foregroundColor,
            ),
          )
        : Icon(
            Icons.person_rounded,
            size: _Dims.avatarFontSize,
            color: foregroundColor,
          );

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                subtitleText,
                style: tt.bodyMedium?.copyWith(color: subtleColor),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const SizedBox(height: _Dims.greetingGap),
              Text(
                headlineText,
                style: tt.titleLarge?.copyWith(
                  color: foregroundColor,
                  fontWeight: FontWeight.w800,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
        Tooltip(
          message: l10n.profileScreenTitle,
          child: GestureDetector(
            onTap: () => context.push('/profile'),
            child: CircleAvatar(
              radius: AppDimensions.avatarSize / 2,
              backgroundColor: cs.primaryContainer.withValues(
                alpha: AppDimensions.badgeGlassAlpha * 2,
              ),
              child: avatarContent,
            ),
          ),
        ),
      ],
    );
  }
}
