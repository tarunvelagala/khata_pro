import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Controls which tab is active in [HomeShell].
/// Use `ref.read(shellNavProvider.notifier).select(1)` to switch tabs.
class ShellNavNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void select(int index) => state = index;
}

final shellNavProvider = NotifierProvider<ShellNavNotifier, int>(
  ShellNavNotifier.new,
);
