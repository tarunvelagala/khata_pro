import 'package:flutter/material.dart';

import '../../core/constants/app_dimensions.dart';

/// Multi-option toggle rendered as a row of pill chips.
/// Each chip is outlined when unselected, filled when selected.
///
/// [overrideTaps] lets callers intercept specific values (e.g. a "Custom"
/// date-range option that opens a date picker instead of selecting directly).
class KpSegmentToggle<T> extends StatelessWidget {
  const KpSegmentToggle({
    super.key,
    required this.values,
    required this.labels,
    required this.selected,
    required this.onChanged,
    this.overrideTaps,
    this.selectedColor,
    this.selectedTextColor,
  }) : assert(values.length == labels.length && values.length >= 2);

  final List<T>              values;
  final List<String>         labels;
  final T                    selected;
  final ValueChanged<T>      onChanged;
  final Map<T, VoidCallback>? overrideTaps;
  final Color?               selectedColor;
  final Color?               selectedTextColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme   = Theme.of(context).colorScheme;
    final fillColor     = selectedColor     ?? colorScheme.secondaryContainer;
    final fillTextColor = selectedTextColor ?? colorScheme.onSecondaryContainer;

    return SizedBox(
      height: AppDimensions.pillToggleHeight,
      child: Row(
        children: [
          for (int i = 0; i < values.length; i++) ...[
            if (i > 0) const SizedBox(width: AppDimensions.buttonStackGap),
            Expanded(
              child: _SegmentChip(
                label:         labels[i],
                selected:      values[i] == selected,
                fillColor:     fillColor,
                fillTextColor: fillTextColor,
                onTap: overrideTaps?[values[i]] ?? () => onChanged(values[i]),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SegmentChip extends StatelessWidget {
  const _SegmentChip({
    required this.label,
    required this.selected,
    required this.fillColor,
    required this.fillTextColor,
    required this.onTap,
  });

  final String       label;
  final bool         selected;
  final Color        fillColor;
  final Color        fillTextColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme  = Theme.of(context).colorScheme;
    final textTheme    = Theme.of(context).textTheme;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final borderRadius = BorderRadius.circular(AppDimensions.radiusInput);

    return AnimatedContainer(
      duration: reduceMotion ? Duration.zero : AppDimensions.animShort,
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
