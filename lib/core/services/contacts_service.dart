import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ContactsPermResult { granted, denied, permanentlyDenied }

class ContactsService {
  Future<ContactsPermResult> requestPermission() async {
    final status = await FlutterContacts.permissions
        .request(PermissionType.readWrite);
    return switch (status) {
      PermissionStatus.granted || PermissionStatus.limited
          => ContactsPermResult.granted,
      PermissionStatus.permanentlyDenied || PermissionStatus.restricted
          => ContactsPermResult.permanentlyDenied,
      _ => ContactsPermResult.denied,
    };
  }

  Future<void> openSettings() => FlutterContacts.permissions.openSettings();

  /// Opens the system contact picker.
  ///
  /// Returns the picked contact including its [id] so the caller can store the
  /// link without creating a duplicate. Returns null if the user cancelled.
  Future<({String id, String name, String? phone})?> pickContact() async {
    final contact = await FlutterContacts.native.showPicker(
      properties: {ContactProperty.name, ContactProperty.phone},
    );
    if (contact == null) return null;
    final id    = contact.id;
    if (id == null) return null;
    final name  = contact.displayName ?? contact.name?.first ?? '';
    final phone = contact.phones.isNotEmpty ? contact.phones.first.number : null;
    return (id: id, name: name, phone: phone);
  }

  /// Creates a new phone contact and returns its id, or null on failure.
  Future<String?> createContact({
    required String name,
    String? phone,
  }) async {
    try {
      final contact = Contact(
        name: Name(first: name),
        phones: phone != null ? [Phone(number: phone)] : [],
      );
      final id = await FlutterContacts.create(contact);
      return id;
    } catch (_) {
      return null;
    }
  }

  /// Updates an existing phone contact's name and phone number.
  /// Silently no-ops if the contact no longer exists or permission is denied.
  Future<void> updateContact({
    required String contactId,
    required String name,
    String? phone,
  }) async {
    try {
      final existing = await FlutterContacts.get(contactId);
      if (existing == null) return;
      final updated = existing.copyWith(
        name: Name(first: name),
        phones: phone != null ? [Phone(number: phone)] : [],
      );
      await FlutterContacts.update(updated);
    } catch (_) {
      // Contact may have been deleted externally — safe to ignore.
    }
  }
}

final contactsServiceProvider = Provider<ContactsService>(
  (_) => ContactsService(),
);
