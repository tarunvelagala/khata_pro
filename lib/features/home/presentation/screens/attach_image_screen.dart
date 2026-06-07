import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../l10n/app_localizations.dart';

/// Route payload for [AttachImageScreen].
class AttachImageExtra {
  const AttachImageExtra({
    required this.message,
    required this.imagePaths,
  });

  final String       message;
  final List<String> imagePaths;
}

/// Result returned when the user completes the attach-image screen.
/// [imagePath] is null when the user chose "send without image".
class AttachResult {
  const AttachResult({this.imagePath});
  final String? imagePath;
}

/// Full-screen catalog image picker shown before sending a reminder.
///
/// Route: `/reminder/attach`, `extra: AttachImageExtra`
/// Pops with `AttachResult`.
class AttachImageScreen extends StatefulWidget {
  const AttachImageScreen({super.key, required this.extra});

  final AttachImageExtra extra;

  @override
  State<AttachImageScreen> createState() => _AttachImageScreenState();
}

class _AttachImageScreenState extends State<AttachImageScreen> {
  int _selectedIndex = 0;

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
        title: Text(l10n.reminderAttachTitle),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppDimensions.inputPaddingV),
            SizedBox(
              height: AppDimensions.attachSheetStripHeight,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.buttonPaddingH,
                ),
                itemCount: widget.extra.imagePaths.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(width: AppDimensions.attachSheetThumbGap),
                itemBuilder: (_, i) {
                  final path       = widget.extra.imagePaths[i];
                  final isSelected = i == _selectedIndex;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedIndex = i),
                    child: Container(
                      width: AppDimensions.attachSheetThumbWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.attachSheetThumbRadius,
                        ),
                        border: Border.all(
                          color: isSelected ? cs.primary : Colors.transparent,
                          width: AppDimensions.attachSheetSelectedBorder,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.attachSheetThumbInnerRadius,
                        ),
                        child: Image.file(
                          File(path),
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => ColoredBox(
                            color: cs.surfaceContainerLow,
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
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.buttonPaddingH,
              ),
              child: FilledButton(
                onPressed: () => context.pop(
                  AttachResult(
                    imagePath: widget.extra.imagePaths[_selectedIndex],
                  ),
                ),
                child: Text(l10n.reminderSendWithImage),
              ),
            ),
            const SizedBox(height: AppDimensions.buttonStackGap),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.buttonPaddingH,
              ),
              child: OutlinedButton(
                onPressed: () => context.pop(const AttachResult()),
                child: Text(l10n.reminderSendWithoutImage),
              ),
            ),
            const SizedBox(height: AppDimensions.inputPaddingV),
          ],
        ),
      ),
    );
  }
}
