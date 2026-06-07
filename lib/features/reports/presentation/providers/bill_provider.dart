import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../home/domain/models/customer.dart';
import '../../../home/presentation/providers/customer_provider.dart';
import '../../../home/presentation/providers/customer_transactions_provider.dart';
import '../../../settings/presentation/providers/profile_provider.dart';
import '../../../settings/domain/extensions/profile_extensions.dart';
import '../../domain/models/bill_data.dart';

// ── UI state ──────────────────────────────────────────────────────────────────

class BillUiState {
  const BillUiState({
    this.period      = BillPeriod.thisMonth,
    this.customRange,
    this.sharing     = false,
  });

  final BillPeriod     period;
  final BillDateRange? customRange;
  final bool           sharing;

  BillUiState copyWith({
    BillPeriod?     period,
    BillDateRange?  customRange,
    bool?           sharing,
    bool            clearCustomRange = false,
  }) =>
      BillUiState(
        period:      period      ?? this.period,
        customRange: clearCustomRange ? null : (customRange ?? this.customRange),
        sharing:     sharing     ?? this.sharing,
      );
}

class BillUiNotifier extends Notifier<BillUiState> {
  @override
  BillUiState build() => const BillUiState();

  void setPeriod(BillPeriod period) =>
      state = state.copyWith(
        period:          period,
        clearCustomRange: period != BillPeriod.custom,
      );

  void setCustomRange(BillDateRange range) =>
      state = state.copyWith(period: BillPeriod.custom, customRange: range);

  void setSharing(bool value) => state = state.copyWith(sharing: value);
}

final billUiProvider =
    NotifierProvider<BillUiNotifier, BillUiState>(BillUiNotifier.new);

// ── Data provider (family by customerId) ──────────────────────────────────────

class BillDataNotifier extends Notifier<AsyncValue<BillData?>> {
  BillDataNotifier(this.customerId);

  final String customerId;

  @override
  AsyncValue<BillData?> build() {
    final txnsAsync      = ref.watch(customerTransactionsProvider(customerId));
    final customersAsync = ref.watch(customerProvider);
    final profileAsync   = ref.watch(profileProvider);
    final ui             = ref.watch(billUiProvider);

    if (txnsAsync.isLoading || customersAsync.isLoading || profileAsync.isLoading) {
      return const AsyncValue.loading();
    }
    if (txnsAsync.hasError) {
      return AsyncValue.error(txnsAsync.error!, txnsAsync.stackTrace!);
    }

    final txns      = txnsAsync.requireValue;
    final customers = customersAsync.value ?? [];
    final profile   = profileAsync.value;

    final customer = customers.where((c) => c.id == customerId).firstOrNull;
    if (customer == null) return const AsyncValue.data(null);

    final businessName = profile.businessName;

    final dateRange = _dateRangeFor(ui);
    final filtered = dateRange == null
        ? txns
        : txns.where((t) =>
            !t.timestamp.isBefore(dateRange.from) &&
            !t.timestamp.isAfter(dateRange.to)).toList();

    final sorted = [...filtered]
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

    double running = 0;
    final rows = sorted.map((t) {
      if (t.isCredit) {
        running -= t.amount;
      } else {
        running += t.amount;
      }
      return BillRow(
        date:           t.timestamp,
        note:           t.note,
        amount:         t.amount,
        isCredit:       t.isCredit,
        runningBalance: running,
      );
    }).toList();

    return AsyncValue.data(BillData(
      customer:     customer,
      businessName: businessName,
      period:       ui.period,
      dateRange:    ui.customRange,
      rows:         rows,
    ));
  }

  BillDateRange? _dateRangeFor(BillUiState ui) {
    final now = DateTime.now();
    return switch (ui.period) {
      BillPeriod.thisMonth => BillDateRange(
          from: DateTime(now.year, now.month),
          to:   DateTime(now.year, now.month + 1)
              .subtract(const Duration(milliseconds: 1)),
        ),
      BillPeriod.thisYear => BillDateRange(
          from: DateTime(now.year),
          to:   DateTime(now.year + 1)
              .subtract(const Duration(milliseconds: 1)),
        ),
      BillPeriod.allTime  => null,
      BillPeriod.custom   => ui.customRange,
    };
  }
}

final billDataProvider =
    NotifierProvider.family<BillDataNotifier, AsyncValue<BillData?>, String>(
  (customerId) => BillDataNotifier(customerId),
);

// ── Customer convenience provider ─────────────────────────────────────────────

final billCustomerProvider = Provider.family<Customer?, String>((ref, id) {
  return ref.watch(customerProvider).value?.where((c) => c.id == id).firstOrNull;
});
