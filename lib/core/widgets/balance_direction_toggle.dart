import 'package:flutter/material.dart';

import 'pill_toggle.dart';

/// A binary direction toggle for financial entries: "positive" (they owe me /
/// gave) vs. "negative" (I owe them / received).
///
/// Encapsulates the standard tertiary-container / secondary-container
/// color-swap so callers never repeat that logic.
class BalanceDirectionToggle extends StatelessWidget {
  const BalanceDirectionToggle({
    super.key,
    required this.labelPositive,
    required this.labelNegative,
    required this.isPositive,
    required this.onChanged,
  });

  /// Label for the first (positive) segment, e.g. "They Owe Me" or "You Gave".
  final String labelPositive;

  /// Label for the second (negative) segment, e.g. "I Owe Them" or "You Got".
  final String labelNegative;

  final bool isPositive;

  /// Called with the new value whenever the selection changes.
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return KpPillToggle(
      labelA: labelNegative,
      labelB: labelPositive,
      selectedIndex: isPositive ? 1 : 0,
      onChanged: (i) => onChanged(i == 1),
      selectedColor: isPositive ? cs.tertiaryContainer : cs.secondaryContainer,
      selectedTextColor:
          isPositive ? cs.onTertiaryContainer : cs.onSecondaryContainer,
    );
  }
}
