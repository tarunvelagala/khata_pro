import 'package:flutter/material.dart';

import '../constants/app_dimensions.dart';
import '../theme/app_colors.dart';

class ScreenFooter extends StatelessWidget {
  const ScreenFooter({
    super.key,
    required this.ctaLabel,
    required this.onCta,
    this.secondaryLabel,
    this.onSecondary,
  });

  final String ctaLabel;
  final VoidCallback onCta;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;

  @override
  Widget build(BuildContext context) {
    final cs          = Theme.of(context).colorScheme;
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: BoxDecoration(
        color: cs.surfaceContainerLowest,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusLarge),
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowCard,
            blurRadius: AppDimensions.shadowBlurCard,
            offset: Offset(0, AppDimensions.shadowOffsetFooter),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(
        AppDimensions.buttonPaddingH,
        AppDimensions.buttonPaddingV,
        AppDimensions.buttonPaddingH,
        AppDimensions.buttonPaddingV + bottomInset,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            child: FilledButton(onPressed: onCta, child: Text(ctaLabel)),
          ),
          if (secondaryLabel != null && onSecondary != null) ...[
            const SizedBox(height: AppDimensions.buttonStackGap),
            TextButton(
              onPressed: onSecondary,
              style: TextButton.styleFrom(
                foregroundColor: cs.onSurfaceVariant,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.zero,
              ),
              child: Text(secondaryLabel!),
            ),
          ],
        ],
      ),
    );
  }
}
