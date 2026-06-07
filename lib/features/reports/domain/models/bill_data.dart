import '../../../home/domain/models/customer.dart';

enum BillPeriod { thisMonth, thisYear, allTime, custom }

class BillDateRange {
  const BillDateRange({required this.from, required this.to});
  final DateTime from;
  final DateTime to;
}

class BillRow {
  const BillRow({
    required this.date,
    this.note,
    required this.amount,
    required this.isCredit,
    required this.runningBalance,
  });

  final DateTime date;
  final String?  note;
  final double   amount;

  /// true = you gave money (credit, red). false = you got money (green).
  final bool     isCredit;

  final double   runningBalance;
}

class BillData {
  const BillData({
    required this.customer,
    required this.businessName,
    required this.period,
    this.dateRange,
    required this.rows,
  });

  final Customer       customer;
  final String         businessName;
  final BillPeriod     period;

  /// Only set when [period] == [BillPeriod.custom].
  final BillDateRange? dateRange;

  final List<BillRow>  rows;

  double get totalGave  => rows.where((r) =>  r.isCredit).fold(0.0, (s, r) => s + r.amount);
  double get totalGot   => rows.where((r) => !r.isCredit).fold(0.0, (s, r) => s + r.amount);
  double get netBalance => totalGot - totalGave;
}
