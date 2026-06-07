import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khata_pro/features/auth/presentation/providers/app_lock_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('AppLockNotifier', () {
    test('initial state: disabled, no pin', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final state = await container.read(appLockProvider.future);
      expect(state.enabled, isFalse);
      expect(state.pinSet, isFalse);
    });

    test('setPin sets pinSet to true', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      await container.read(appLockProvider.future);
      await container.read(appLockProvider.notifier).setPin('1234');

      final state = container.read(appLockProvider).requireValue;
      expect(state.pinSet, isTrue);
    });

    test('verifyPin returns true for correct pin', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      await container.read(appLockProvider.future);
      await container.read(appLockProvider.notifier).setPin('1234');

      final ok = await container.read(appLockProvider.notifier).verifyPin('1234');
      expect(ok, isTrue);
    });

    test('verifyPin returns false for wrong pin', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      await container.read(appLockProvider.future);
      await container.read(appLockProvider.notifier).setPin('1234');

      final ok = await container.read(appLockProvider.notifier).verifyPin('0000');
      expect(ok, isFalse);
    });

    test('clearPin resets state to disabled with no pin', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      await container.read(appLockProvider.future);
      await container.read(appLockProvider.notifier).setPin('1234');
      await container.read(appLockProvider.notifier).setEnabled(true);
      await container.read(appLockProvider.notifier).clearPin();

      final state = container.read(appLockProvider).requireValue;
      expect(state.enabled, isFalse);
      expect(state.pinSet, isFalse);
    });
  });
}
