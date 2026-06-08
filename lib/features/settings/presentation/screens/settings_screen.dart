import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/widgets/set_reminder_sheet.dart';
import '../../../../core/widgets/scroll_hint_wrapper.dart';
import '../../../../features/auth/presentation/providers/app_lock_provider.dart';
import '../../../../features/auth/presentation/providers/auth_provider.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/backup_provider.dart';
import '../providers/reminder_settings_provider.dart';

abstract final class _Dims {
  static const double sectionLabelV = 8.0;
  static const double headerTopGap  = 8.0;
}

const String _kAppVersion = '1.0.0';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n   = AppLocalizations.of(context)!;
    final cs     = Theme.of(context).colorScheme;
    final tt     = Theme.of(context).textTheme;
    final backup = ref.watch(backupProvider);
    final reminderFreq = ref.watch(reminderSettingsProvider).value;
    final isSignedIn   = ref.watch(authProvider).value != null;
    final lockState    = ref.watch(appLockProvider).asData?.value;

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimensions.buttonPaddingH,
                AppDimensions.inputPaddingV / 2,
                AppDimensions.buttonPaddingH,
                0,
              ),
              child: Text(
                l10n.settingsTitle,
                style: tt.headlineSmall?.copyWith(
                  color: cs.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            const SizedBox(height: _Dims.headerTopGap),

            Expanded(
              child: ScrollHintWrapper(
                hintLabel: l10n.scrollForMore,
                child: ListView(
                  padding: const EdgeInsets.only(
                    bottom: AppDimensions.fabClearance,
                  ),
                children: [
                  // ── Account section (shown when signed out) ──────────
                  if (!isSignedIn) ...[
                    _SectionLabel(label: l10n.profileAuthSection, cs: cs, tt: tt),
                    _SettingsTile(
                      icon: Icons.cloud_sync_rounded,
                      title: l10n.profileSignInButton,
                      subtitle: l10n.authSignInSubtitle,
                      onTap: () => context.push('/auth/sign-in', extra: false),
                    ),
                    const Divider(
                      height: AppDimensions.dividerThickness,
                      indent: AppDimensions.buttonPaddingH,
                      endIndent: AppDimensions.buttonPaddingH,
                    ),
                  ],

                  // ── Preferences section ──────────────────────────
                  _SectionLabel(label: l10n.settingsLanguage, cs: cs, tt: tt),
                  _SettingsTile(
                    icon: Icons.translate_rounded,
                    title: l10n.settingsLanguage,
                    subtitle: l10n.settingsLanguageSubtitle,
                    onTap: () => context.push('/settings/language'),
                  ),
                  const Divider(
                    height: AppDimensions.dividerThickness,
                    indent: AppDimensions.buttonPaddingH,
                    endIndent: AppDimensions.buttonPaddingH,
                  ),

                  // ── Reminders section ─────────────────────────────
                  _SectionLabel(label: l10n.remindersSectionTitle, cs: cs, tt: tt),
                  _SettingsTile(
                    icon: Icons.alarm_rounded,
                    title: l10n.defaultReminderTitle,
                    subtitle: reminderFreq == null || reminderFreq.days == 0
                        ? l10n.defaultReminderSubtitle
                        : '${switch (reminderFreq) {
                            _ when reminderFreq.days == 7  => l10n.reminderFrequencyWeekly,
                            _ when reminderFreq.days == 14 => l10n.reminderFrequencyFortnightly,
                            _                              => l10n.reminderFrequencyMonthly,
                          }} · ${l10n.defaultReminderSubtitle}',
                    onTap: () => SetReminderSheet.showGlobal(context, ref),
                  ),
                  const Divider(
                    height: AppDimensions.dividerThickness,
                    indent: AppDimensions.buttonPaddingH,
                    endIndent: AppDimensions.buttonPaddingH,
                  ),

                  // ── Security section ─────────────────────────────────
                  _SectionLabel(label: l10n.appLockSectionTitle, cs: cs, tt: tt),
                  _SettingsTile(
                    icon: Icons.lock_rounded,
                    title: l10n.appLockTileTitle,
                    subtitle: lockState?.enabled == true
                        ? l10n.appLockTileSubtitle
                        : l10n.appLockDisabledInfo,
                    onTap: () => context.push('/auth/set-pin'),
                  ),
                  if (lockState?.enabled == true)
                    _SettingsTile(
                      icon: Icons.lock_open_rounded,
                      title: l10n.appLockDisabledInfo,
                      onTap: () =>
                          ref.read(appLockProvider.notifier).clearPin(),
                    ),
                  const Divider(
                    height: AppDimensions.dividerThickness,
                    indent: AppDimensions.buttonPaddingH,
                    endIndent: AppDimensions.buttonPaddingH,
                  ),

                  // ── Data section ─────────────────────────────────
                  _SectionLabel(label: l10n.backupSectionTitle, cs: cs, tt: tt),
                  _SettingsTile(
                    icon: Icons.backup_rounded,
                    title: l10n.backupTileTitle,
                    subtitle: l10n.backupTileSubtitle,
                    loading: backup.exporting,
                    onTap: backup.busy
                        ? null
                        : () => _doExport(context, l10n, ref),
                  ),
                  _SettingsTile(
                    icon: Icons.restore_rounded,
                    title: l10n.restoreTileTitle,
                    subtitle: l10n.restoreTileSubtitle,
                    loading: backup.importing,
                    onTap: backup.busy
                        ? null
                        : () => _confirmRestore(context, l10n, ref),
                  ),
                  const Divider(
                    height: AppDimensions.dividerThickness,
                    indent: AppDimensions.buttonPaddingH,
                    endIndent: AppDimensions.buttonPaddingH,
                  ),

                  // ── About section ────────────────────────────────
                  _SectionLabel(label: l10n.settingsAboutSection, cs: cs, tt: tt),
                  _SettingsTile(
                    icon: Icons.info_outline_rounded,
                    title: l10n.settingsVersion,
                    subtitle: _kAppVersion,
                  ),
                  _SettingsTile(
                    icon: Icons.star_outline_rounded,
                    title: l10n.settingsRateApp,
                    onTap: () {
                      final url = Platform.isIOS
                          ? AppConstants.kAppStoreUrl
                          : AppConstants.kPlayStoreUrl;
                      launchUrl(Uri.parse(url),
                          mode: LaunchMode.externalApplication);
                    },
                  ),
                  _SettingsTile(
                    icon: Icons.privacy_tip_outlined,
                    title: l10n.settingsPrivacyPolicy,
                    onTap: () => launchUrl(
                      Uri.parse(AppConstants.kPrivacyPolicyUrl),
                      mode: LaunchMode.externalApplication,
                    ),
                  ),
                ],
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _doExport(
    BuildContext context,
    AppLocalizations l10n,
    WidgetRef ref,
  ) async {
    await ref.read(backupProvider.notifier).export(context);
    if (!context.mounted) return;
    final error = ref.read(backupProvider).error;
    if (error != null) {
      final message = switch (error) {
        'backupEmptyError' => l10n.backupEmptyError,
        _                  => l10n.backupExportError,
      };
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  Future<void> _confirmRestore(
    BuildContext context,
    AppLocalizations l10n,
    WidgetRef ref,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.restoreConfirmTitle),
        content: Text(l10n.restoreConfirmBody),
        actions: [
          TextButton(
            onPressed: () => ctx.pop(false),
            child: Text(l10n.cancelAction),
          ),
          FilledButton(
            onPressed: () => ctx.pop(true),
            child: Text(l10n.restoreAction),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    final ok = await ref.read(backupProvider.notifier).import();
    if (!context.mounted) return;

    if (ok == null) return; // user cancelled file picker — show nothing
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(ok ? l10n.restoreSuccess : l10n.restoreError),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({
    required this.label,
    required this.cs,
    required this.tt,
  });

  final String label;
  final ColorScheme cs;
  final TextTheme tt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.buttonPaddingH,
        _Dims.sectionLabelV * 2,
        AppDimensions.buttonPaddingH,
        _Dims.sectionLabelV,
      ),
      child: Text(
        label.toUpperCase(),
        style: tt.labelSmall?.copyWith(
          color: cs.primary,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.loading = false,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final bool loading;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.buttonPaddingH,
      ),
      leading: Icon(icon, color: cs.onSurfaceVariant),
      title: Text(
        title,
        style: tt.bodyMedium?.copyWith(color: cs.onSurface),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
            )
          : null,
      trailing: loading
          ? SizedBox(
              width: AppDimensions.iconSizeSmall,
              height: AppDimensions.iconSizeSmall,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: cs.primary,
              ),
            )
          : onTap != null
              ? Icon(Icons.chevron_right_rounded, color: cs.onSurfaceVariant)
              : null,
      onTap: onTap,
    );
  }
}
