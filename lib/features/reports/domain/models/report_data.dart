enum ReportPeriod { thisMonth, thisYear, allTime }

class CustomerReportRow {
  const CustomerReportRow({
    required this.customerId,
    required this.customerName,
    this.shopName,
    required this.gave,
    required this.got,
  });

  final String customerId;
  final String customerName;
  final String? shopName;

  /// Sum of isCredit=true transactions in the period (money you gave).
  final double gave;

  /// Sum of isCredit=false transactions in the period (money you got).
  final double got;

  double get net => got - gave;
}

class ReportData {
  const ReportData({
    required this.period,
    required this.rows,
  });

  final ReportPeriod period;
  final List<CustomerReportRow> rows;

  double get totalGave => rows.fold(0.0, (s, r) => s + r.gave);
  double get totalGot  => rows.fold(0.0, (s, r) => s + r.got);
  double get netBalance => totalGot - totalGave;

  ReportData filteredBy(String customerId) => ReportData(
        period: period,
        rows: rows.where((r) => r.customerId == customerId).toList(),
      );
}
