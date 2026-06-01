import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../l10n/app_localizations.dart';

abstract final class _Dims {
  static const double iconSize        = 22.0;
  static const double greetingGap     = 2.0;
  static const double avatarIconSize  = 20.0;
}

// Brand wordmark is always Latin regardless of locale — same as OkCredit/PhonePe.
const String _kBrandName = 'KhataPro';

String _greeting(AppLocalizations l10n) {
  final hour = DateTime.now().hour;
  if (hour < 12) return l10n.appBarGreetingMorning;
  if (hour < 17) return l10n.appBarGreetingAfternoon;
  return l10n.appBarGreetingEvening;
}

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key, required this.foregroundColor});

  /// Color applied to all text, icons, and avatar in this header.
  /// Pass cs.onSurface for a light surface, Colors.white for the dark hero band.
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs   = Theme.of(context).colorScheme;
    final tt   = Theme.of(context).textTheme;

    final subtleColor = foregroundColor.withValues(alpha: AppDimensions.subtleLabelAlpha);

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _greeting(l10n),
                style: tt.labelMedium?.copyWith(color: subtleColor),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const SizedBox(height: _Dims.greetingGap),
              Text(
                _kBrandName,
                style: tt.titleLarge?.copyWith(
                  color: foregroundColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications_outlined,
            size: _Dims.iconSize,
            color: foregroundColor,
          ),
          tooltip: l10n.appBarNotificationsTooltip,
        ),
        CircleAvatar(
          radius: AppDimensions.avatarSize / 2,
          backgroundColor: cs.primaryContainer.withValues(
            alpha: AppDimensions.badgeGlassAlpha * 2,
          ),
          child: Icon(
            Icons.person_rounded,
            size: _Dims.avatarIconSize,
            color: foregroundColor,
          ),
        ),
      ],
    );
  }
}
