import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/drift_transaction_repository.dart';
import '../../domain/models/transaction.dart';
import 'database_provider.dart';

class CustomerTransactionsNotifier extends StreamNotifier<List<Transaction>> {
  CustomerTransactionsNotifier(this.customerId);

  final String customerId;

  @override
  Stream<List<Transaction>> build() {
    final db = ref.watch(databaseProvider);
    return DriftTransactionRepository(db).watchForCustomer(customerId);
  }

  Future<void> addTransaction(Transaction txn) async {
    await DriftTransactionRepository(ref.read(databaseProvider)).insert(txn);
  }

  Future<void> deleteTransaction(String id) async {
    await DriftTransactionRepository(ref.read(databaseProvider)).delete(id);
  }
}

final customerTransactionsProvider = StreamNotifierProvider.family<
    CustomerTransactionsNotifier, List<Transaction>, String>(
  (arg) => CustomerTransactionsNotifier(arg),
);
