import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/drift_transaction_repository.dart';
import '../../domain/models/transaction.dart';
import 'database_provider.dart';

class TransactionNotifier extends StreamNotifier<List<Transaction>> {
  @override
  Stream<List<Transaction>> build() {
    final db = ref.watch(databaseProvider);
    return DriftTransactionRepository(db).watchRecent(limit: 50);
  }
}

final transactionProvider =
    StreamNotifierProvider<TransactionNotifier, List<Transaction>>(
        TransactionNotifier.new);
