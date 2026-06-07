import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/presentation/providers/app_lock_provider.dart';
import '../../features/auth/presentation/screens/app_lock_screen.dart';

/// Wraps the root widget tree and shows a lock overlay whenever
/// the app is brought back to the foreground and lock is enabled.
class AppLockWrapper extends ConsumerStatefulWidget {
  const AppLockWrapper({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<AppLockWrapper> createState() => _AppLockWrapperState();
}

class _AppLockWrapperState extends ConsumerState<AppLockWrapper>
    with WidgetsBindingObserver {
  bool _locked = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      final lockState = ref.read(appLockProvider).asData?.value;
      if (lockState?.enabled == true) {
        setState(() => _locked = true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final lockState = ref.watch(appLockProvider).asData?.value;
    final shouldLock = _locked && (lockState?.enabled == true);

    if (shouldLock) {
      return AppLockScreen(
        onUnlocked: () => setState(() => _locked = false),
      );
    }

    return widget.child;
  }
}
