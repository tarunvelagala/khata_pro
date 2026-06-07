import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/sync_service.dart';
import '../../domain/models/transaction.dart';
import 'repository_providers.dart';

class CustomerTransactionsNotifier extends StreamNotifier<List<Transaction>> {
  CustomerTransactionsNotifier(this.customerId);

  final String customerId;

  @override
  Stream<List<Transaction>> build() {
    return ref.watch(transactionRepoProvider).watchForCustomer(customerId);
  }

  Future<void> addTransaction(Transaction txn) async {
    await ref.read(transactionRepoProvider).insert(txn);
    unawaited(ref.read(syncServiceProvider).pushTransaction(txn));
  }

  Future<void> deleteTransaction(String id) async {
    await ref.read(transactionRepoProvider).delete(id);
    unawaited(ref.read(syncServiceProvider).deleteTransaction(id));
  }
}

final customerTransactionsProvider = StreamNotifierProvider.family<
    CustomerTransactionsNotifier, List<Transaction>, String>(
  (arg) => CustomerTransactionsNotifier(arg),
);
