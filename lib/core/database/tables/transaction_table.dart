import 'package:drift/drift.dart';

import 'customer_table.dart';

/// Credit or payment transactions linked to a customer.
class TransactionTable extends Table {
  @override
  String get tableName => 'transaction';

  TextColumn get id => text()();

  /// Foreign key to [CustomerTable].
  TextColumn get customerId =>
      text().references(CustomerTable, #id, onDelete: KeyAction.cascade)();

  /// 0 = credit, 1 = payment.
  IntColumn get type => integer()();

  /// Stored as integer cents (amount × 100) to avoid floating-point issues.
  IntColumn get amountCents => integer()();

  TextColumn get note => text().nullable()();

  /// The user-chosen date of the transaction (local date, stored as DateTime).
  DateTimeColumn get date => dateTime()();

  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
