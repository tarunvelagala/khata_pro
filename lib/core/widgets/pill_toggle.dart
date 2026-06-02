import 'package:flutter/material.dart';

import '../constants/app_dimensions.dart';

/// A binary pill toggle — two equal-width segments in a shared rounded
/// container. Only the background fill changes on selection; text and
/// layout are completely stable. Mirrors the GPay / PhonePe pattern.
///
/// [selectedIndex] must be 0 or 1. [onChanged] fires with the tapped index.
/// [selectedColor] / [selectedTextColor] default to M3 secondaryContainer /
/// onSecondaryContainer but can be overridden per callsite.
class PillToggle extends StatelessWidget {
  const PillToggle({
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
    final cs = Theme.of(context).colorScheme;
    final fill   = selectedColor     ?? cs.secondaryContainer;
    final onFill = selectedTextColor ?? cs.onSecondaryContainer;

    return Container(
      height: AppDimensions.pillToggleHeight,
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
        border: Border.all(color: cs.outlineVariant, width: AppDimensions.borderDefault),
      ),
      child: Row(
        children: [
          _Segment(
            label: labelA,
            selected: selectedIndex == 0,
            isFirst: true,
            isLast: false,
            fillColor: fill,
            fillTextColor: onFill,
            idleTextColor: cs.onSurfaceVariant,
            onTap: () => onChanged(0),
          ),
          _Segment(
            label: labelB,
            selected: selectedIndex == 1,
            isFirst: false,
            isLast: true,
            fillColor: fill,
            fillTextColor: onFill,
            idleTextColor: cs.onSurfaceVariant,
            onTap: () => onChanged(1),
          ),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.label,
    required this.selected,
    required this.isFirst,
    required this.isLast,
    required this.fillColor,
    required this.fillTextColor,
    required this.idleTextColor,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final bool isFirst;
  final bool isLast;
  final Color fillColor;
  final Color fillTextColor;
  final Color idleTextColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    // Inner radius is outer radius minus border width so corners nest cleanly.
    final innerRadius = AppDimensions.radiusSmall - AppDimensions.borderDefault;
    final br = BorderRadius.horizontal(
      left:  isFirst ? Radius.circular(innerRadius) : Radius.zero,
      right: isLast  ? Radius.circular(innerRadius) : Radius.zero,
    );

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: AppDimensions.animShort,
          decoration: BoxDecoration(
            color: selected ? fillColor : Colors.transparent,
            borderRadius: br,
          ),
          alignment: Alignment.center,
          // Fixed text style — never changes between selected / unselected.
          // Color transitions via AnimatedDefaultTextStyle.
          child: AnimatedDefaultTextStyle(
            duration: AppDimensions.animShort,
            style: tt.labelLarge!.copyWith(
              color: selected ? fillTextColor : idleTextColor,
              fontWeight: FontWeight.w600,
            ),
            child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
        ),
      ),
    );
  }
}
