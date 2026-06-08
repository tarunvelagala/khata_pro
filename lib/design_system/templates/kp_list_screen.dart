import 'package:flutter/material.dart';

import '../../core/constants/app_dimensions.dart';

/// Sliver-based list screen template.
///
/// Composes a [CustomScrollView] with a collapsing [sliverAppBar], the
/// caller-supplied [sliver] (e.g. `SliverList`), and an automatic
/// `SliverPadding` at the bottom so FAB actions never obscure list items.
///
/// ```dart
/// KpListScreen(
///   sliverAppBar: SliverAppBar(...),
///   sliver: SliverList(delegate: ...),
///   fab: FloatingActionButton(...),
/// )
/// ```
class KpListScreen extends StatelessWidget {
  const KpListScreen({
    super.key,
    required this.sliverAppBar,
    required this.sliver,
    this.fab,
    this.backgroundColor,
  });

  final Widget sliverAppBar;
  final Widget sliver;
  final Widget? fab;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: fab,
      body: CustomScrollView(
        slivers: [
          sliverAppBar,
          sliver,
          SliverPadding(
            padding: EdgeInsets.only(
              bottom: fab != null ? AppDimensions.fabClearance : 0,
            ),
          ),
        ],
      ),
    );
  }
}
