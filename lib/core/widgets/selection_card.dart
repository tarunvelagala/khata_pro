import 'package:flutter/material.dart';

import '../constants/app_dimensions.dart';

const Duration _kAnimDuration = Duration(milliseconds: 150);
const double _kPaddingV = 16.0;
const double _kPaddingH = 12.0;
const double _kCheckSize = 18.0;

class SelectionCard extends StatelessWidget {
  const SelectionCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String? subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    final decoration = BoxDecoration(
      color: isSelected ? cs.primaryContainer : cs.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
      border: Border.all(
        color: isSelected ? cs.primary : cs.outlineVariant,
        width: isSelected
            ? AppDimensions.borderFocused
            : AppDimensions.borderDefault,
      ),
    );

    final content = Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: _kPaddingV,
            horizontal: _kPaddingH,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: tt.titleMedium, textAlign: TextAlign.center),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        ),
        if (isSelected)
          Positioned(
            top: 6,
            right: 6,
            child: Icon(
              Icons.check_circle_rounded,
              color: cs.primary,
              size: _kCheckSize,
            ),
          ),
      ],
    );

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
      child: reduceMotion
          ? DecoratedBox(decoration: decoration, child: content)
          : AnimatedContainer(
              duration: _kAnimDuration,
              decoration: decoration,
              child: content,
            ),
    );
  }
}
