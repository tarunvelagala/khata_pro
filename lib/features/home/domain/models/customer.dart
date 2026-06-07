import 'reminder_frequency.dart';

class Customer {
  const Customer({
    required this.id,
    required this.name,
    this.phone,
    this.shopName,
    required this.netBalance,
    this.contactId,
    this.reminderFrequency = ReminderFrequency.none,
    this.reminderDate,
  });

  final String id;
  final String name;
  final String? phone;
  final String? shopName;

  /// Positive → customer owes you. Negative → you owe the customer.
  final double netBalance;

  /// Device contact ID for two-way sync with the phone's contacts app.
  final String? contactId;

  /// How often to send a scheduled payment reminder notification.
  /// Ignored when [reminderDate] is set.
  final ReminderFrequency reminderFrequency;

  /// One-shot reminder date. When set, overrides [reminderFrequency].
  /// Cleared automatically after the notification fires.
  final DateTime? reminderDate;

  Customer copyWith({
    String? id,
    String? name,
    String? phone,
    String? shopName,
    double? netBalance,
    String? contactId,
    bool clearContactId = false,
    ReminderFrequency? reminderFrequency,
    DateTime? reminderDate,
    bool clearReminderDate = false,
  }) =>
      Customer(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        shopName: shopName ?? this.shopName,
        netBalance: netBalance ?? this.netBalance,
        contactId: clearContactId ? null : (contactId ?? this.contactId),
        reminderFrequency: reminderFrequency ?? this.reminderFrequency,
        reminderDate: clearReminderDate ? null : (reminderDate ?? this.reminderDate),
      );
}
