import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/drift_customer_repository.dart';
import '../../domain/models/customer.dart';
import 'database_provider.dart';

class CustomerNotifier extends StreamNotifier<List<Customer>> {
  @override
  Stream<List<Customer>> build() {
    final db = ref.watch(databaseProvider);
    return DriftCustomerRepository(db).watchAll();
  }

  Future<void> addCustomer(Customer customer) async {
    await DriftCustomerRepository(ref.read(databaseProvider)).insert(customer);
  }

  Future<void> updateCustomer(Customer customer) async {
    await DriftCustomerRepository(ref.read(databaseProvider)).update(customer);
  }

  Future<void> deleteCustomer(String id) async {
    await DriftCustomerRepository(ref.read(databaseProvider)).delete(id);
  }
}

final customerProvider =
    StreamNotifierProvider<CustomerNotifier, List<Customer>>(
        CustomerNotifier.new);
