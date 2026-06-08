import 'package:flutter/material.dart';

import '../../core/constants/app_dimensions.dart';
import '../../l10n/app_localizations.dart';

/// Full-screen centred error state with an optional retry CTA.
///
/// Pass [onRetry] to show a retry button that re-triggers the failing operation.
/// Set [compact] to true for inline use (e.g. inside a list section).
class KpErrorView extends StatelessWidget {
  const KpErrorView({super.key, this.message, this.onRetry, this.compact = false});

  final String? message;
  final VoidCallback? onRetry;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colorScheme    = Theme.of(context).colorScheme;
    final textTheme      = Theme.of(context).textTheme;
    final localizations  = AppLocalizations.of(context)!;

    final double iconSize = compact
        ? AppDimensions.errorIconSize
        : AppDimensions.emptyIconSize;

    Widget body = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.error_outline_rounded, color: colorScheme.error, size: iconSize),
        const SizedBox(height: AppDimensions.errorIconGap),
        Text(
          message ?? localizations.errorGeneric,
          style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
          textAlign: TextAlign.center,
        ),
        if (onRetry != null) ...[
          const SizedBox(height: AppDimensions.errorIconGap),
          FilledButton(
            onPressed: onRetry,
            child: Text(localizations.retryButton),
          ),
        ],
      ],
    );

    if (compact) return body;
    return Center(child: body);
  }
}
