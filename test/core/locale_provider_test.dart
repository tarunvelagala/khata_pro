import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khata_mitra/core/localization/locale_provider.dart';

void main() {
  group('LocaleState', () {
    test('initial locale is English', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(localeStateProvider), const Locale('en'));
    });

    test('setLocale updates state', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container
          .read(localeStateProvider.notifier)
          .setLocale(const Locale('hi'));
      expect(container.read(localeStateProvider), const Locale('hi'));
    });

    test('toggleLocale cycles EN → HI → TE → EN', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(localeStateProvider.notifier);

      expect(container.read(localeStateProvider).languageCode, 'en');

      notifier.toggleLocale();
      expect(container.read(localeStateProvider).languageCode, 'hi');

      notifier.toggleLocale();
      expect(container.read(localeStateProvider).languageCode, 'te');

      notifier.toggleLocale();
      expect(container.read(localeStateProvider).languageCode, 'en');
    });

    test('toggleLocale wraps back to EN from TE', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(localeStateProvider.notifier);
      notifier.setLocale(const Locale('te'));
      notifier.toggleLocale();
      expect(container.read(localeStateProvider).languageCode, 'en');
    });
  });
}
