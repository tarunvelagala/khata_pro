import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/transaction.dart';
import 'repository_providers.dart';

class TransactionNotifier extends StreamNotifier<List<Transaction>> {
  @override
  Stream<List<Transaction>> build() {
    return ref.watch(transactionRepoProvider).watchRecent(limit: 50);
  }
}

final transactionProvider =
    StreamNotifierProvider<TransactionNotifier, List<Transaction>>(
        TransactionNotifier.new);
