import '../../domain/models/customer.dart';

/// Thrown when an insert would create a customer whose name + phone + shop
/// fingerprint already exists in the database.
class DuplicateCustomerException implements Exception {
  const DuplicateCustomerException();
}

abstract interface class ICustomerRepository {
  Stream<List<Customer>> watchAll();
  Future<Customer?> fetchById(String id);
  /// Returns true if a customer with the same (normalised) name + phone + shop
  /// already exists. Used to guard against accidental duplicates.
  Future<bool> existsByFingerprint({
    required String name,
    String? phone,
    String? shopName,
  });
  Future<Customer> insert(Customer customer);
  Future<void> update(Customer customer);
  Future<void> delete(String id);
}
