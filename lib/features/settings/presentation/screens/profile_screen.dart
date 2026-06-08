import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/services/catalog_image_service.dart';
import '../../../../core/widgets/kp_delete_dialog.dart';
import '../../../../core/widgets/scroll_hint_wrapper.dart';
import '../../../../features/auth/presentation/providers/auth_provider.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/profile_provider.dart';

abstract final class _Dims {
  static const double avatarRadius       = 40.0;
  static const double avatarFontSize     = 32.0;
  static const double headerTopGap       = 40.0;
  static const double avatarToNameGap    = 16.0;
  static const double nameToShopGap      = 4.0;
  static const double sectionTopGap      = 32.0;
  static const double sectionLabelV      = 8.0;
  static const double catalogPlaceholderIconSize = 32.0;
}

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n    = AppLocalizations.of(context)!;
    final cs      = Theme.of(context).colorScheme;
    final tt      = Theme.of(context).textTheme;
    final profile = ref.watch(profileProvider).value;
    final p       = (profile != null && profile.name.isNotEmpty) ? profile : null;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(l10n.profileScreenTitle),
        actions: [
          TextButton(
            onPressed: () => context.push('/onboarding/profile'),
            child: Text(l10n.profileEditButton),
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: ScrollHintWrapper(
          hintLabel: AppLocalizations.of(context)!.scrollForMore,
          child: ListView(
            padding: const EdgeInsets.only(bottom: AppDimensions.fabClearance),
          children: [
            // ── Avatar + name header ─────────────────────────────────
            const SizedBox(height: _Dims.headerTopGap),
            Center(
              child: CircleAvatar(
                radius: _Dims.avatarRadius,
                backgroundColor: cs.primaryContainer,
                child: p != null
                    ? Text(
                        p.name.characters.first.toUpperCase(),
                        style: TextStyle(
                          fontSize: _Dims.avatarFontSize,
                          fontWeight: FontWeight.w700,
                          color: cs.onPrimaryContainer,
                        ),
                      )
                    : Icon(
                        Icons.person_rounded,
                        size: _Dims.avatarFontSize,
                        color: cs.onPrimaryContainer,
                      ),
              ),
            ),
            const SizedBox(height: _Dims.avatarToNameGap),
            if (p != null) ...[
              Text(
                p.name,
                style: tt.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: cs.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              if (p.shopName?.isNotEmpty == true) ...[
                const SizedBox(height: _Dims.nameToShopGap),
                Text(
                  p.shopName!,
                  style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
                  textAlign: TextAlign.center,
                ),
              ],
            ],

            // ── Visiting cards & catalog images ──────────────────────
            _SectionLabel(label: l10n.catalogSectionTitle, cs: cs, tt: tt),
            _CatalogRow(
              paths: p?.catalogImagePaths ?? const [],
              onAdd: () => _showAddImageSheet(context, ref, l10n),
              onDelete: (path) => _confirmDeleteImage(context, ref, l10n, path),
            ),

            // ── Auth section ─────────────────────────────────────────
            _SectionLabel(label: l10n.profileAuthSection, cs: cs, tt: tt),
            _AuthTile(cs: cs, tt: tt),
          ],
          ),
        ),
      ),
    );
  }

  Future<void> _showAddImageSheet(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) async {
    final source = await context.push<ImageSource>('/profile/add-image');
    if (source == null || !context.mounted) return;
    final path = await CatalogImageService.pickAndStore(source);
    if (path != null) {
      await ref.read(profileProvider.notifier).addCatalogImage(path);
    }
  }

  Future<void> _confirmDeleteImage(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    String path,
  ) async {
    final confirmed = await KpDeleteDialog.show(
      context,
      body: l10n.catalogDeleteConfirm,
    );
    if (confirmed == true) {
      await CatalogImageService.delete(path);
      await ref.read(profileProvider.notifier).removeCatalogImage(path);
    }
  }
}

// ── Catalog image thumbnail row ───────────────────────────────────────────────

class _CatalogRow extends StatelessWidget {
  const _CatalogRow({
    required this.paths,
    required this.onAdd,
    required this.onDelete,
  });

  final List<String> paths;
  final VoidCallback onAdd;
  final ValueChanged<String> onDelete;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    if (paths.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.buttonPaddingH,
        ),
        child: GestureDetector(
          onTap: onAdd,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: AppDimensions.buttonPaddingV,
            ),
            decoration: BoxDecoration(
              color: cs.surfaceContainerLow,
              borderRadius:
                  BorderRadius.circular(AppDimensions.catalogThumbRadius),
              border: Border.all(
                color: cs.outlineVariant,
                width: AppDimensions.borderDefault,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add_photo_alternate_outlined,
                  size: _Dims.catalogPlaceholderIconSize,
                  color: cs.primary,
                ),
                const SizedBox(height: AppDimensions.buttonStackGap),
                Text(
                  l10n.catalogAddPhoto,
                  style: tt.bodyMedium?.copyWith(color: cs.primary),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: AppDimensions.catalogThumbHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.buttonPaddingH,
        ),
        itemCount: paths.length + 1,
        separatorBuilder: (_, _) =>
            const SizedBox(width: AppDimensions.catalogTileGap),
        itemBuilder: (ctx, i) {
          if (i == 0) {
            return GestureDetector(
              onTap: onAdd,
              child: Container(
                width: AppDimensions.catalogAddTileWidth,
                height: AppDimensions.catalogThumbHeight,
                decoration: BoxDecoration(
                  color: cs.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(
                      AppDimensions.catalogThumbRadius),
                  border: Border.all(
                    color: cs.outlineVariant,
                    width: AppDimensions.borderDefault,
                  ),
                ),
                child: Icon(
                  Icons.add_photo_alternate_outlined,
                  color: cs.onSurfaceVariant,
                ),
              ),
            );
          }
          final path = paths[i - 1];
          return GestureDetector(
            onTap: () => _showFullscreen(ctx, path),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                  AppDimensions.catalogThumbRadius),
              child: Image.file(
                File(path),
                width: AppDimensions.catalogThumbWidth,
                height: AppDimensions.catalogThumbHeight,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => ColoredBox(
                  color: cs.surfaceContainerLow,
                  child: SizedBox(
                    width: AppDimensions.catalogThumbWidth,
                    child: Icon(
                      Icons.broken_image_outlined,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showFullscreen(BuildContext context, String path) {
    final l10n = AppLocalizations.of(context)!;
    showDialog<void>(
      context: context,
      builder: (ctx) {
        final cs = Theme.of(ctx).colorScheme;
        return Dialog.fullscreen(
          backgroundColor: cs.inverseSurface,
          child: Stack(
            fit: StackFit.expand,
            children: [
              InteractiveViewer(
                child: Image.file(File(path), fit: BoxFit.contain),
              ),
              Positioned(
                top: MediaQuery.of(ctx).padding.top + AppDimensions.inputPaddingH,
                right: AppDimensions.inputPaddingH,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.delete_outline_rounded),
                      color: cs.onInverseSurface,
                      iconSize: AppDimensions.iconSizeMedium,
                      tooltip: l10n.deleteAction,
                      onPressed: () {
                        ctx.pop();
                        onDelete(path);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded),
                      color: cs.onInverseSurface,
                      iconSize: AppDimensions.iconSizeMedium,
                      onPressed: () => ctx.pop(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── Add image bottom sheet ────────────────────────────────────────────────────

// ── Auth tile (sign in / signed-in state) ─────────────────────────────────────

class _AuthTile extends ConsumerWidget {
  const _AuthTile({required this.cs, required this.tt});

  final ColorScheme cs;
  final TextTheme tt;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n    = AppLocalizations.of(context)!;
    final authVal = ref.watch(authProvider);

    return authVal.when(
      loading: () => const ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppDimensions.buttonPaddingH,
        ),
        leading: SizedBox(
          width: AppDimensions.iconSizeMedium,
          height: AppDimensions.iconSizeMedium,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        title: Text(''),
      ),
      error: (_, e) => ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.buttonPaddingH,
        ),
        leading: Icon(Icons.login_rounded, color: cs.onSurfaceVariant),
        title: Text(
          l10n.profileSignInButton,
          style: tt.bodyMedium?.copyWith(color: cs.onSurface),
        ),
        trailing: Icon(Icons.chevron_right_rounded, color: cs.onSurfaceVariant),
        onTap: () => context.push('/auth/sign-in', extra: false),
      ),
      data: (user) => user == null
          ? ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.buttonPaddingH,
              ),
              leading: Icon(Icons.login_rounded, color: cs.onSurfaceVariant),
              title: Text(
                l10n.profileSignInButton,
                style: tt.bodyMedium?.copyWith(color: cs.onSurface),
              ),
              trailing:
                  Icon(Icons.chevron_right_rounded, color: cs.onSurfaceVariant),
              onTap: () => context.push('/auth/sign-in', extra: false),
            )
          : ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.buttonPaddingH,
              ),
              leading: Icon(Icons.account_circle_rounded, color: cs.primary),
              title: Text(
                l10n.authSignedInAs(user.displayLabel),
                style: tt.bodyMedium?.copyWith(color: cs.onSurface),
              ),
              trailing: TextButton(
                onPressed: () => ref.read(authProvider.notifier).signOut(),
                child: Text(
                  l10n.authSignOut,
                  style: TextStyle(color: cs.error),
                ),
              ),
            ),
    );
  }
}

// ── Section label ─────────────────────────────────────────────────────────────

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
        _Dims.sectionTopGap,
        AppDimensions.buttonPaddingH,
        _Dims.sectionLabelV,
      ),
      child: Text(
        label.toUpperCase(),
        style: tt.labelSmall?.copyWith(
          color: cs.primary,
          fontWeight: FontWeight.w700,
          letterSpacing: AppDimensions.letterSpacingLabel,
        ),
      ),
    );
  }
}
