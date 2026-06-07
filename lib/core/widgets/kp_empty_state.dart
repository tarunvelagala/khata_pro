import 'package:flutter/material.dart';

import '../constants/app_dimensions.dart';

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
    this.onCta,
    this.ctaIcon,
  });

  final IconData icon;
  final String title;
  final String? body;
  final String? ctaLabel;
  final VoidCallback? onCta;
  final IconData? ctaIcon;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.buttonPaddingH * 2,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: AppDimensions.emptyIconSize, color: cs.outlineVariant),
            const SizedBox(height: AppDimensions.inputPaddingV),
            Text(
              title,
              style: tt.titleMedium?.copyWith(color: cs.onSurface),
              textAlign: TextAlign.center,
            ),
            if (body != null) ...[
              const SizedBox(height: AppDimensions.buttonStackGap),
              Text(
                body!,
                style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
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
