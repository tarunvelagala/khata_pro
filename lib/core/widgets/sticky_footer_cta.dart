import 'package:flutter/material.dart';

import '../constants/app_dimensions.dart';
import 'button_spinner.dart';

/// Full-width sticky footer with a primary [FilledButton] CTA and an optional
/// secondary [TextButton] beneath it.
///
/// Drop this at the bottom of a [Column] that has an [Expanded] scroll area
/// above it. It handles the bottom safe-area inset automatically.
///
/// Parameters:
/// - [icon]            — optional leading icon inside the primary button.
/// - [loading]         — shows a [ButtonSpinner] in place of the label.
/// - [secondaryLabel]  — optional secondary action label (rendered as TextButton).
/// - [onSecondary]     — callback for the secondary action.
/// - [topRadius]       — border-radius for the top corners (0 = no rounding).
///                       Pass [AppDimensions.radiusLarge] for a modal-style footer.
/// - [backgroundColor] — override the container background; defaults to cs.surface.
class StickyFooterCta extends StatelessWidget {
  const StickyFooterCta({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.loading = false,
    this.secondaryLabel,
    this.onSecondary,
    this.topRadius = 0.0,
    this.backgroundColor,
  });

  final String label;
  final VoidCallback? onPressed;
  final Widget? icon;
  final bool loading;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;
  final double topRadius;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final cs     = Theme.of(context).colorScheme;
    final bottom = MediaQuery.paddingOf(context).bottom;

    final bgColor = backgroundColor ?? cs.surface;
    final radius  = topRadius > 0
        ? BorderRadius.vertical(top: Radius.circular(topRadius))
        : BorderRadius.zero;

    Widget primaryButton = loading
        ? FilledButton(onPressed: null, child: const ButtonSpinner())
        : icon != null
            ? FilledButton.icon(
                onPressed: onPressed,
                icon: icon!,
                label: Text(label),
              )
            : FilledButton(
                onPressed: onPressed,
                child: Text(label),
              );

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: cs.shadow.withValues(alpha: AppDimensions.splashAlpha),
            blurRadius: AppDimensions.shadowBlurCard,
            offset: const Offset(0, AppDimensions.shadowOffsetFooter),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(
        AppDimensions.buttonPaddingH,
        AppDimensions.buttonPaddingV / 2,
        AppDimensions.buttonPaddingH,
        AppDimensions.buttonPaddingV / 2 + bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: double.infinity, child: primaryButton),
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
