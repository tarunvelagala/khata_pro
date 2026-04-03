import 'package:drift/drift.dart';

/// Stores customers (active and archived).
class CustomerTable extends Table {
  @override
  String get tableName => 'customer';

  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get phoneNumber => text().nullable()();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
