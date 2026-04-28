class Transaction {
  const Transaction({
    required this.id,
    required this.customerName,
    this.shopName,
    required this.avatarLabel,
    required this.amount,
    required this.isCredit,
    required this.timestamp,
  });

  final String id;
  final String customerName;
  final String? shopName;

  /// 1–2 char label shown in the avatar circle.
  final String avatarLabel;

  /// Always positive — use [isCredit] for direction.
  final double amount;

  /// true = money coming in (green). false = money going out (red).
  final bool isCredit;

  final DateTime timestamp;
}
