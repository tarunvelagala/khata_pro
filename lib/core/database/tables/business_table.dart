import 'package:drift/drift.dart';

/// Stores the single business profile for the app owner.
class BusinessTable extends Table {
  @override
  String get tableName => 'business';

  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get tagline => text().nullable()();
  IntColumn get visitingCardBgColor =>
      integer().withDefault(const Constant(0))();
  IntColumn get visitingCardFontStyle =>
      integer().withDefault(const Constant(0))();
  BoolColumn get visitingCardShowPhone =>
      boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
