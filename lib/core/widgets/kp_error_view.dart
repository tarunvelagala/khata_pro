import 'package:flutter/material.dart';

import '../constants/app_dimensions.dart';
import '../../l10n/app_localizations.dart';

/// Full-screen centred error state with an optional retry CTA.
///
/// Shown when an async provider emits an error. Pass [onRetry] to
/// invalidate the provider and show a retry button.
class KpErrorView extends StatelessWidget {
  const KpErrorView({super.key, this.onRetry});

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final cs   = Theme.of(context).colorScheme;
    final tt   = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: cs.error,
            size: AppDimensions.errorIconSize,
          ),
          const SizedBox(height: AppDimensions.errorIconGap),
          Text(
            l10n.errorGeneric,
            style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: AppDimensions.errorIconGap),
            FilledButton(
              onPressed: onRetry,
              child: Text(l10n.retryButton),
            ),
          ],
        ],
      ),
    );
  }
}
