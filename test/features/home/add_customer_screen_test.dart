import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khata_pro/core/services/contacts_service.dart';
import 'package:khata_pro/core/theme/app_theme.dart';
import 'package:khata_pro/features/home/domain/models/customer.dart';
import 'package:khata_pro/features/home/presentation/providers/customer_provider.dart';
import 'package:khata_pro/features/home/presentation/screens/add_customer_screen.dart';
import 'package:khata_pro/l10n/app_localizations.dart';

// ── Stubs ─────────────────────────────────────────────────────────────────────

class _RecordingCustomerNotifier extends CustomerNotifier {
  Customer? inserted;

  @override
  Stream<List<Customer>> build() => Stream.value([]);

  @override
  Future<void> addCustomer(Customer c) async {
    inserted = c;
  }
}

/// Contacts service stub: permission always granted, createContact returns null
/// (no actual device contact created during tests).
class _StubContactsService extends ContactsService {
  @override
  Future<bool> requestPermission() async => true;

  @override
  Future<({String id, String name, String? phone})?> pickContact() async => null;

  @override
  Future<String?> createContact({required String name, String? phone}) async => null;
}

// ── Harness ───────────────────────────────────────────────────────────────────

Widget _wrap(
  _RecordingCustomerNotifier notifier, {
  Locale locale = const Locale('en'),
}) {
  return ProviderScope(
    overrides: [
      customerProvider.overrideWith(() => notifier),
      contactsServiceProvider.overrideWithValue(_StubContactsService()),
    ],
    child: MaterialApp(
      theme: AppTheme.light,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const AddCustomerScreen(),
    ),
  );
}

Future<void> _pump(
  WidgetTester tester,
  _RecordingCustomerNotifier notifier, {
  Size size = const Size(390, 844),
  Locale locale = const Locale('en'),
}) async {
  tester.view.physicalSize = Size(size.width * 2, size.height * 2);
  tester.view.devicePixelRatio = 2.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(_wrap(notifier, locale: locale));
  await tester.pump();
}

void _expectNoOverflow(WidgetTester tester) {
  final ex = tester.takeException();
  if (ex != null) {
    final msg = ex.toString();
    if (msg.contains('overflowed') || msg.contains('RenderFlex')) fail('Overflow: $msg');
  }
}

// ── Tests ─────────────────────────────────────────────────────────────────────

void main() {
  const locales = [
    Locale('en'), Locale('hi'), Locale('mr'), Locale('bn'),
    Locale('kn'), Locale('ta'), Locale('ml'), Locale('te'),
  ];

  const sizes = {
    '360×640': Size(360, 640),
    '390×844': Size(390, 844),
  };

  group('AddCustomerScreen — layout + overflow', () {
    for (final locale in locales) {
      for (final entry in sizes.entries) {
        testWidgets(
          '${locale.languageCode} on ${entry.key}',
          (tester) async {
            final notifier = _RecordingCustomerNotifier();
            await _pump(tester, notifier, size: entry.value, locale: locale);
            _expectNoOverflow(tester);

            final l10n = await AppLocalizations.delegate.load(locale);
            expect(find.text(l10n.addCustomerTitle), findsOneWidget);
            expect(find.text(l10n.addCustomerSave),  findsOneWidget);
          },
        );
      }
    }
  });

  group('AddCustomerScreen — validation', () {
    testWidgets('empty name shows required error', (tester) async {
      final notifier = _RecordingCustomerNotifier();
      await _pump(tester, notifier);

      final l10n = await AppLocalizations.delegate.load(const Locale('en'));

      // Tap save without filling any field.
      await tester.tap(find.text(l10n.addCustomerSave));
      await tester.pump();

      expect(find.text(l10n.addCustomerNameRequired), findsOneWidget);
      expect(notifier.inserted, isNull);
    });

    testWidgets('invalid phone shows error', (tester) async {
      final notifier = _RecordingCustomerNotifier();
      await _pump(tester, notifier);

      final l10n = await AppLocalizations.delegate.load(const Locale('en'));

      await tester.enterText(find.byType(TextFormField).at(0), 'Ravi Kumar');
      await tester.enterText(find.byType(TextFormField).at(1), '123'); // too short
      await tester.tap(find.text(l10n.addCustomerSave));
      await tester.pump();

      expect(find.text(l10n.addCustomerPhoneInvalid), findsOneWidget);
      expect(notifier.inserted, isNull);
    });

    testWidgets('valid form inserts customer', (tester) async {
      final notifier = _RecordingCustomerNotifier();
      await _pump(tester, notifier);

      final l10n = await AppLocalizations.delegate.load(const Locale('en'));

      await tester.enterText(find.byType(TextFormField).at(0), 'Anjali Sharma');
      await tester.enterText(find.byType(TextFormField).at(1), '9876543210');
      await tester.enterText(find.byType(TextFormField).at(2), 'Boutique');
      await tester.enterText(find.byType(TextFormField).at(3), '500');

      await tester.tap(find.text(l10n.addCustomerSave));
      await tester.pump();

      expect(notifier.inserted, isNotNull);
      expect(notifier.inserted!.name, 'Anjali Sharma');
      expect(notifier.inserted!.phone, '9876543210');
      expect(notifier.inserted!.shopName, 'Boutique');
      // "They owe me" selected by default → positive balance
      expect(notifier.inserted!.netBalance, 500.0);
    });

    testWidgets('"I owe them" direction gives negative balance', (tester) async {
      final notifier = _RecordingCustomerNotifier();
      await _pump(tester, notifier);

      final l10n = await AppLocalizations.delegate.load(const Locale('en'));

      await tester.enterText(find.byType(TextFormField).at(0), 'Priya');
      await tester.enterText(find.byType(TextFormField).at(3), '200');

      // Toggle to "I owe them"
      await tester.tap(find.text(l10n.addCustomerDirectionIOwe));
      await tester.pump();

      await tester.tap(find.text(l10n.addCustomerSave));
      await tester.pump();

      expect(notifier.inserted!.netBalance, -200.0);
    });

    testWidgets('zero/empty balance defaults to 0.0', (tester) async {
      final notifier = _RecordingCustomerNotifier();
      await _pump(tester, notifier);

      final l10n = await AppLocalizations.delegate.load(const Locale('en'));

      await tester.enterText(find.byType(TextFormField).at(0), 'Sam');
      await tester.tap(find.text(l10n.addCustomerSave));
      await tester.pump();

      expect(notifier.inserted!.netBalance, 0.0);
    });
  });
}
