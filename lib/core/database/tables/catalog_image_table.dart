import 'package:drift/drift.dart';

/// Business owner's reusable image library for reminders.
class CatalogImageTable extends Table {
  @override
  String get tableName => 'catalog_image';

  TextColumn get id => text()();

  /// User-visible label for the image (max 60 chars).
  TextColumn get label => text()();

  /// Absolute path to the image file in app-private storage.
  TextColumn get filePath => text()();

  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
