import 'package:flutter/material.dart';

import '../../core/constants/app_dimensions.dart';

/// Standard empty-state layout: icon → title → body → optional CTA.
///
/// Used for zero-data screens (no customers, no transactions) and
/// zero-results states (search returned nothing).
class KpEmptyState extends StatelessWidget {
  const KpEmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.body,
    this.ctaLabel,
    this.ctaIcon,
    this.onCta,
  });

  final IconData icon;
  final String title;
  final String? body;
  final String? ctaLabel;
  final IconData? ctaIcon;
  final VoidCallback? onCta;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme   = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.buttonPaddingH * 2,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: AppDimensions.emptyIconSize, color: colorScheme.outlineVariant),
            const SizedBox(height: AppDimensions.inputPaddingV),
            Text(
              title,
              style: textTheme.titleMedium?.copyWith(color: colorScheme.onSurface),
              textAlign: TextAlign.center,
            ),
            if (body != null) ...[
              const SizedBox(height: AppDimensions.buttonStackGap),
              Text(
                body!,
                style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
            ],
            if (ctaLabel != null && onCta != null) ...[
              const SizedBox(height: AppDimensions.inputPaddingV),
              ctaIcon != null
                  ? FilledButton.icon(
                      onPressed: onCta,
                      icon: Icon(ctaIcon),
                      label: Text(ctaLabel!),
                    )
                  : FilledButton(
                      onPressed: onCta,
                      child: Text(ctaLabel!),
                    ),
            ],
          ],
        ),
      ),
    );
  }
}
