import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../home/domain/models/customer.dart';
import '../../../home/domain/models/transaction.dart';
import '../../../home/presentation/providers/customer_provider.dart';
import '../../../home/presentation/providers/repository_providers.dart';
import '../../domain/models/report_data.dart';

// ── All-transactions stream (no limit) ───────────────────────────────────────

class _AllTransactionsNotifier extends StreamNotifier<List<Transaction>> {
  @override
  Stream<List<Transaction>> build() {
    return ref.watch(transactionRepoProvider).watchAll();
  }
}

final allTransactionsProvider =
    StreamNotifierProvider<_AllTransactionsNotifier, List<Transaction>>(
  _AllTransactionsNotifier.new,
);

// ── Reports provider (family by period) ──────────────────────────────────────

class ReportsNotifier extends Notifier<AsyncValue<ReportData>> {
  ReportsNotifier(this.period);

  final ReportPeriod period;

  @override
  AsyncValue<ReportData> build() {
    final txnsAsync      = ref.watch(allTransactionsProvider);
    final customersAsync = ref.watch(customerProvider);

    if (txnsAsync.isLoading || customersAsync.isLoading) {
      return const AsyncValue.loading();
    }
    if (txnsAsync.hasError) return AsyncValue.error(txnsAsync.error!, txnsAsync.stackTrace!);
    if (customersAsync.hasError) return AsyncValue.error(customersAsync.error!, customersAsync.stackTrace!);

    return AsyncValue.data(
      _compute(txnsAsync.requireValue, customersAsync.requireValue, period),
    );
  }
}

ReportData _compute(
  List<Transaction> txns,
  List<Customer> customers,
  ReportPeriod period,
) {
  final now   = DateTime.now();
  final start = switch (period) {
    ReportPeriod.thisMonth => DateTime(now.year, now.month, 1),
    ReportPeriod.thisYear  => DateTime(now.year, 1, 1),
    ReportPeriod.allTime   => DateTime(2000),
  };

  final filtered = txns.where((t) => !t.timestamp.isBefore(start)).toList();

  final Map<String, ({double gave, double got, String name, String? shop})> acc = {};

  for (final t in filtered) {
    final cur = acc[t.customerId];
    if (cur == null) {
      acc[t.customerId] = (
        gave: t.isCredit ? t.amount : 0.0,
        got:  t.isCredit ? 0.0 : t.amount,
        name: t.customerName,
        shop: t.shopName,
      );
    } else {
      acc[t.customerId] = (
        gave: cur.gave + (t.isCredit ? t.amount : 0.0),
        got:  cur.got  + (t.isCredit ? 0.0 : t.amount),
        name: cur.name,
        shop: cur.shop,
      );
    }
  }

  // Include customers with zero activity in this period.
  for (final c in customers) {
    acc.putIfAbsent(
      c.id,
      () => (gave: 0.0, got: 0.0, name: c.name, shop: c.shopName),
    );
  }

  final rows = acc.entries
      .map((e) => CustomerReportRow(
            customerId:   e.key,
            customerName: e.value.name,
            shopName:     e.value.shop,
            gave:         e.value.gave,
            got:          e.value.got,
          ))
      .toList()
    ..sort((a, b) => b.gave.compareTo(a.gave));

  return ReportData(period: period, rows: rows);
}

final reportsProvider =
    NotifierProvider.family<ReportsNotifier, AsyncValue<ReportData>, ReportPeriod>(
  (period) => ReportsNotifier(period),
);

// ── Reports UI state (period selector + customer filter + export loading) ──────

class ReportsUiState {
  const ReportsUiState({
    this.period = ReportPeriod.thisMonth,
    this.exporting = false,
    this.selectedCustomerId,
    this.selectedCustomerName,
  });

  final ReportPeriod period;
  final bool exporting;
  final String? selectedCustomerId;
  final String? selectedCustomerName;

  ReportsUiState copyWith({
    ReportPeriod? period,
    bool? exporting,
    String? selectedCustomerId,
    String? selectedCustomerName,
    bool clearCustomer = false,
  }) =>
      ReportsUiState(
        period:               period    ?? this.period,
        exporting:            exporting ?? this.exporting,
        selectedCustomerId:   clearCustomer ? null : (selectedCustomerId   ?? this.selectedCustomerId),
        selectedCustomerName: clearCustomer ? null : (selectedCustomerName ?? this.selectedCustomerName),
      );
}

class ReportsUiNotifier extends Notifier<ReportsUiState> {
  @override
  ReportsUiState build() => const ReportsUiState();

  void setPeriod(ReportPeriod period) =>
      state = state.copyWith(period: period);

  void setExporting(bool value) =>
      state = state.copyWith(exporting: value);

  void setCustomer(String? id, String? name) => state = id == null
      ? state.copyWith(clearCustomer: true)
      : state.copyWith(selectedCustomerId: id, selectedCustomerName: name);
}

final reportsUiProvider =
    NotifierProvider<ReportsUiNotifier, ReportsUiState>(
  ReportsUiNotifier.new,
);
