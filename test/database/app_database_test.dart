import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khata_mitra/core/database/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  group('AppDatabase schema', () {
    test('insert and query business row', () async {
      final now = DateTime.now();
      await db
          .into(db.businessTable)
          .insert(
            BusinessTableCompanion.insert(
              id: 'b1',
              name: 'My Shop',
              createdAt: now,
            ),
          );

      final rows = await db.select(db.businessTable).get();
      expect(rows, hasLength(1));
      expect(rows.first.name, 'My Shop');
    });

    test('insert and query customer row', () async {
      final now = DateTime.now();
      await db
          .into(db.customerTable)
          .insert(
            CustomerTableCompanion.insert(
              id: 'c1',
              name: 'Ravi Kumar',
              createdAt: now,
              updatedAt: now,
            ),
          );

      final rows = await db.select(db.customerTable).get();
      expect(rows, hasLength(1));
      expect(rows.first.name, 'Ravi Kumar');
      expect(rows.first.isArchived, isFalse);
    });

    test('insert and query transaction row', () async {
      final now = DateTime.now();
      // Customer must exist first (FK constraint).
      await db
          .into(db.customerTable)
          .insert(
            CustomerTableCompanion.insert(
              id: 'c1',
              name: 'Ravi Kumar',
              createdAt: now,
              updatedAt: now,
            ),
          );

      await db
          .into(db.transactionTable)
          .insert(
            TransactionTableCompanion.insert(
              id: 't1',
              customerId: 'c1',
              type: 0,
              amountCents: 5000,
              date: now,
              createdAt: now,
            ),
          );

      final rows = await db.select(db.transactionTable).get();
      expect(rows, hasLength(1));
      expect(rows.first.amountCents, 5000);
      expect(rows.first.type, 0);
    });

    test('transaction cascade-deletes when customer is deleted', () async {
      final now = DateTime.now();
      await db
          .into(db.customerTable)
          .insert(
            CustomerTableCompanion.insert(
              id: 'c1',
              name: 'Ravi Kumar',
              createdAt: now,
              updatedAt: now,
            ),
          );
      await db
          .into(db.transactionTable)
          .insert(
            TransactionTableCompanion.insert(
              id: 't1',
              customerId: 'c1',
              type: 0,
              amountCents: 5000,
              date: now,
              createdAt: now,
            ),
          );

      await (db.delete(db.customerTable)..where((t) => t.id.equals('c1'))).go();

      final txns = await db.select(db.transactionTable).get();
      expect(txns, isEmpty);
    });

    test('insert and query catalog image row', () async {
      final now = DateTime.now();
      await db
          .into(db.catalogImageTable)
          .insert(
            CatalogImageTableCompanion.insert(
              id: 'img1',
              label: 'Offer Banner',
              filePath: '/data/user/0/catalog/img1.jpg',
              createdAt: now,
            ),
          );

      final rows = await db.select(db.catalogImageTable).get();
      expect(rows, hasLength(1));
      expect(rows.first.label, 'Offer Banner');
    });
  });
}
