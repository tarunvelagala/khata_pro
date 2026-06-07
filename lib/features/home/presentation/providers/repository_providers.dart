import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/drift_customer_repository.dart';
import '../../data/repositories/drift_transaction_repository.dart';
import '../../data/repositories/i_customer_repository.dart';
import '../../data/repositories/i_transaction_repository.dart';
import 'database_provider.dart';

final customerRepoProvider = Provider<ICustomerRepository>((ref) {
  return DriftCustomerRepository(ref.watch(databaseProvider));
});

final transactionRepoProvider = Provider<ITransactionRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return DriftTransactionRepository(db, DriftCustomerRepository(db));
});
