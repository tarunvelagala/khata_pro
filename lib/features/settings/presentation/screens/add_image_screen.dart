import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../l10n/app_localizations.dart';

/// Full-screen camera/gallery source picker shown when the merchant
/// wants to add a catalog image to their profile.
///
/// Route: `/profile/add-image`
/// Pops with `ImageSource`.
class AddImageScreen extends StatelessWidget {
  const AddImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs   = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(l10n.catalogAddPhoto),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.buttonPaddingH,
              ),
              leading: Icon(Icons.camera_alt_outlined, color: cs.onSurfaceVariant),
              title: Text(l10n.catalogTakePhoto),
              onTap: () => context.pop(ImageSource.camera),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.buttonPaddingH,
              ),
              leading: Icon(Icons.photo_library_outlined, color: cs.onSurfaceVariant),
              title: Text(l10n.catalogChooseGallery),
              onTap: () => context.pop(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }
}
