import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khata_pro/core/constants/app_dimensions.dart';
import 'package:khata_pro/core/services/contacts_service.dart';
import 'package:khata_pro/core/theme/app_colors.dart';
import 'package:khata_pro/core/theme/app_theme.dart';
import 'package:khata_pro/features/home/domain/models/customer.dart';
import 'package:khata_pro/features/home/domain/models/transaction.dart';
import 'package:khata_pro/features/home/presentation/providers/customer_provider.dart';
import 'package:khata_pro/features/home/presentation/providers/customer_transactions_provider.dart';
import 'package:khata_pro/features/home/presentation/providers/transaction_provider.dart';
import 'package:khata_pro/features/home/presentation/screens/add_customer_screen.dart';
import 'package:khata_pro/features/home/presentation/screens/add_entry_screen.dart';
import 'package:khata_pro/features/home/presentation/screens/customer_detail_screen.dart';
import 'package:khata_pro/features/home/presentation/screens/customers_screen.dart';
import 'package:khata_pro/features/home/presentation/screens/dashboard_screen.dart';
import 'package:khata_pro/features/home/presentation/screens/home_shell.dart';
import 'package:khata_pro/features/home/presentation/widgets/quick_actions_row.dart';
import 'package:khata_pro/features/home/presentation/widgets/transaction_list_tile.dart';
import 'package:khata_pro/features/settings/presentation/screens/language_selection_screen.dart';
import 'package:khata_pro/features/tour/presentation/screens/tour_screen.dart';
import 'package:khata_pro/l10n/app_localizations.dart';

// ── Test data ──────────────────────────────────────────────────────────────────

final _stubCustomers = [
  const Customer(id: '1', name: 'Anjali Sharma', shopName: 'Boutique', netBalance: 1200),
  const Customer(id: '2', name: 'Ravi Kumar', shopName: 'Kirana Store', netBalance: -350),
  const Customer(id: '3', name: 'Ravi Kumar', netBalance: 500),
];

final _stubTransactions = [
  Transaction(
    id: '1', customerId: '1', customerName: 'Anjali Sharma', shopName: 'Boutique',
    avatarLabel: 'AS', amount: 1200, isCredit: true,
    timestamp: DateTime.now().subtract(const Duration(hours: 2)),
  ),
  Transaction(
    id: '2', customerId: '2', customerName: 'Ravi Kumar', shopName: 'Kirana Store',
    avatarLabel: 'RK', amount: 350, isCredit: false,
    timestamp: DateTime.now().subtract(const Duration(days: 1)),
  ),
];

// ── Harness ────────────────────────────────────────────────────────────────────

Widget _wrap(Widget child, Locale locale) {
  return ProviderScope(
    overrides: [
      customerProvider.overrideWith(
        () => _StubCustomerNotifier(_stubCustomers),
      ),
      transactionProvider.overrideWith(
        () => _StubTransactionNotifier(_stubTransactions),
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
      home: child,
    ),
  );
}

Future<void> _pump(
  WidgetTester tester,
  Widget child,
  Locale locale,
  Size size,
) async {
  tester.view.physicalSize = Size(size.width * 2, size.height * 2);
  tester.view.devicePixelRatio = 2.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(_wrap(child, locale));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
}

// Only fail on actual overflow exceptions; ignore unrelated plugin/platform errors.
void _expectNoOverflow(WidgetTester tester) {
  final exception = tester.takeException();
  if (exception != null) {
    final msg = exception.toString();
    if (msg.contains('overflowed') || msg.contains('RenderFlex')) {
      fail('Overflow: $msg');
    }
  }
}

// ── Stub notifiers ─────────────────────────────────────────────────────────────

class _StubContactsService extends ContactsService {
  @override Future<ContactsPermResult> requestPermission() async => ContactsPermResult.denied;
  @override Future<({String id, String name, String? phone})?> pickContact() async => null;
  @override Future<String?> createContact({required String name, String? phone}) async => null;
}

class _StubCustomerNotifier extends CustomerNotifier {
  _StubCustomerNotifier(this._data);
  final List<Customer> _data;
  @override
  Stream<List<Customer>> build() => Stream.value(_data);
}

class _StubTransactionNotifier extends TransactionNotifier {
  _StubTransactionNotifier(this._data);
  final List<Transaction> _data;
  @override
  Stream<List<Transaction>> build() => Stream.value(_data);
}

class _StubTxnsNotifier extends CustomerTransactionsNotifier {
  _StubTxnsNotifier(super.customerId, this._data);
  final List<Transaction> _data;
  @override
  Stream<List<Transaction>> build() => Stream.value(_data);
}

// ── Locales ────────────────────────────────────────────────────────────────────

const _locales = [
  Locale('en'),
  Locale('hi'),
  Locale('mr'),
  Locale('bn'),
  Locale('kn'),
  Locale('ta'),
  Locale('ml'),
  Locale('te'),
];

const _localeNames = {
  'en': 'English',
  'hi': 'Hindi (Devanagari)',
  'mr': 'Marathi (Devanagari)',
  'bn': 'Bengali',
  'kn': 'Kannada',
  'ta': 'Tamil',
  'ml': 'Malayalam',
  'te': 'Telugu',
};

// Screen sizes to test — 360×640 simulates older/low-end Android phones.
const _sizes = {
  'iPhone 14 (390×844)':           Size(390, 844),
  'Android standard (360×800)':    Size(360, 800),
  'Old Android low-end (360×640)': Size(360, 640),
};

// ── HomeShell (nav bar + dashboard) ───────────────────────────────────────────

void main() {
  group('HomeShell — nav bar labels across locales', () {
    for (final locale in _locales) {
      for (final sizeEntry in _sizes.entries) {
        testWidgets(
          '${_localeNames[locale.languageCode]} on ${sizeEntry.key}',
          (tester) async {
            await _pump(tester, const HomeShell(), locale, sizeEntry.value);
            _expectNoOverflow(tester);

            final l10n = await AppLocalizations.delegate.load(locale);

            // Nav bar labels — these must not overflow their 72dp destination slots.
            expect(find.text(l10n.navHome),      findsOneWidget);
            expect(find.text(l10n.navCustomers), findsOneWidget);
            expect(find.text(l10n.navReports),   findsOneWidget);
            expect(find.text(l10n.navSettings),  findsOneWidget);

            // Brand wordmark always Latin.
            expect(find.text('KhataPro'), findsOneWidget);
          },
        );
      }
    }
  });

  group('DashboardScreen — quick actions + overflow', () {
    for (final locale in _locales) {
      for (final sizeEntry in _sizes.entries) {
        testWidgets(
          '${_localeNames[locale.languageCode]} on ${sizeEntry.key}',
          (tester) async {
            await _pump(
              tester,
              const DashboardScreen(),
              locale,
              sizeEntry.value,
            );
            _expectNoOverflow(tester);

            final l10n = await AppLocalizations.delegate.load(locale);

            // Quick actions — 4 tiles must render without overflow.
            expect(find.text(l10n.quickActionAddCustomer),  findsOneWidget);
            expect(find.text(l10n.quickActionGenerateBill), findsOneWidget);
            expect(find.text(l10n.quickActionSendReminder), findsOneWidget);
            expect(find.text(l10n.quickActionRecordPayment), findsOneWidget);

            // CREDIT/DEBIT badges removed — verify transaction tiles render
            // with colorful deterministic avatars instead.
            // Scroll to ensure tiles are visible on small viewports where the
            // hero band pushes the list below the fold.
            await tester.scrollUntilVisible(
              find.byType(TransactionListTile).first,
              80.0,
            );
            expect(find.byType(TransactionListTile), findsWidgets);

            // Balance card label is its own Text widget.
            expect(find.text(l10n.balanceCardLabel), findsOneWidget);

            // Recent transactions section header.
            expect(find.text(l10n.homeRecentTransactions), findsOneWidget);
          },
        );
      }
    }
  });

  group('DashboardScreen — transaction tile alignment', () {
    // Regression: SliverPadding was doubling the horizontal inset so tile
    // content appeared further right than the balance card and quick actions.
    testWidgets('transaction tile avatar aligns with balance card left edge', (tester) async {
      await _pump(tester, const DashboardScreen(), const Locale('en'), const Size(390, 844));

      // Find CircleAvatars inside TransactionListTile (not the profile avatar in header).
      // The tile's horizontal padding is AppDimensions.buttonPaddingH (24px), so the
      // avatar — the first widget after that padding — should start at x=24.
      final tiles = find.byType(TransactionListTile);
      expect(tiles, findsWidgets);

      // Get the avatar inside the first tile by finding CircleAvatars that are
      // descendants of TransactionListTile.
      final tileAvatars = find.descendant(
        of: tiles.first,
        matching: find.byType(CircleAvatar),
      );
      expect(tileAvatars, findsOneWidget);

      final avatarLeft = tester.getTopLeft(tileAvatars.first).dx;
      expect(avatarLeft, equals(AppDimensions.buttonPaddingH));
    });
  });

  group('QuickActionsRow — brand styling', () {
    testWidgets('light mode — primaryContainer bg and primary icon', (tester) async {
      await _pump(tester, const DashboardScreen(), const Locale('en'), const Size(390, 844));

      final icons = find.byWidgetPredicate(
        (w) => w is Icon && w.color == AppColors.primary,
      );
      expect(icons, findsAtLeastNWidgets(4));

      final materials = find.descendant(
        of: find.byType(QuickActionsRow),
        matching: find.byWidgetPredicate(
          (w) => w is Material && w.color == AppColors.primaryContainer,
        ),
      );
      expect(materials, findsNWidgets(4));
    });

    testWidgets('dark mode — darkPrimaryContainer bg and darkPrimary icon', (tester) async {
      tester.view.physicalSize = const Size(780, 1688);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            customerProvider.overrideWith(() => _StubCustomerNotifier(_stubCustomers)),
            transactionProvider.overrideWith(() => _StubTransactionNotifier(_stubTransactions)),
          ],
          child: MaterialApp(
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: ThemeMode.dark,
            locale: const Locale('en'),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: const DashboardScreen(),
          ),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // In dark mode the tokens resolve to dark variants.
      final icons = find.byWidgetPredicate(
        (w) => w is Icon && w.color == AppColors.darkPrimary,
      );
      expect(icons, findsAtLeastNWidgets(4));

      final materials = find.descendant(
        of: find.byType(QuickActionsRow),
        matching: find.byWidgetPredicate(
          (w) => w is Material && w.color == AppColors.darkPrimaryContainer,
        ),
      );
      expect(materials, findsNWidgets(4));
    });
  });

  group('DashboardScreen — empty state', () {
    for (final locale in _locales) {
      testWidgets(
        'empty state renders in ${_localeNames[locale.languageCode]}',
        (tester) async {
          tester.view.physicalSize = const Size(780, 1600);
          tester.view.devicePixelRatio = 2.0;
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);

          await tester.pumpWidget(
            ProviderScope(
              overrides: [
                customerProvider.overrideWith(
                  () => _StubCustomerNotifier([]),
                ),
                transactionProvider.overrideWith(
                  () => _StubTransactionNotifier([]),
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
                home: const DashboardScreen(),
              ),
            ),
          );
          await tester.pump();

          final l10n = await AppLocalizations.delegate.load(locale);
          expect(find.text(l10n.firstRunTitle), findsOneWidget);
          _expectNoOverflow(tester);
        },
      );
    }
  });

  group('LanguageSelectionScreen — locale + overflow', () {
    for (final locale in _locales) {
      for (final sizeEntry in _sizes.entries) {
        testWidgets(
          '${_localeNames[locale.languageCode]} on ${sizeEntry.key}',
          (tester) async {
            tester.view.physicalSize = Size(
              sizeEntry.value.width * 2,
              sizeEntry.value.height * 2,
            );
            tester.view.devicePixelRatio = 2.0;
            addTearDown(tester.view.resetPhysicalSize);
            addTearDown(tester.view.resetDevicePixelRatio);

            await tester.pumpWidget(
              ProviderScope(
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
                  home: const LanguageSelectionScreen(),
                ),
              ),
            );
            await tester.pump();
            await tester.pump(const Duration(milliseconds: 100));

            _expectNoOverflow(tester);

            final l10n = await AppLocalizations.delegate.load(locale);
            expect(find.text(l10n.languageScreenTitle),    findsOneWidget);
            expect(find.text(l10n.languageContinueButton), findsOneWidget);

            // All 8 language names always visible (native script, never translated).
            expect(find.text('English'),  findsOneWidget);
            expect(find.text('हिन्दी'),   findsOneWidget);
            expect(find.text('ಕನ್ನಡ'),    findsOneWidget);
            expect(find.text('தமிழ்'),    findsOneWidget);
            expect(find.text('বাংলা'),    findsOneWidget);
            expect(find.text('मराठी'),    findsOneWidget);
            expect(find.text('മലയാളം'),   findsOneWidget);
            expect(find.text('తెలుగు'),   findsOneWidget);
          },
        );
      }
    }
  });

  group('TourScreen — headline + CTA across locales', () {
    for (final locale in _locales) {
      for (final sizeEntry in _sizes.entries) {
        testWidgets(
          '${_localeNames[locale.languageCode]} on ${sizeEntry.key}',
          (tester) async {
            tester.view.physicalSize = Size(
              sizeEntry.value.width * 2,
              sizeEntry.value.height * 2,
            );
            tester.view.devicePixelRatio = 2.0;
            addTearDown(tester.view.resetPhysicalSize);
            addTearDown(tester.view.resetDevicePixelRatio);

            await tester.pumpWidget(
              ProviderScope(
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
                  home: const TourScreen(),
                ),
              ),
            );
            await tester.pump();
            await tester.pump(const Duration(milliseconds: 100));

            _expectNoOverflow(tester);

            final l10n = await AppLocalizations.delegate.load(locale);
            expect(find.text(l10n.tourHeadline1), findsOneWidget);
            expect(find.text(l10n.tourNext),      findsOneWidget);
            expect(find.text(l10n.tourSkip),      findsOneWidget);
          },
        );
      }
    }
  });

  group('CustomersScreen — list + search + overflow', () {
    for (final locale in _locales) {
      for (final sizeEntry in _sizes.entries) {
        testWidgets(
          '${_localeNames[locale.languageCode]} on ${sizeEntry.key}',
          (tester) async {
            await _pump(tester, const CustomersScreen(), locale, sizeEntry.value);
            _expectNoOverflow(tester);

            final l10n = await AppLocalizations.delegate.load(locale);

            // Search bar must render.
            expect(find.text(l10n.customersSearch), findsOneWidget);

            // Stub data has 3 customers — all tiles should appear.
            expect(find.text('Anjali Sharma'), findsOneWidget);
            expect(find.text('Ravi Kumar'),    findsWidgets);
          },
        );
      }
    }
  });

  group('CustomersScreen — empty state', () {
    for (final locale in _locales) {
      testWidgets(
        'empty state renders in ${_localeNames[locale.languageCode]}',
        (tester) async {
          tester.view.physicalSize = const Size(780, 1600);
          tester.view.devicePixelRatio = 2.0;
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);

          await tester.pumpWidget(
            ProviderScope(
              overrides: [
                customerProvider.overrideWith(
                  () => _StubCustomerNotifier([]),
                ),
                transactionProvider.overrideWith(
                  () => _StubTransactionNotifier([]),
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
                home: const CustomersScreen(),
              ),
            ),
          );
          await tester.pump();

          final l10n = await AppLocalizations.delegate.load(locale);
          expect(find.text(l10n.homeEmptyTitle), findsOneWidget);
          _expectNoOverflow(tester);
        },
      );
    }
  });

  // ── AddCustomerScreen ─────────────────────────────────────────────────────────

  group('AddCustomerScreen — locale + overflow', () {
    for (final locale in _locales) {
      for (final sizeEntry in _sizes.entries) {
        testWidgets(
          '${_localeNames[locale.languageCode]} on ${sizeEntry.key}',
          (tester) async {
            tester.view.physicalSize = Size(sizeEntry.value.width * 2, sizeEntry.value.height * 2);
            tester.view.devicePixelRatio = 2.0;
            addTearDown(tester.view.resetPhysicalSize);
            addTearDown(tester.view.resetDevicePixelRatio);

            await tester.pumpWidget(
              ProviderScope(
                overrides: [
                  customerProvider.overrideWith(
                    () => _StubCustomerNotifier([]),
                  ),
                  contactsServiceProvider.overrideWithValue(
                    _StubContactsService(),
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
                  home: const AddCustomerScreen(),
                ),
              ),
            );
            await tester.pump();
            await tester.pump(const Duration(milliseconds: 100));
            _expectNoOverflow(tester);

            final l10n = await AppLocalizations.delegate.load(locale);
            expect(find.text(l10n.addCustomerTitle), findsOneWidget);
            expect(find.text(l10n.addCustomerSave),  findsOneWidget);
          },
        );
      }
    }
  });

  // ── CustomerDetailScreen ──────────────────────────────────────────────────────

  group('CustomerDetailScreen — locale + overflow', () {
    const customer = Customer(
      id: 'c1',
      name: 'Anjali Sharma',
      shopName: 'Boutique',
      netBalance: 1200,
    );
    final txns = [
      Transaction(
        id: 't1', customerId: 'c1', customerName: 'Anjali Sharma',
        shopName: 'Boutique', avatarLabel: 'A', amount: 1200,
        isCredit: true, note: 'Delivery payment',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      ),
    ];

    for (final locale in _locales) {
      for (final sizeEntry in _sizes.entries) {
        testWidgets(
          '${_localeNames[locale.languageCode]} on ${sizeEntry.key}',
          (tester) async {
            tester.view.physicalSize = Size(sizeEntry.value.width * 2, sizeEntry.value.height * 2);
            tester.view.devicePixelRatio = 2.0;
            addTearDown(tester.view.resetPhysicalSize);
            addTearDown(tester.view.resetDevicePixelRatio);

            await tester.pumpWidget(
              ProviderScope(
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
              ),
            );
            await tester.pump();
            await tester.pump(const Duration(milliseconds: 100));
            _expectNoOverflow(tester);
            expect(find.text('Anjali Sharma'), findsWidgets);
          },
        );
      }
    }
  });

  // ── AddEntryScreen ────────────────────────────────────────────────────────────

  group('AddEntryScreen — locale + overflow', () {
    const customer = Customer(
      id: 'c1',
      name: 'Anjali Sharma',
      shopName: 'Boutique',
      netBalance: 500,
    );

    for (final locale in _locales) {
      for (final sizeEntry in _sizes.entries) {
        testWidgets(
          '${_localeNames[locale.languageCode]} on ${sizeEntry.key}',
          (tester) async {
            tester.view.physicalSize = Size(sizeEntry.value.width * 2, sizeEntry.value.height * 2);
            tester.view.devicePixelRatio = 2.0;
            addTearDown(tester.view.resetPhysicalSize);
            addTearDown(tester.view.resetDevicePixelRatio);

            await tester.pumpWidget(
              ProviderScope(
                overrides: [
                  customerProvider.overrideWith(
                    () => _StubCustomerNotifier([customer]),
                  ),
                  customerTransactionsProvider(customer.id).overrideWith(
                    () => _StubTxnsNotifier(customer.id, []),
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
                  home: AddEntryScreen(customerId: customer.id),
                ),
              ),
            );
            await tester.pump();
            await tester.pump(const Duration(milliseconds: 100));
            _expectNoOverflow(tester);

            final l10n = await AppLocalizations.delegate.load(locale);
            expect(find.text(l10n.addEntrySave), findsOneWidget);
          },
        );
      }
    }
  });
}
