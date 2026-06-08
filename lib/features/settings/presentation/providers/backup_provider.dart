import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/services/backup_service.dart';
import '../../../home/presentation/providers/customer_provider.dart';
import '../../../home/presentation/providers/database_provider.dart';

// ── State ─────────────────────────────────────────────────────────────────────

class BackupState {
  const BackupState({
    this.exporting = false,
    this.importing = false,
    this.error,
  });

  final bool    exporting;
  final bool    importing;
  final String? error;

  bool get busy => exporting || importing;

  BackupState copyWith({
    bool?    exporting,
    bool?    importing,
    String?  error,
    bool     clearError = false,
  }) =>
      BackupState(
        exporting: exporting ?? this.exporting,
        importing: importing ?? this.importing,
        error:     clearError ? null : (error ?? this.error),
      );
}

// ── Notifier ──────────────────────────────────────────────────────────────────

class BackupNotifier extends Notifier<BackupState> {
  @override
  BackupState build() => const BackupState();

  AppDatabase get _db => ref.read(databaseProvider);

  Future<bool> export(BuildContext context) async {
    if (state.busy) return false;
    state = state.copyWith(exporting: true, clearError: true);
    try {
      return await BackupService.export(_db, context);
    } on BackupException catch (e) {
      state = state.copyWith(error: e.message);
      return false;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    } finally {
      state = state.copyWith(exporting: false);
    }
  }

  Future<bool?> import() async {
    if (state.busy) return false;
    state = state.copyWith(importing: true, clearError: true);
    try {
      final selected = await BackupService.import(_db);
      if (selected) ref.invalidate(customerProvider);
      return selected ? true : null;
    } on BackupException catch (e) {
      state = state.copyWith(error: e.message);
      return false;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    } finally {
      state = state.copyWith(importing: false);
    }
  }
}

final backupProvider =
    NotifierProvider<BackupNotifier, BackupState>(BackupNotifier.new);
