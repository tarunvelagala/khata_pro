import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';

abstract final class _Dims {
  static const double buttonSize    = 56.0;
  static const double tileWidth     = 72.0;
  static const double iconSize      = 24.0;
  static const double labelGap      = 8.0;
  // ContinuousRectangleBorder radius for squircle — ~40% of buttonSize
  // matches the GPay icon container corner curve.
  static const double squircleRadius = 22.0;
}

class QuickActionsRow extends StatelessWidget {
  const QuickActionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final actions = [
      (icon: Icons.person_add_rounded, label: l10n.quickActionAddCustomer),
      (icon: Icons.receipt_long_rounded, label: l10n.quickActionGenerateBill),
      (
        icon: Icons.notifications_active_rounded,
        label: l10n.quickActionSendReminder,
      ),
      (icon: Icons.payments_rounded, label: l10n.quickActionRecordPayment),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: actions.map((a) {
        return SizedBox(
          width: _Dims.tileWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: _Dims.buttonSize,
                height: _Dims.buttonSize,
                decoration: BoxDecoration(
                  color: cs.primaryContainer,
                  borderRadius: BorderRadius.circular(_Dims.squircleRadius),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowCard,
                      blurRadius: AppDimensions.shadowBlurCard,
                      offset: const Offset(0, AppDimensions.shadowOffsetCard),
                    ),
                  ],
                ),
                child: Material(
                  color: cs.primaryContainer,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(_Dims.squircleRadius),
                  ),
                  child: InkWell(
                    onTap: () {},
                    customBorder: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(_Dims.squircleRadius),
                    ),
                    child: Icon(
                      a.icon,
                      size: _Dims.iconSize,
                      color: cs.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: _Dims.labelGap),
              Text(
                a.label,
                style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
