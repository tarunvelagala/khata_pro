import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/customer_repository.dart';
import '../../domain/models/customer.dart';

class CustomerNotifier extends Notifier<List<Customer>> {
  @override
  List<Customer> build() => CustomerRepository().fetchAll();
}

final customerProvider =
    NotifierProvider<CustomerNotifier, List<Customer>>(CustomerNotifier.new);
