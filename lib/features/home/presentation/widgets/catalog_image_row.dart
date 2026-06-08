import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/widgets/permission_rationale_sheet.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/customer_image_provider.dart';

abstract final class _Dims {
  static const double thumbHeight  = 80.0;
  static const double thumbWidth   = 100.0;
  static const double thumbRadius  = 10.0;
  static const double addTileWidth = 64.0;
  static const double tileGap      = 8.0;
  static const double sectionPadV  = 12.0;
  static const double labelGap     = 8.0;
  static const double sheetPadV    = 8.0;
  static const double deleteBadge  = 20.0;
}

class CatalogImageRow extends ConsumerWidget {
  const CatalogImageRow({super.key, required this.customerId});

  final String customerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n  = AppLocalizations.of(context)!;
    final paths = ref.watch(customerImageProvider(customerId));
    final cs    = Theme.of(context).colorScheme;
    final tt    = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: _Dims.sectionPadV),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section label + count badge
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.buttonPaddingH,
            ),
            child: Row(
              children: [
                Text(
                  l10n.catalogAddPhoto,
                  style: tt.labelLarge?.copyWith(color: cs.onSurfaceVariant),
                ),
                if (paths.isNotEmpty) ...[
                  const SizedBox(width: _Dims.labelGap),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: cs.secondaryContainer,
                      borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
                    ),
                    child: Text(
                      '${paths.length}',
                      style: tt.labelSmall?.copyWith(
                        color: cs.onSecondaryContainer,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: _Dims.labelGap),
          // Horizontal scroll strip
          SizedBox(
            height: _Dims.thumbHeight,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.buttonPaddingH,
              ),
              children: [
                _AddTile(
                  onTap: () => _showSourcePicker(context, ref, l10n),
                ),
                for (final path in paths) ...[
                  const SizedBox(width: _Dims.tileGap),
                  _Thumbnail(
                    path: path,
                    onTap: () => _openFullscreen(context, path),
                    onDelete: () => ref
                        .read(customerImageProvider(customerId).notifier)
                        .deleteImage(path),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSourcePicker(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) {
    showModalBottomSheet<void>(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: _Dims.sheetPadV),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: Text(l10n.catalogTakePhoto),
              onTap: () {
                context.pop();
                _pickWithPermission(context, ref, ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: Text(l10n.catalogChooseGallery),
              onTap: () {
                context.pop();
                _pickWithPermission(context, ref, ImageSource.gallery);
              },
            ),
            const SizedBox(height: _Dims.sheetPadV),
          ],
        ),
      ),
    );
  }

  Future<void> _pickWithPermission(
    BuildContext context,
    WidgetRef ref,
    ImageSource source,
  ) async {
    final perm   = source == ImageSource.camera ? Permission.camera : Permission.photos;
    final status = await perm.request();

    if (status.isGranted || status.isLimited) {
      ref.read(customerImageProvider(customerId).notifier).addImage(source);
      return;
    }

    if (!context.mounted) return;
    PermissionRationaleSheet.show(
      context,
      permission: PermissionContext.camera,
      permanentlyDenied: status.isPermanentlyDenied,
      onPrimary: status.isPermanentlyDenied
          ? openAppSettings
          : () => _pickWithPermission(context, ref, source),
    );
  }

  void _openFullscreen(BuildContext context, String imagePath) {
    context.push(
      '/customers/$customerId/image',
      extra: imagePath,
    );
  }
}

// ── Add tile ──────────────────────────────────────────────────────────────────

class _AddTile extends StatelessWidget {
  const _AddTile({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(_Dims.thumbRadius),
      child: SizedBox(
        width: _Dims.addTileWidth,
        height: _Dims.thumbHeight,
        child: Material(
          color: cs.primaryContainer,
          child: InkWell(
            onTap: onTap,
            splashColor: cs.primary.withValues(alpha: AppDimensions.splashAlpha),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_photo_alternate_outlined,
                  color: cs.primary,
                  size: AppDimensions.iconSizeMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Thumbnail ─────────────────────────────────────────────────────────────────

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({
    required this.path,
    required this.onTap,
    required this.onDelete,
  });

  final String path;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(_Dims.thumbRadius),
      child: SizedBox(
        width: _Dims.thumbWidth,
        height: _Dims.thumbHeight,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Photo
            Image.file(
              File(path),
              fit: BoxFit.cover,
              errorBuilder: (ctx, err, stack) => ColoredBox(
                color: cs.surfaceContainerHighest,
                child: Icon(
                  Icons.broken_image_outlined,
                  color: cs.onSurfaceVariant,
                ),
              ),
            ),
            // Ink tap feedback
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                splashColor: Colors.white.withValues(alpha: 0.15),
              ),
            ),
            // Delete badge (top-right)
            Positioned(
              top: 4,
              right: 4,
              child: GestureDetector(
                onTap: onDelete,
                child: Container(
                  width: _Dims.deleteBadge,
                  height: _Dims.deleteBadge,
                  decoration: BoxDecoration(
                    color: cs.errorContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    size: 13,
                    color: cs.onErrorContainer,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
