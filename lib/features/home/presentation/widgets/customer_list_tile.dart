import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/widgets/avatar_palette.dart';
import '../../domain/models/customer.dart';

abstract final class _Dims {
  static const double avatarRadius   = 22.0;
  static const double avatarFontSize = 16.0;
  static const double tileMinHeight  = 64.0;
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
  /// Called when the trailing ••• button is tapped. Null hides the button.
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
    final locale = Localizations.localeOf(context).toString();

    final isPositive = customer.netBalance >= 0;
    final amountColor = isPositive ? cs.secondary : cs.tertiary;

    final formatted = isMasked
        ? '₹ ••••'
        : NumberFormat.currency(
            locale: locale,
            symbol: '₹ ',
            decimalDigits: 0,
          ).format(customer.netBalance.abs());

    final initial = customer.name.isNotEmpty
        ? customer.name.characters.first.toUpperCase()
        : '?';

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
            CircleAvatar(
              radius: _Dims.avatarRadius,
              backgroundColor: avatarColorFor(initial),
              child: Text(
                initial,
                style: tt.titleSmall?.copyWith(
                  fontSize: _Dims.avatarFontSize,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
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
            Text(
              formatted,
              style: tt.titleMedium?.copyWith(
                color: amountColor,
                fontWeight: FontWeight.w700,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
            if (onMoreTap != null) ...[
              const SizedBox(width: AppDimensions.buttonStackGap),
              GestureDetector(
                onTap: onMoreTap,
                child: Icon(Icons.more_vert_rounded, size: 20, color: cs.onSurfaceVariant),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
