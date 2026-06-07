import '../../domain/models/transaction.dart';

abstract interface class ITransactionRepository {
  /// All transactions for a customer, newest first.
  Stream<List<Transaction>> watchForCustomer(String customerId);

  /// Most recent transactions across all customers.
  Stream<List<Transaction>> watchRecent({int limit = 50});

  /// All transactions across all customers, newest first. Used for reports.
  Stream<List<Transaction>> watchAll();

  /// Persists a new transaction AND updates customer.netBalance atomically.
  Future<Transaction> insert(Transaction transaction);

  /// Deletes a transaction AND rolls back customer.netBalance atomically.
  Future<void> delete(String id);
}
