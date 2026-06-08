import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A single action item for [KpActionSheet].
class KpAction {
  const KpAction({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  /// When true, icon and label render in [ColorScheme.error].
  final bool isDestructive;
}

/// Modal bottom sheet showing a list of labelled icon actions.
///
/// ```dart
/// KpActionSheet.show(context, actions: [
///   KpAction(icon: Icons.edit_outlined, label: 'Edit', onTap: _edit),
///   KpAction(icon: Icons.delete_outline_rounded, label: 'Delete',
///            onTap: _delete, isDestructive: true),
/// ]);
/// ```
class KpActionSheet extends StatelessWidget {
  const KpActionSheet({super.key, required this.actions});

  final List<KpAction> actions;

  static void show(BuildContext context, {required List<KpAction> actions}) {
    showModalBottomSheet<void>(
      context: context,
      builder: (_) => KpActionSheet(actions: actions),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: actions.map((action) {
          final actionColor = action.isDestructive ? colorScheme.error : null;
          return ListTile(
            leading: Icon(action.icon, color: actionColor),
            title: Text(
              action.label,
              style: actionColor != null ? TextStyle(color: actionColor) : null,
            ),
            onTap: () {
              context.pop();
              action.onTap();
            },
          );
        }).toList(),
      ),
    );
  }
}
