import 'package:flutter/material.dart';
import 'package:khata_mitra/core/responsive/responsive_extension.dart';
import 'package:khata_mitra/core/widgets/app_button.dart';

/// Centred illustration + heading + body + optional CTA.
///
/// Used on every empty list screen.
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    required this.title,
    required this.body,
    this.svgAssetPath,
    this.ctaLabel,
    this.onCta,
  });

  final String title;
  final String body;

  /// Illustration shown at 160 dp (mobile) / 184 dp (tablet).
  final String? svgAssetPath;

  final String? ctaLabel;
  final VoidCallback? onCta;

  @override
  Widget build(BuildContext context) {
    final d = context.rDims;
    final t = context.rText;
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(d.emptyStatePadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (svgAssetPath != null) ...[
              Image.asset(
                svgAssetPath!,
                width: d.emptyStateIllustrationSize,
                height: d.emptyStateIllustrationSize,
                errorBuilder: (_, _, _) => SizedBox(
                  width: d.emptyStateIllustrationSize,
                  height: d.emptyStateIllustrationSize,
                ),
              ),
              const SizedBox(height: 24),
            ],
            Text(
              title,
              style: t.titleLarge.copyWith(color: colorScheme.onSurface),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              body,
              style: t.bodyMedium.copyWith(color: colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            if (ctaLabel != null && onCta != null) ...[
              const SizedBox(height: 24),
              AppButton(label: ctaLabel!, onPressed: onCta),
            ],
          ],
        ),
      ),
    );
  }
}
