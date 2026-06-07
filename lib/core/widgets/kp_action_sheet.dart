import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A single action item passed to [KpActionSheet].
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

  /// Destructive actions render the icon and label in [ColorScheme.error].
  final bool isDestructive;
}

/// Modal bottom sheet showing a list of labelled icon actions.
///
/// ```dart
/// KpActionSheet.show(context, actions: [
///   KpAction(icon: Icons.edit_outlined, label: l10n.editCustomerTitle, onTap: _onEdit),
///   KpAction(icon: Icons.delete_outline_rounded, label: l10n.deleteAction,
///            onTap: _onDelete, isDestructive: true),
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
    final cs = Theme.of(context).colorScheme;

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: actions.map((a) {
          final color = a.isDestructive ? cs.error : null;
          return ListTile(
            leading: Icon(a.icon, color: color),
            title: Text(
              a.label,
              style: color != null ? TextStyle(color: color) : null,
            ),
            onTap: () {
              context.pop();
              a.onTap();
            },
          );
        }).toList(),
      ),
    );
  }
}
