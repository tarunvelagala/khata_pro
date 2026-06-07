import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khata_pro/features/reports/domain/models/report_data.dart';
import 'package:khata_pro/features/reports/presentation/providers/reports_provider.dart';

CustomerReportRow _row(String id, {double gave = 0, double got = 0}) =>
    CustomerReportRow(
      customerId:   id,
      customerName: 'Customer $id',
      shopName:     null,
      gave:         gave,
      got:          got,
    );

void main() {
  group('ReportsUiNotifier', () {
    test('initial state has no customer filter', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final state = container.read(reportsUiProvider);
      expect(state.selectedCustomerId, isNull);
      expect(state.selectedCustomerName, isNull);
    });

    test('setCustomer stores id and name', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(reportsUiProvider.notifier).setCustomer('c1', 'Alice');

      final state = container.read(reportsUiProvider);
      expect(state.selectedCustomerId, 'c1');
      expect(state.selectedCustomerName, 'Alice');
    });

    test('setCustomer(null, null) clears the filter', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(reportsUiProvider.notifier).setCustomer('c1', 'Alice');
      container.read(reportsUiProvider.notifier).setCustomer(null, null);

      final state = container.read(reportsUiProvider);
      expect(state.selectedCustomerId, isNull);
      expect(state.selectedCustomerName, isNull);
    });

    test('setPeriod updates the period', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(reportsUiProvider.notifier).setPeriod(ReportPeriod.allTime);

      expect(
        container.read(reportsUiProvider).period,
        ReportPeriod.allTime,
      );
    });
  });

  group('ReportData.filteredBy', () {
    final data = ReportData(
      period: ReportPeriod.thisMonth,
      rows: [
        _row('c1', gave: 100),
        _row('c2', gave: 200),
        _row('c3', got: 50),
      ],
    );

    test('returns only rows for the requested customer', () {
      final filtered = data.filteredBy('c2');
      expect(filtered.rows, hasLength(1));
      expect(filtered.rows.first.customerId, 'c2');
    });

    test('returns empty rows for unknown customer', () {
      final filtered = data.filteredBy('unknown');
      expect(filtered.rows, isEmpty);
    });

    test('preserves the period in the filtered result', () {
      final filtered = data.filteredBy('c1');
      expect(filtered.period, ReportPeriod.thisMonth);
    });
  });
}
