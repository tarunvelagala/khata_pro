import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/app_localizations.dart';

/// Destructive-action confirmation dialog.
///
/// Returns `true` if the user confirms, `false` / `null` otherwise.
///
/// ```dart
/// final confirmed = await KpDeleteDialog.show(
///   context,
///   body: l10n.deleteCustomerConfirmBody,
/// );
/// if (confirmed == true) { /* proceed with deletion */ }
/// ```
class KpDeleteDialog extends StatelessWidget {
  const KpDeleteDialog({super.key, required this.body});

  final String body;

  static Future<bool?> show(BuildContext context, {required String body}) =>
      showDialog<bool>(
        context: context,
        builder: (_) => KpDeleteDialog(body: body),
      );

  @override
  Widget build(BuildContext context) {
    final colorScheme   = Theme.of(context).colorScheme;
    final localizations = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(localizations.deleteConfirmTitle),
      content: Text(body),
      actions: [
        TextButton(
          onPressed: () => context.pop(false),
          child: Text(localizations.cancelAction),
        ),
        TextButton(
          onPressed: () => context.pop(true),
          style: TextButton.styleFrom(foregroundColor: colorScheme.error),
          child: Text(localizations.deleteAction),
        ),
      ],
    );
  }
}
