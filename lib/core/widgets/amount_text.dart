import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Renders a rupee amount with the correct credit/debit color and optional
/// sign prefix.  All instances across the app share this single widget so
/// color semantics stay consistent: tertiary (red) = You Gave (debit),
/// secondary (green) = You Got (credit).
///
/// **Balance variant** (e.g. customer net-balance on list tiles / hero band):
/// ```dart
/// AmountText.balance(balance: customer.netBalance, isMasked: _masked)
/// ```
/// Shows the absolute value; positive → tertiary (red, they owe you),
/// negative → secondary (green, you owe them), zero → onSurfaceVariant.
///
/// **Transaction variant** (e.g. transaction list tiles):
/// ```dart
/// AmountText.transaction(amount: txn.amount, isCredit: txn.isCredit,
///                        isMasked: _masked)
/// ```
/// Always shows a `- ` or `+ ` prefix; isCredit (You Gave) → tertiary (red) with `- `,
/// else (You Got) → secondary (green) with `+ `.
class AmountText extends StatelessWidget {
  const AmountText._({
    super.key,
    required this.value,
    required this.isCredit,
    required this.isMasked,
    required this.showPrefix,
    this.style,
  });

  /// Net balance (signed). Positive → credit color, negative → debit color.
  factory AmountText.balance({
    Key? key,
    required double balance,
    required bool isMasked,
    TextStyle? style,
  }) =>
      AmountText._(
        key: key,
        value: balance,
        isCredit: balance >= 0,
        isMasked: isMasked,
        showPrefix: false,
        style: style,
      );

  /// Transaction amount (always positive). [isCredit] drives color + prefix.
  factory AmountText.transaction({
    Key? key,
    required double amount,
    required bool isCredit,
    required bool isMasked,
    TextStyle? style,
  }) =>
      AmountText._(
        key: key,
        value: amount,
        isCredit: isCredit,
        isMasked: isMasked,
        showPrefix: true,
        style: style,
      );

  final double value;
  final bool isCredit;
  final bool isMasked;
  final bool showPrefix;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final cs     = Theme.of(context).colorScheme;
    final tt     = Theme.of(context).textTheme;
    final locale = Localizations.localeOf(context).toString();

    final Color color;
    if (showPrefix) {
      // isCredit = You Gave (red), !isCredit = You Got (green)
      color = isCredit ? cs.tertiary : cs.secondary;
    } else {
      color = switch (value) {
        > 0 => cs.tertiary,   // positive balance = they owe you = red
        < 0 => cs.secondary,  // negative balance = you owe them = green
        _   => cs.onSurfaceVariant,
      };
    }

    final String text;
    if (isMasked) {
      text = '₹ ••••';
    } else {
      final formatted = NumberFormat.currency(
        locale: locale,
        symbol: '',
        decimalDigits: 0,
      ).format(value.abs()).trim();

      if (showPrefix) {
        text = '${isCredit ? '- ' : '+ '}₹ $formatted';
      } else {
        text = '₹ $formatted';
      }
    }

    final resolvedStyle = (style ?? tt.titleMedium)?.copyWith(
      color: color,
      fontWeight: FontWeight.w700,
      fontFeatures: const [FontFeature.tabularFigures()],
    );

    return Text(
      text,
      style: resolvedStyle,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }
}
