import 'package:flutter/material.dart';

import '../constants/app_dimensions.dart';

/// A binary pill toggle — two equal-width segments in a shared pill-shaped
/// container. Matches the GPay / PhonePe pattern:
///   - True pill shape (full radius)
///   - Both options full-contrast text (selection shown by fill, not dimming)
///   - InkWell ripple on tap (universally understood as "tappable")
///   - Vertical hairline divider between segments
///   - Selected segment elevated slightly above the track
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
    final cs     = Theme.of(context).colorScheme;
    final fill   = selectedColor     ?? cs.secondaryContainer;
    final onFill = selectedTextColor ?? cs.onSecondaryContainer;

    return Container(
      height: AppDimensions.pillToggleHeight,
      clipBehavior: Clip.antiAlias,
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
            onTap: () => onChanged(0),
          ),
          // Hairline divider between segments
          VerticalDivider(
            width: AppDimensions.borderDefault,
            thickness: AppDimensions.borderDefault,
            indent: 10,
            endIndent: 10,
            color: cs.outlineVariant,
          ),
          _Segment(
            label: labelB,
            selected: selectedIndex == 1,
            isFirst: false,
            isLast: true,
            fillColor: fill,
            fillTextColor: onFill,
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
    required this.onTap,
  });

  final String label;
  final bool selected;
  final bool isFirst;
  final bool isLast;
  final Color fillColor;
  final Color fillTextColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    const r = AppDimensions.radiusSmall;
    final br = BorderRadius.horizontal(
      left:  isFirst ? const Radius.circular(r) : Radius.zero,
      right: isLast  ? const Radius.circular(r) : Radius.zero,
    );

    return Expanded(
      child: Material(
        animationDuration: AppDimensions.animShort,
        color: selected ? fillColor : Colors.transparent,
        borderRadius: br,
        child: InkWell(
          borderRadius: br,
          onTap: onTap,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.buttonStackGap),
              child: AnimatedDefaultTextStyle(
                duration: AppDimensions.animShort,
                style: (tt.labelLarge ?? const TextStyle()).copyWith(
                  color: selected ? fillTextColor : cs.onSurface,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                ),
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
