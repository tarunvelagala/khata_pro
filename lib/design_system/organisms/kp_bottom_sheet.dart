import 'package:flutter/material.dart';

import '../../core/constants/app_dimensions.dart';

abstract final class _Dims {
  static const double handleTopPadding = 8.0;
}

/// Base bottom sheet surface with standard drag handle, rounded top corners,
/// keyboard inset handling, and optional title header.
///
/// Always call via [KpBottomSheet.show] — never instantiate directly.
/// This ensures the handle, corners, and keyboard padding are consistently applied.
///
/// ```dart
/// await KpBottomSheet.show(context, title: 'Options', child: OptionsContent());
/// ```
class KpBottomSheet {
  KpBottomSheet._();

  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    String? title,
    bool isScrollControlled = true,
  }) =>
      showModalBottomSheet<T>(
        context: context,
        isScrollControlled: isScrollControlled,
        backgroundColor: Colors.transparent,
        builder: (sheetContext) => _KpBottomSheetSurface(
          title: title,
          child: child,
        ),
      );
}

class _KpBottomSheetSurface extends StatelessWidget {
  const _KpBottomSheetSurface({required this.child, this.title});

  final Widget child;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final colorScheme    = Theme.of(context).colorScheme;
    final textTheme      = Theme.of(context).textTheme;
    final keyboardInset  = MediaQuery.viewInsetsOf(context).bottom;
    final borderRadius   = BorderRadius.vertical(
      top: Radius.circular(AppDimensions.radiusLarge),
    );

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: borderRadius,
      ),
      padding: EdgeInsets.only(bottom: keyboardInset),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Padding(
            padding: const EdgeInsets.only(top: _Dims.handleTopPadding),
            child: Container(
              width:  AppDimensions.dragHandleWidth,
              height: AppDimensions.dragHandleThickness,
              decoration: BoxDecoration(
                color: colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
              ),
            ),
          ),

          if (title != null) ...[
            const SizedBox(height: AppDimensions.inputPaddingH),
            Text(
              title!,
              style: textTheme.titleMedium?.copyWith(color: colorScheme.onSurface),
            ),
          ],

          child,
        ],
      ),
    );
  }
}
