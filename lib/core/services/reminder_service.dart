import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../l10n/app_localizations.dart';

abstract final class ReminderService {
  /// Tries to open WhatsApp directly with the pre-filled message via wa.me.
  /// Falls back to the system share sheet if WhatsApp is not installed.
  static Future<void> send({
    required BuildContext context,
    required String phone,
    required String message,
    String? imagePath,
  }) async {
    final digits = phone.replaceAll(RegExp(r'\D'), '');
    final e164   = digits.length == 10 ? '91$digits' : digits;
    final uri    = Uri.parse(
        'https://wa.me/$e164?text=${Uri.encodeComponent(message)}');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      return;
    }

    // WhatsApp not installed — fall back to generic share sheet.
    if (context.mounted) {
      await sendViaShareSheet(
        context: context,
        message: message,
        imagePath: imagePath,
      );
    }
  }

  /// Shares [message] (and optionally an image at [imagePath]) via the system
  /// share sheet, then shows a snackbar if sharing is unavailable.
  static Future<bool> sendViaShareSheet({
    required BuildContext context,
    required String message,
    String? imagePath,
  }) async {
    ShareResult? result;
    try {
      final params = imagePath != null
          ? ShareParams(text: message, files: [XFile(imagePath)])
          : ShareParams(text: message);
      result = await SharePlus.instance.share(params);
    } on MissingPluginException {
      // Share plugin not available (e.g. iOS Simulator).
    } on PlatformException {
      // Native share sheet failed unexpectedly.
    }

    final unavailable = result == null ||
        result.status == ShareResultStatus.unavailable;

    if (unavailable && context.mounted) {
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.reminderShareUnavailable),
          duration: const Duration(seconds: 10),
          action: SnackBarAction(
            label: l10n.copyAction,
            onPressed: () => Clipboard.setData(ClipboardData(text: message)),
          ),
        ),
      );
    }

    return !unavailable;
  }
}
