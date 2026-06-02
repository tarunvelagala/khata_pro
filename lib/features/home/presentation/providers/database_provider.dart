import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';

/// Single app-wide database instance. Override with an in-memory database
/// in widget and unit tests:
///   databaseProvider.overrideWithValue(AppDatabase.forTesting(NativeDatabase.memory()))
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});
