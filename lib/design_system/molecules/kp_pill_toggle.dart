import 'package:flutter/material.dart';

import '../../core/constants/app_dimensions.dart';

/// Binary toggle rendered as two side-by-side pill chips.
/// Selected chip is filled; unselected is ghost (outline only).
class KpPillToggle extends StatelessWidget {
  const KpPillToggle({
    super.key,
    required this.labelA,
    required this.labelB,
    required this.selectedIndex,
    required this.onChanged,
    this.selectedColor,
    this.selectedTextColor,
  }) : assert(selectedIndex == 0 || selectedIndex == 1);

  final String labelA;
  final String labelB;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final Color? selectedColor;
  final Color? selectedTextColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme  = Theme.of(context).colorScheme;
    final fillColor    = selectedColor     ?? colorScheme.secondaryContainer;
    final fillTextColor = selectedTextColor ?? colorScheme.onSecondaryContainer;

    return Row(
      children: [
        Expanded(
          child: _PillChip(
            label: labelA,
            selected: selectedIndex == 0,
            fillColor: fillColor,
            fillTextColor: fillTextColor,
            onTap: () => onChanged(0),
          ),
        ),
        const SizedBox(width: AppDimensions.buttonStackGap),
        Expanded(
          child: _PillChip(
            label: labelB,
            selected: selectedIndex == 1,
            fillColor: fillColor,
            fillTextColor: fillTextColor,
            onTap: () => onChanged(1),
          ),
        ),
      ],
    );
  }
}

class _PillChip extends StatelessWidget {
  const _PillChip({
    required this.label,
    required this.selected,
    required this.fillColor,
    required this.fillTextColor,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final Color fillColor;
  final Color fillTextColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme  = Theme.of(context).colorScheme;
    final textTheme    = Theme.of(context).textTheme;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final borderRadius = BorderRadius.circular(AppDimensions.radiusInput);

    return AnimatedContainer(
      duration: reduceMotion ? Duration.zero : AppDimensions.animShort,
      height: AppDimensions.pillToggleHeight,
      decoration: BoxDecoration(
        color: selected ? fillColor : Colors.transparent,
        borderRadius: borderRadius,
        border: Border.all(
          color: selected ? fillColor : colorScheme.outlineVariant,
          width: selected ? AppDimensions.borderFocused : AppDimensions.borderDefault,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          splashColor: colorScheme.primary.withValues(alpha: AppDimensions.splashAlpha),
          onTap: onTap,
          child: Center(
            child: AnimatedDefaultTextStyle(
              duration: reduceMotion ? Duration.zero : AppDimensions.animShort,
              style: (textTheme.labelLarge ?? const TextStyle()).copyWith(
                color: selected ? fillTextColor : colorScheme.onSurfaceVariant,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              ),
              child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
            ),
          ),
        ),
      ),
    );
  }
}
