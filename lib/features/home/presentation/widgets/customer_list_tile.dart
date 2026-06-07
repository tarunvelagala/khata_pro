import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/widgets/amount_text.dart';
import '../../../../core/widgets/app_avatar.dart';
import '../../../../core/widgets/more_icon_button.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/models/customer.dart';

abstract final class _Dims {
  static const double tileMinHeight = 64.0;
}

class CustomerListTile extends StatelessWidget {
  const CustomerListTile({
    super.key,
    required this.customer,
    required this.isMasked,
    required this.onTap,
    this.onMoreTap,
  });

  final Customer customer;
  final bool isMasked;
  final VoidCallback onTap;
  final VoidCallback? onMoreTap;

  String? get _subtitle {
    if (customer.shopName != null) return customer.shopName;
    if (customer.phone != null) {
      final p = customer.phone!;
      return p.length >= 4 ? '••••${p.substring(p.length - 4)}' : p;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final cs     = Theme.of(context).colorScheme;
    final tt     = Theme.of(context).textTheme;
    final l10n   = AppLocalizations.of(context)!;

    final initial = customer.name.isNotEmpty
        ? customer.name.characters.first.toUpperCase()
        : '?';

    final balance   = customer.netBalance;
    final dirLabel  = balance > 0
        ? l10n.customerDetailOwesYou
        : balance < 0
            ? l10n.customerDetailYouOwe
            : l10n.customerDetailSettled;
    final labelColor = balance > 0
        ? cs.tertiary
        : balance < 0
            ? cs.secondary
            : cs.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: _Dims.tileMinHeight),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.buttonPaddingH,
          vertical: AppDimensions.inputPaddingV / 2,
        ),
        child: Row(
          children: [
            ListTileAvatar(initial: initial),
            const SizedBox(width: AppDimensions.inputPaddingH),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    customer.name,
                    style: tt.titleSmall?.copyWith(
                      color: cs.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (_subtitle != null)
                    Text(
                      _subtitle!,
                      style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 120),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AmountText.balance(
                    balance: balance,
                    isMasked: isMasked,
                  ),
                  Text(
                    dirLabel,
                    style: tt.labelSmall?.copyWith(color: labelColor),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            if (onMoreTap != null) ...[
              const SizedBox(width: AppDimensions.buttonStackGap),
              MoreIconButton(onTap: onMoreTap!),
            ],
          ],
        ),
      ),
    );
  }
}
