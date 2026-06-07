import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'customer_provider.dart';

class DashboardSummary {
  const DashboardSummary({
    required this.netBalance,
    required this.totalIncome,
    required this.totalExpense,
  });

  final double netBalance;
  final double totalIncome;
  final double totalExpense;
}

final dashboardSummaryProvider = Provider<DashboardSummary>((ref) {
  final customers = ref.watch(customerProvider).value ?? [];
  return DashboardSummary(
    netBalance: customers.fold(0.0, (s, c) => s + c.netBalance),
    totalIncome: customers
        .where((c) => c.netBalance > 0)
        .fold(0.0, (s, c) => s + c.netBalance),
    totalExpense: customers
        .where((c) => c.netBalance < 0)
        .fold(0.0, (s, c) => s + c.netBalance.abs()),
  );
});
