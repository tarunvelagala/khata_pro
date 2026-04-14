import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khata_pro/features/onboarding/presentation/providers/onboarding_providers.dart';

void main() {
  // ── AppLanguage enum ──────────────────────────────────────────────────────

  group('AppLanguage', () {
    test('has exactly 8 values', () {
      expect(AppLanguage.values.length, 8);
    });

    test('contains the expected languages', () {
      final codes = AppLanguage.values.map((l) => l.code).toSet();
      expect(codes, containsAll(['en', 'hi', 'kn', 'ta', 'bn', 'mr', 'ml', 'te']));
    });

    test('each language has non-empty nativeName, englishName, and code', () {
      for (final lang in AppLanguage.values) {
        expect(lang.nativeName, isNotEmpty, reason: '${lang.name}.nativeName');
        expect(lang.englishName, isNotEmpty, reason: '${lang.name}.englishName');
        expect(lang.code, isNotEmpty, reason: '${lang.name}.code');
      }
    });

    test('all language codes are unique', () {
      final codes = AppLanguage.values.map((l) => l.code).toList();
      expect(codes.toSet().length, codes.length);
    });

    test('english has correct tokens', () {
      expect(AppLanguage.english.englishName, 'Default');
      expect(AppLanguage.english.code, 'en');
    });

    test('hindi has correct tokens', () {
      expect(AppLanguage.hindi.nativeName, 'हिन्दी');
      expect(AppLanguage.hindi.code, 'hi');
    });

    test('malayalam has correct tokens', () {
      expect(AppLanguage.malayalam.nativeName, 'മലയാളം');
      expect(AppLanguage.malayalam.code, 'ml');
    });
  });

  // ── SelectedLanguageNotifier ──────────────────────────────────────────────

  group('SelectedLanguageNotifier', () {
    ProviderContainer makeContainer() => ProviderContainer();

    test('initial state is english', () {
      final container = makeContainer();
      addTearDown(container.dispose);
      expect(container.read(selectedLanguageProvider), AppLanguage.english);
    });

    test('select() updates state', () {
      final container = makeContainer();
      addTearDown(container.dispose);

      container.read(selectedLanguageProvider.notifier).select(AppLanguage.hindi);
      expect(container.read(selectedLanguageProvider), AppLanguage.hindi);
    });

    test('select() can switch between languages', () {
      final container = makeContainer();
      addTearDown(container.dispose);

      container.read(selectedLanguageProvider.notifier).select(AppLanguage.tamil);
      expect(container.read(selectedLanguageProvider), AppLanguage.tamil);

      container.read(selectedLanguageProvider.notifier).select(AppLanguage.bengali);
      expect(container.read(selectedLanguageProvider), AppLanguage.bengali);
    });

    test('each container is independent', () {
      final c1 = makeContainer();
      final c2 = makeContainer();
      addTearDown(c1.dispose);
      addTearDown(c2.dispose);

      c1.read(selectedLanguageProvider.notifier).select(AppLanguage.kannada);
      expect(c1.read(selectedLanguageProvider), AppLanguage.kannada);
      expect(c2.read(selectedLanguageProvider), AppLanguage.english);
    });
  });

  // ── ThemeModeNotifier ─────────────────────────────────────────────────────

  group('ThemeModeNotifier', () {
    ProviderContainer makeContainer() => ProviderContainer();

    test('initial state is ThemeMode.system', () {
      final container = makeContainer();
      addTearDown(container.dispose);
      expect(container.read(themeModeProvider), ThemeMode.system);
    });

    test('select(light) updates state', () {
      final container = makeContainer();
      addTearDown(container.dispose);

      container.read(themeModeProvider.notifier).select(ThemeMode.light);
      expect(container.read(themeModeProvider), ThemeMode.light);
    });

    test('select(dark) updates state', () {
      final container = makeContainer();
      addTearDown(container.dispose);

      container.read(themeModeProvider.notifier).select(ThemeMode.dark);
      expect(container.read(themeModeProvider), ThemeMode.dark);
    });

    test('can switch from dark back to system', () {
      final container = makeContainer();
      addTearDown(container.dispose);

      container.read(themeModeProvider.notifier).select(ThemeMode.dark);
      container.read(themeModeProvider.notifier).select(ThemeMode.system);
      expect(container.read(themeModeProvider), ThemeMode.system);
    });
  });

  // ── BusinessType enum ─────────────────────────────────────────────────────

  group('BusinessType', () {
    test('has exactly 6 values', () {
      expect(BusinessType.values.length, 6);
    });

    test('each value has an icon', () {
      for (final type in BusinessType.values) {
        expect(type.icon, isNotNull, reason: '${type.name}.icon');
      }
    });
  });

  // ── ShopDetails ───────────────────────────────────────────────────────────

  group('ShopDetails', () {
    test('default instance has empty name and null businessType', () {
      const details = ShopDetails();
      expect(details.name, '');
      expect(details.businessType, isNull);
    });

    test('isValid is false when name is empty', () {
      const details = ShopDetails(businessType: BusinessType.retail);
      expect(details.isValid, isFalse);
    });

    test('isValid is false when businessType is null', () {
      const details = ShopDetails(name: 'Sharma Store');
      expect(details.isValid, isFalse);
    });

    test('isValid is true when both name and businessType are set', () {
      const details = ShopDetails(name: 'Sharma Store', businessType: BusinessType.retail);
      expect(details.isValid, isTrue);
    });

    test('isValid treats whitespace-only name as invalid', () {
      const details = ShopDetails(name: '   ', businessType: BusinessType.retail);
      expect(details.isValid, isFalse);
    });

    test('copyWith updates name', () {
      const original = ShopDetails(name: 'Old', businessType: BusinessType.services);
      final updated = original.copyWith(name: 'New');
      expect(updated.name, 'New');
      expect(updated.businessType, BusinessType.services);
    });

    test('copyWith updates businessType', () {
      const original = ShopDetails(name: 'Store', businessType: BusinessType.retail);
      final updated = original.copyWith(businessType: BusinessType.pharmacy);
      expect(updated.name, 'Store');
      expect(updated.businessType, BusinessType.pharmacy);
    });

    test('copyWith preserves original when called with no arguments', () {
      const original = ShopDetails(name: 'Store', businessType: BusinessType.wholesale);
      final copy = original.copyWith();
      expect(copy.name, original.name);
      expect(copy.businessType, original.businessType);
    });
  });

  // ── ShopDetailsNotifier ───────────────────────────────────────────────────

  group('ShopDetailsNotifier', () {
    ProviderContainer makeContainer() => ProviderContainer();

    test('initial state is empty ShopDetails', () {
      final container = makeContainer();
      addTearDown(container.dispose);

      final state = container.read(shopDetailsProvider);
      expect(state.name, '');
      expect(state.businessType, isNull);
      expect(state.isValid, isFalse);
    });

    test('setName() updates name', () {
      final container = makeContainer();
      addTearDown(container.dispose);

      container.read(shopDetailsProvider.notifier).setName('Test Shop');
      expect(container.read(shopDetailsProvider).name, 'Test Shop');
    });

    test('setBusinessType() updates businessType', () {
      final container = makeContainer();
      addTearDown(container.dispose);

      container.read(shopDetailsProvider.notifier).setBusinessType(BusinessType.restaurant);
      expect(container.read(shopDetailsProvider).businessType, BusinessType.restaurant);
    });

    test('state becomes valid after setting both name and businessType', () {
      final container = makeContainer();
      addTearDown(container.dispose);

      container.read(shopDetailsProvider.notifier).setName('Ramu Kirana');
      expect(container.read(shopDetailsProvider).isValid, isFalse);

      container.read(shopDetailsProvider.notifier).setBusinessType(BusinessType.retail);
      expect(container.read(shopDetailsProvider).isValid, isTrue);
    });

    test('setName() does not reset businessType', () {
      final container = makeContainer();
      addTearDown(container.dispose);

      container.read(shopDetailsProvider.notifier).setBusinessType(BusinessType.wholesale);
      container.read(shopDetailsProvider.notifier).setName('New Name');
      expect(container.read(shopDetailsProvider).businessType, BusinessType.wholesale);
    });

    test('setBusinessType() does not reset name', () {
      final container = makeContainer();
      addTearDown(container.dispose);

      container.read(shopDetailsProvider.notifier).setName('My Shop');
      container.read(shopDetailsProvider.notifier).setBusinessType(BusinessType.other);
      expect(container.read(shopDetailsProvider).name, 'My Shop');
    });

    test('each container is independent', () {
      final c1 = makeContainer();
      final c2 = makeContainer();
      addTearDown(c1.dispose);
      addTearDown(c2.dispose);

      c1.read(shopDetailsProvider.notifier).setName('Shop A');
      expect(c1.read(shopDetailsProvider).name, 'Shop A');
      expect(c2.read(shopDetailsProvider).name, '');
    });
  });
}
