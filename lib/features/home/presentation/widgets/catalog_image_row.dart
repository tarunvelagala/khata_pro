import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/customer_image_provider.dart';

abstract final class _Dims {
  static const double rowHeight     = 80.0;
  static const double thumbWidth    = 56.0;
  static const double thumbRadius   = 8.0;
  static const double addTileWidth  = 56.0;
  static const double tileGap       = 8.0;
  static const double sheetPaddingV = 8.0;
}

class CatalogImageRow extends ConsumerWidget {
  const CatalogImageRow({super.key, required this.customerId});

  final String customerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n   = AppLocalizations.of(context)!;
    final paths  = ref.watch(customerImageProvider(customerId));

    return SizedBox(
      height: _Dims.rowHeight,
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
            ),
          ],
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
            const SizedBox(height: _Dims.sheetPaddingV),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: Text(l10n.catalogTakePhoto),
              onTap: () {
                context.pop();
                ref
                    .read(customerImageProvider(customerId).notifier)
                    .addImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: Text(l10n.catalogChooseGallery),
              onTap: () {
                context.pop();
                ref
                    .read(customerImageProvider(customerId).notifier)
                    .addImage(ImageSource.gallery);
              },
            ),
            const SizedBox(height: _Dims.sheetPaddingV),
          ],
        ),
      ),
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

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: _Dims.addTileWidth,
        height: _Dims.rowHeight,
        decoration: BoxDecoration(
          color: cs.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(_Dims.thumbRadius),
          border: Border.all(
            color: cs.outline.withValues(alpha: 0.4),
          ),
        ),
        child: Icon(
          Icons.add_photo_alternate_outlined,
          color: cs.onSurfaceVariant,
        ),
      ),
    );
  }
}

// ── Thumbnail ─────────────────────────────────────────────────────────────────

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({required this.path, required this.onTap});

  final String path;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_Dims.thumbRadius),
        child: SizedBox(
          width: _Dims.thumbWidth,
          height: _Dims.rowHeight,
          child: Image.file(
            File(path),
            fit: BoxFit.cover,
            errorBuilder: (context, err, stack) => const Icon(Icons.broken_image_outlined),
          ),
        ),
      ),
    );
  }
}
