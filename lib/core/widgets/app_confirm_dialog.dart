import 'package:flutter/material.dart';
import 'package:khata_mitra/core/widgets/app_button.dart';

/// Standard destructive-action confirmation dialog.
///
/// Used for delete customer, delete transaction, sign out.
class AppConfirmDialog extends StatelessWidget {
  const AppConfirmDialog({
    super.key,
    required this.title,
    required this.body,
    required this.confirmLabel,
    this.cancelLabel = 'Cancel',
    this.isDestructive = true,
  });

  final String title;
  final String body;
  final String confirmLabel;
  final String cancelLabel;

  /// Confirm button uses [ColorScheme.error] when `true`.
  final bool isDestructive;

  /// Shows the dialog and returns `true` when confirmed, `false` otherwise.
  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String body,
    required String confirmLabel,
    String cancelLabel = 'Cancel',
    bool isDestructive = true,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => AppConfirmDialog(
        title: title,
        body: body,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        isDestructive: isDestructive,
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final confirmColor = isDestructive
        ? colorScheme.error
        : colorScheme.primary;

    return AlertDialog(
      title: Text(title, maxLines: 2, overflow: TextOverflow.ellipsis),
      content: Text(body, maxLines: 5, overflow: TextOverflow.ellipsis),
      actions: [
        AppButton(
          label: cancelLabel,
          onPressed: () => Navigator.of(context).pop(false),
          variant: AppButtonVariant.text,
        ),
        AppButton(
          label: confirmLabel,
          onPressed: () => Navigator.of(context).pop(true),
          variant: AppButtonVariant.text,
          color: confirmColor,
        ),
      ],
    );
  }
}
