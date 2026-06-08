import 'package:flutter/material.dart';

import '../constants/app_dimensions.dart';
import '../../l10n/app_localizations.dart';

enum PermissionContext { contacts, notifications, camera }

abstract final class _Dims {
  static const double handleTopPad = 12.0;
  static const double iconSize     = 48.0;
  static const double iconGap      = 16.0;
  static const double titleGap     = 8.0;
  static const double bodyGap      = 24.0;
  static const double btnGap       = 8.0;
  static const double bottomPad    = 24.0;
}

abstract final class PermissionRationaleSheet {
  static Future<void> show(
    BuildContext context, {
    required PermissionContext permission,
    required bool permanentlyDenied,
    required VoidCallback onPrimary,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _PermissionRationaleContent(
        permission: permission,
        permanentlyDenied: permanentlyDenied,
        onPrimary: onPrimary,
      ),
    );
  }
}

class _PermissionRationaleContent extends StatelessWidget {
  const _PermissionRationaleContent({
    required this.permission,
    required this.permanentlyDenied,
    required this.onPrimary,
  });

  final PermissionContext permission;
  final bool              permanentlyDenied;
  final VoidCallback      onPrimary;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs   = Theme.of(context).colorScheme;
    final tt   = Theme.of(context).textTheme;

    final (IconData icon, String title, String body) = switch (permission) {
      PermissionContext.contacts      => (
          Icons.contacts_rounded,
          l10n.permContactsTitle,
          l10n.permContactsBody,
        ),
      PermissionContext.notifications => (
          Icons.notifications_rounded,
          l10n.permNotifTitle,
          l10n.permNotifBody,
        ),
      PermissionContext.camera        => (
          Icons.photo_camera_rounded,
          l10n.permCameraTitle,
          l10n.permCameraBody,
        ),
    };

    final primaryLabel = permanentlyDenied
        ? l10n.permOpenSettings
        : l10n.permAllowButton;

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Handle ──────────────────────────────────────────
            const SizedBox(height: _Dims.handleTopPad),
            Center(
              child: Container(
                width: AppDimensions.dragHandleWidth,
                height: AppDimensions.dragHandleThickness,
                decoration: BoxDecoration(
                  color: cs.outlineVariant,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
                ),
              ),
            ),

            const SizedBox(height: _Dims.iconGap),

            // ── Icon ────────────────────────────────────────────
            Icon(icon, size: _Dims.iconSize, color: cs.primary),
            const SizedBox(height: _Dims.iconGap),

            // ── Title + body ─────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.buttonPaddingH,
              ),
              child: Column(
                children: [
                  Text(
                    title,
                    style: tt.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: cs.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: _Dims.titleGap),
                  Text(
                    body,
                    style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: _Dims.bodyGap),

            // ── Buttons ──────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.buttonPaddingH,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FilledButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onPrimary();
                    },
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(
                        AppDimensions.pillToggleHeight,
                      ),
                    ),
                    child: Text(primaryLabel),
                  ),
                  const SizedBox(height: _Dims.btnGap),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(l10n.permNotNow),
                  ),
                ],
              ),
            ),

            const SizedBox(height: _Dims.bottomPad),
          ],
        ),
      ),
    );
  }
}
