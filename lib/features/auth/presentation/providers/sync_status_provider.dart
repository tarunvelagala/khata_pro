import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features/auth/presentation/providers/auth_provider.dart';
import '../../../../features/home/presentation/providers/database_provider.dart';

class SyncStatus {
  const SyncStatus({required this.pendingCount, required this.signedIn});

  final int  pendingCount;
  final bool signedIn;

  bool get hasPending => signedIn && pendingCount > 0;
}

class SyncStatusNotifier extends AsyncNotifier<SyncStatus> {
  @override
  Future<SyncStatus> build() async {
    final db         = ref.watch(databaseProvider);
    final authAsync  = ref.watch(authProvider);
    final signedIn   = authAsync.value != null;

    if (!signedIn) return const SyncStatus(pendingCount: 0, signedIn: false);

    final custCount = await (db.selectOnly(db.customers)
          ..addColumns([db.customers.id.count()])
          ..where(db.customers.syncedAt.isNull()))
        .map((r) => r.read(db.customers.id.count()) ?? 0)
        .getSingle();

    final txnCount = await (db.selectOnly(db.transactions)
          ..addColumns([db.transactions.id.count()])
          ..where(db.transactions.syncedAt.isNull()))
        .map((r) => r.read(db.transactions.id.count()) ?? 0)
        .getSingle();

    return SyncStatus(
      pendingCount: custCount + txnCount,
      signedIn: true,
    );
  }
}

final syncStatusProvider =
    AsyncNotifierProvider<SyncStatusNotifier, SyncStatus>(
        SyncStatusNotifier.new);
