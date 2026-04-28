class Customer {
  const Customer({
    required this.id,
    required this.name,
    this.phone,
    this.shopName,
    required this.netBalance,
  });

  final String id;
  final String name;
  final String? phone;
  final String? shopName;

  /// Positive → customer owes you. Negative → you owe the customer.
  final double netBalance;

  Customer copyWith({
    String? id,
    String? name,
    String? phone,
    String? shopName,
    double? netBalance,
  }) =>
      Customer(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        shopName: shopName ?? this.shopName,
        netBalance: netBalance ?? this.netBalance,
      );
}
