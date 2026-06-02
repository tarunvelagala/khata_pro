import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart' as db;
import '../../domain/models/customer.dart';
import 'i_customer_repository.dart';
class DriftCustomerRepository implements ICustomerRepository {
  const DriftCustomerRepository(this._db);

  final db.AppDatabase _db;

  @override
  Stream<List<Customer>> watchAll() {
    return (_db.select(_db.customers)
          ..orderBy([(c) => OrderingTerm.asc(c.name)]))
        .watch()
        .map((rows) => rows.map(_toDomain).toList());
  }

  @override
  Future<Customer?> fetchById(String id) async {
    final row = await (_db.select(_db.customers)
          ..where((c) => c.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _toDomain(row);
  }

  @override
  Future<bool> existsByFingerprint({
    required String name,
    String? phone,
    String? shopName,
  }) async {
    final normName = name.trim().toLowerCase();
    final normPhone = phone?.trim();
    final normShop = shopName?.trim().toLowerCase();

    final query = _db.select(_db.customers)
      ..where((c) => c.name.lower().equals(normName));
    final rows = await query.get();

    return rows.any((r) {
      final phoneMatch = (normPhone == null || normPhone.isEmpty)
          ? (r.phone == null || r.phone!.isEmpty)
          : r.phone?.trim() == normPhone;
      final shopMatch = (normShop == null || normShop.isEmpty)
          ? (r.shopName == null || r.shopName!.trim().isEmpty)
          : r.shopName?.trim().toLowerCase() == normShop;
      return phoneMatch && shopMatch;
    });
  }

  @override
  Future<Customer> insert(Customer customer) async {
    if (await existsByFingerprint(
      name: customer.name,
      phone: customer.phone,
      shopName: customer.shopName,
    )) {
      throw const DuplicateCustomerException();
    }
    await _db.into(_db.customers).insert(
      db.CustomersCompanion.insert(
        id: customer.id,
        name: customer.name,
        phone: Value(customer.phone),
        shopName: Value(customer.shopName),
        netBalance: Value(customer.netBalance),
        createdAt: DateTime.now().millisecondsSinceEpoch,
      ),
    );
    return customer;
  }

  @override
  Future<void> update(Customer customer) async {
    await (_db.update(_db.customers)..where((c) => c.id.equals(customer.id)))
        .write(
      db.CustomersCompanion(
        name: Value(customer.name),
        phone: Value(customer.phone),
        shopName: Value(customer.shopName),
        netBalance: Value(customer.netBalance),
      ),
    );
  }

  @override
  Future<void> delete(String id) async {
    await _db.transaction(() async {
      await (_db.delete(_db.transactions)
            ..where((t) => t.customerId.equals(id)))
          .go();
      await (_db.delete(_db.customers)..where((c) => c.id.equals(id))).go();
    });
  }

  Future<void> adjustBalance(String customerId, double delta) async {
    final row = await (_db.select(_db.customers)
          ..where((c) => c.id.equals(customerId)))
        .getSingle();
    await (_db.update(_db.customers)..where((c) => c.id.equals(customerId)))
        .write(db.CustomersCompanion(
          netBalance: Value(row.netBalance + delta),
        ));
  }

  static Customer _toDomain(db.Customer row) => Customer(
    id: row.id,
    name: row.name,
    phone: row.phone,
    shopName: row.shopName,
    netBalance: row.netBalance,
  );
}
