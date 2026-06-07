import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

// ── Tables ────────────────────────────────────────────────────────────────────

class Customers extends Table {
  TextColumn get id        => text()();
  TextColumn get name      => text()();
  TextColumn get phone     => text().nullable()();
  TextColumn get shopName  => text().named('shop_name').nullable()();
  RealColumn get netBalance => real().named('net_balance').withDefault(const Constant(0.0))();
  IntColumn  get createdAt  => integer().named('created_at')();
  TextColumn get contactId  => text().named('contact_id').nullable()();
  TextColumn get reminderFrequency => text().named('reminder_frequency').nullable()();
  IntColumn  get reminderDate  => integer().named('reminder_date').nullable()();
  IntColumn  get syncedAt  => integer().named('synced_at').nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Transactions extends Table {
  TextColumn  get id         => text()();
  TextColumn  get customerId => text().named('customer_id').references(Customers, #id)();
  RealColumn  get amount     => real()();
  BoolColumn  get isCredit   => boolean().named('is_credit')();
  TextColumn  get note       => text().nullable()();
  IntColumn   get createdAt  => integer().named('created_at')();
  IntColumn   get syncedAt   => integer().named('synced_at').nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// ── Database ──────────────────────────────────────────────────────────────────

@DriftDatabase(tables: [Customers, Transactions])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'khata_pro'));

  // For widget and unit tests — pass NativeDatabase.memory().
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
    onCreate: (m) async {
      await m.createAll();
      await customStatement(
        'CREATE INDEX IF NOT EXISTS transactions_customer_idx '
        'ON transactions (customer_id, created_at DESC)',
      );
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.addColumn(customers, customers.contactId);
      }
      if (from < 3) {
        await m.addColumn(customers, customers.reminderFrequency);
      }
      if (from < 4) {
        await m.addColumn(customers, customers.syncedAt);
        await m.addColumn(transactions, transactions.syncedAt);
      }
      if (from < 5) {
        await m.addColumn(customers, customers.reminderDate);
      }
      // Ensure the query index exists for users upgrading from any prior version.
      await customStatement(
        'CREATE INDEX IF NOT EXISTS transactions_customer_idx '
        'ON transactions (customer_id, created_at DESC)',
      );
    },
  );
}
