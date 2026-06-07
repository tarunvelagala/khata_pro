import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart' as db;
import '../../domain/models/transaction.dart';
import 'i_customer_repository.dart';
import 'i_transaction_repository.dart';

class DriftTransactionRepository implements ITransactionRepository {
  const DriftTransactionRepository(this._db, this._customerRepo);

  final db.AppDatabase _db;
  final ICustomerRepository _customerRepo;

  @override
  Stream<List<Transaction>> watchForCustomer(String customerId) {
    return (_db.select(_db.transactions)
          ..where((t) => t.customerId.equals(customerId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch()
        .asyncMap((rows) => Future.wait(rows.map(_toDomain)));
  }

  @override
  Stream<List<Transaction>> watchRecent({int limit = 50}) {
    return (_db.select(_db.transactions)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(limit))
        .watch()
        .asyncMap((rows) => Future.wait(rows.map(_toDomain)));
  }

  @override
  Stream<List<Transaction>> watchAll() {
    return (_db.select(_db.transactions)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch()
        .asyncMap((rows) => Future.wait(rows.map(_toDomain)));
  }

  @override
  Future<Transaction> insert(Transaction txn) async {
    await _db.transaction(() async {
      await _db.into(_db.transactions).insert(
        db.TransactionsCompanion.insert(
          id: txn.id,
          customerId: txn.customerId,
          amount: txn.amount,
          isCredit: txn.isCredit,
          note: Value(txn.note),
          createdAt: txn.timestamp.millisecondsSinceEpoch,
        ),
      );
      final delta = txn.isCredit ? txn.amount : -txn.amount;
      await _customerRepo.adjustBalance(txn.customerId, delta);
    });
    return txn;
  }

  @override
  Future<void> delete(String id) async {
    await _db.transaction(() async {
      final row = await (_db.select(_db.transactions)
            ..where((t) => t.id.equals(id)))
          .getSingle();
      final delta = row.isCredit ? -row.amount : row.amount;
      await (_db.delete(_db.transactions)..where((t) => t.id.equals(id))).go();
      await _customerRepo.adjustBalance(row.customerId, delta);
    });
  }

  Future<Transaction> _toDomain(db.Transaction row) async {
    final customer = await _customerRepo.fetchById(row.customerId);
    final name = customer?.name ?? '';
    return Transaction(
      id: row.id,
      customerId: row.customerId,
      customerName: name,
      shopName: customer?.shopName,
      avatarLabel: name.isNotEmpty ? name[0].toUpperCase() : '?',
      amount: row.amount,
      isCredit: row.isCredit,
      note: row.note,
      timestamp: DateTime.fromMillisecondsSinceEpoch(row.createdAt),
    );
  }
}
