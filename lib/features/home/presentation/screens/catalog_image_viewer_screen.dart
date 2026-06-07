import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../l10n/app_localizations.dart';
import '../providers/customer_image_provider.dart';

class CatalogImageViewerScreen extends ConsumerWidget {
  const CatalogImageViewerScreen({
    super.key,
    required this.customerId,
    required this.imagePath,
  });

  final String customerId;
  final String imagePath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final cs   = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.inverseSurface,
      appBar: AppBar(
        backgroundColor: cs.inverseSurface,
        foregroundColor: cs.onInverseSurface,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded),
            onPressed: () => _confirmDelete(context, ref, l10n),
          ),
        ],
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.file(
            File(imagePath),
            errorBuilder: (context, err, stack) => Icon(
              Icons.broken_image_outlined,
              color: cs.onInverseSurface,
              size: 64,
            ),
          ),
        ),
      ),
    );
  }

  void _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.deleteConfirmTitle),
        content: Text(l10n.catalogDeleteConfirm),
        actions: [
          TextButton(
            onPressed: () => ctx.pop(),
            child: Text(l10n.cancelAction),
          ),
          FilledButton(
            onPressed: () {
              ctx.pop();
              ref
                  .read(customerImageProvider(customerId).notifier)
                  .deleteImage(imagePath);
              context.pop();
            },
            child: Text(l10n.deleteAction),
          ),
        ],
      ),
    );
  }
}
