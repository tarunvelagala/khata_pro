import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A back-navigation icon button using [Icons.arrow_back_rounded].
///
/// Drop-in replacement for an [AppBar] `leading:` or anywhere a standalone
/// back affordance is needed.  When [onPressed] is omitted, defaults to
/// [GoRouter.of] pop — i.e. the same behaviour as Flutter's built-in back
/// button but consistent with the go_router navigation stack.
class KpBackButton extends StatelessWidget {
  const KpBackButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_rounded),
      onPressed: onPressed ?? (context.canPop() ? () => context.pop() : null),
    );
  }
}
