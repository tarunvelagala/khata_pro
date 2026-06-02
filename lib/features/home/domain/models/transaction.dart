class Transaction {
  const Transaction({
    required this.id,
    required this.customerId,
    required this.customerName,
    this.shopName,
    required this.avatarLabel,
    required this.amount,
    required this.isCredit,
    this.note,
    required this.timestamp,
  });

  final String id;
  final String customerId;
  final String customerName;
  final String? shopName;

  /// 1–2 char label shown in the avatar circle.
  final String avatarLabel;

  /// Always positive — use [isCredit] for direction.
  final double amount;

  /// true = money coming in (green). false = money going out (red).
  final bool isCredit;

  final String? note;

  final DateTime timestamp;

  Transaction copyWith({
    String? id,
    String? customerId,
    String? customerName,
    String? shopName,
    String? avatarLabel,
    double? amount,
    bool? isCredit,
    String? note,
    DateTime? timestamp,
  }) => Transaction(
    id: id ?? this.id,
    customerId: customerId ?? this.customerId,
    customerName: customerName ?? this.customerName,
    shopName: shopName ?? this.shopName,
    avatarLabel: avatarLabel ?? this.avatarLabel,
    amount: amount ?? this.amount,
    isCredit: isCredit ?? this.isCredit,
    note: note ?? this.note,
    timestamp: timestamp ?? this.timestamp,
  );
}
