import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khata_pro/core/theme/app_theme.dart';
import 'package:khata_pro/features/home/domain/models/customer.dart';
import 'package:khata_pro/features/home/domain/models/transaction.dart';
import 'package:khata_pro/features/home/presentation/providers/customer_provider.dart';
import 'package:khata_pro/features/home/presentation/providers/customer_transactions_provider.dart';
import 'package:khata_pro/features/home/presentation/screens/customer_detail_screen.dart';
import 'package:khata_pro/l10n/app_localizations.dart';

// ── Stub notifiers ────────────────────────────────────────────────────────────

class _StubCustomerNotifier extends CustomerNotifier {
  _StubCustomerNotifier(this._data);
  final List<Customer> _data;

  @override
  Stream<List<Customer>> build() => Stream.value(_data);
}

class _StubTxnsNotifier extends CustomerTransactionsNotifier {
  _StubTxnsNotifier(super.customerId, this._data);
  final List<Transaction> _data;

  @override
  Stream<List<Transaction>> build() => Stream.value(_data);
}

// ── Test fixtures ─────────────────────────────────────────────────────────────

const _customer = Customer(
  id: 'c1',
  name: 'Anjali Sharma',
  shopName: 'Boutique',
  netBalance: 1200,
);

final _txns = [
  Transaction(
    id: 't1', customerId: 'c1', customerName: 'Anjali Sharma',
    shopName: 'Boutique', avatarLabel: 'A', amount: 1200,
    isCredit: true, note: 'Delivery payment',
    timestamp: DateTime.now().subtract(const Duration(hours: 1)),
  ),
  Transaction(
    id: 't2', customerId: 'c1', customerName: 'Anjali Sharma',
    shopName: 'Boutique', avatarLabel: 'A', amount: 500,
    isCredit: false,
    timestamp: DateTime.now().subtract(const Duration(days: 2)),
  ),
];

// ── Harness ───────────────────────────────────────────────────────────────────

Widget _wrap({
  Customer customer = _customer,
  List<Transaction> txns = const [],
  Locale locale = const Locale('en'),
}) {
  return ProviderScope(
    overrides: [
      customerProvider.overrideWith(
        () => _StubCustomerNotifier([customer]),
      ),
      customerTransactionsProvider(customer.id).overrideWith(
        () => _StubTxnsNotifier(customer.id, txns),
      ),
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
      home: CustomerDetailScreen(customerId: customer.id),
    ),
  );
}

Future<void> _pump(WidgetTester tester, Widget widget, {Size size = const Size(390, 844)}) async {
  tester.view.physicalSize = Size(size.width * 2, size.height * 2);
  tester.view.devicePixelRatio = 2.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(widget);
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
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

  group('CustomerDetailScreen — hero band', () {
    for (final locale in locales) {
      for (final size in [const Size(360, 640), const Size(390, 844)]) {
        testWidgets(
          '${locale.languageCode} on ${size.width.toInt()}×${size.height.toInt()}',
          (tester) async {
            await _pump(tester, _wrap(locale: locale), size: size);
            _expectNoOverflow(tester);

            // Customer name and shop must appear in the hero band.
            expect(find.text('Anjali Sharma'), findsWidgets);
            expect(find.text('Boutique'),      findsWidgets);
          },
        );
      }
    }
  });

  group('CustomerDetailScreen — transaction list', () {
    testWidgets('shows transactions when present', (tester) async {
      await _pump(tester, _wrap(txns: _txns));

      // Notes and direction text should be visible
      expect(find.text('Delivery payment'), findsOneWidget);
      // Date headers: "Today" + "2 days ago" group
      expect(find.text('Today'), findsOneWidget);
    });

    testWidgets('shows empty state when no transactions', (tester) async {
      await _pump(tester, _wrap(txns: []));

      final l10n = await AppLocalizations.delegate.load(const Locale('en'));
      expect(find.text(l10n.customerDetailNoEntries), findsOneWidget);
    });

    testWidgets('FAB is present', (tester) async {
      await _pump(tester, _wrap(txns: _txns));
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });
  });

  group('CustomerDetailScreen — balance semantics', () {
    testWidgets('"owes you" label for positive balance', (tester) async {
      await _pump(tester, _wrap(customer: _customer)); // netBalance = 1200
      final l10n = await AppLocalizations.delegate.load(const Locale('en'));
      expect(find.text(l10n.customerDetailOwesYou), findsOneWidget);
    });

    testWidgets('"you owe" label for negative balance', (tester) async {
      const negCustomer = Customer(
        id: 'c2', name: 'Ravi', netBalance: -300,
      );
      await _pump(tester, _wrap(
        customer: negCustomer,
        txns: [],
      ));
      final l10n = await AppLocalizations.delegate.load(const Locale('en'));
      expect(find.text(l10n.customerDetailYouOwe), findsOneWidget);
    });

    testWidgets('"settled" label for zero balance', (tester) async {
      const zeroCustomer = Customer(
        id: 'c3', name: 'Priya', netBalance: 0,
      );
      await _pump(tester, _wrap(
        customer: zeroCustomer,
        txns: [],
      ));
      final l10n = await AppLocalizations.delegate.load(const Locale('en'));
      expect(find.text(l10n.customerDetailSettled), findsOneWidget);
    });
  });
}
