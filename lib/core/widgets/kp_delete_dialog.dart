import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/app_localizations.dart';

/// Shows a destructive-action confirmation dialog and returns `true` if
/// the user taps Delete, `false` / `null` otherwise.
///
/// ```dart
/// final ok = await KpDeleteDialog.show(
///   context,
///   body: l10n.deleteCustomerConfirmBody,
/// );
/// if (ok == true) { /* delete */ }
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
    final cs   = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(l10n.deleteConfirmTitle),
      content: Text(body),
      actions: [
        TextButton(
          onPressed: () => context.pop(false),
          child: Text(l10n.cancelAction),
        ),
        TextButton(
          onPressed: () => context.pop(true),
          style: TextButton.styleFrom(foregroundColor: cs.error),
          child: Text(l10n.deleteAction),
        ),
      ],
    );
  }
}
