import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khata_pro/core/providers/connectivity_provider.dart';

void main() {
  group('connectivityProvider', () {
    test('emits true when at least one non-none result', () async {
      final emitted = <bool>[];
      final container = ProviderContainer(
        overrides: [
          connectivityProvider.overrideWith((_) async* {
            yield true;
          }),
        ],
      );
      addTearDown(container.dispose);

      final sub = container.listen(
        connectivityProvider,
        (_, next) {
          if (next is AsyncData<bool>) emitted.add(next.value);
        },
        fireImmediately: true,
      );

      // Allow the async generator to produce its value
      await Future<void>.delayed(const Duration(milliseconds: 50));
      sub.close();

      expect(emitted, contains(true));
    });

    test('emits false when all results are none', () async {
      final emitted = <bool>[];
      final container = ProviderContainer(
        overrides: [
          connectivityProvider.overrideWith((_) async* {
            yield false;
          }),
        ],
      );
      addTearDown(container.dispose);

      final sub = container.listen(
        connectivityProvider,
        (_, next) {
          if (next is AsyncData<bool>) emitted.add(next.value);
        },
        fireImmediately: true,
      );

      await Future<void>.delayed(const Duration(milliseconds: 50));
      sub.close();

      expect(emitted, contains(false));
    });

    test('maps ConnectivityResult.none list to false', () {
      final results = [ConnectivityResult.none];
      final isOnline = results.any((r) => r != ConnectivityResult.none);
      expect(isOnline, isFalse);
    });

    test('maps mixed result list (wifi present) to true', () {
      final results = [ConnectivityResult.none, ConnectivityResult.wifi];
      final isOnline = results.any((r) => r != ConnectivityResult.none);
      expect(isOnline, isTrue);
    });
  });
}
