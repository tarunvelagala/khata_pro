import '../../domain/models/customer.dart';

class CustomerRepository {
  List<Customer> fetchAll() => _stub;
}

// Seeded stub data — replaced by local DB in a future commit.
const List<Customer> _stub = [
  Customer(id: '1', name: 'Ravi Kumar',   shopName: 'Ravi General Store',  phone: '9876543210', netBalance:  4500),
  Customer(id: '2', name: 'Priya Sharma', shopName: 'Priya Boutique',      phone: '9123456789', netBalance: -1200),
  Customer(id: '3', name: 'Ravi Kumar',   shopName: 'Ravi Hardware',        phone: '9988776655', netBalance:  800),
];
