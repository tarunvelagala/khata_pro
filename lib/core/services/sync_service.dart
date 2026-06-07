import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/app_database.dart' as db;
import '../../features/home/domain/models/customer.dart';
import '../../features/home/domain/models/reminder_frequency.dart';
import '../../features/home/domain/models/transaction.dart' as app;
import '../../features/settings/presentation/providers/profile_provider.dart';

class SyncService {
  const SyncService();

  static final _fs = FirebaseFirestore.instance;

  String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  // ── Push ─────────────────────────────────────────────────────────────────────

  Future<void> pushCustomer(Customer c) async {
    final uid = _uid;
    if (uid == null) return;
    try {
      await _fs
          .collection('users')
          .doc(uid)
          .collection('customers')
          .doc(c.id)
          .set(_customerToFirestore(c), SetOptions(merge: true));
    } on FirebaseException catch (e) {
      debugPrint('SyncService.pushCustomer: $e');
    }
  }

  Future<void> pushTransaction(app.Transaction t) async {
    final uid = _uid;
    if (uid == null) return;
    try {
      await _fs
          .collection('users')
          .doc(uid)
          .collection('transactions')
          .doc(t.id)
          .set(_transactionToFirestore(t), SetOptions(merge: true));
    } on FirebaseException catch (e) {
      debugPrint('SyncService.pushTransaction: $e');
    }
  }

  Future<void> pushProfile(UserProfile p) async {
    final uid = _uid;
    if (uid == null) return;
    try {
      await _fs
          .collection('users')
          .doc(uid)
          .collection('profile')
          .doc('data')
          .set({
        'name':      p.name,
        'shopName':  p.shopName,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      debugPrint('SyncService.pushProfile: $e');
    }
  }

  Future<void> deleteCustomer(String id) async {
    final uid = _uid;
    if (uid == null) return;
    try {
      await _fs
          .collection('users')
          .doc(uid)
          .collection('customers')
          .doc(id)
          .set(
        {'deleted': true, 'updatedAt': FieldValue.serverTimestamp()},
        SetOptions(merge: true),
      );
    } on FirebaseException catch (e) {
      debugPrint('SyncService.deleteCustomer: $e');
    }
  }

  Future<void> deleteTransaction(String id) async {
    final uid = _uid;
    if (uid == null) return;
    try {
      await _fs
          .collection('users')
          .doc(uid)
          .collection('transactions')
          .doc(id)
          .set(
        {'deleted': true, 'updatedAt': FieldValue.serverTimestamp()},
        SetOptions(merge: true),
      );
    } on FirebaseException catch (e) {
      debugPrint('SyncService.deleteTransaction: $e');
    }
  }

  // ── Batch push (first sign-in) ────────────────────────────────────────────────

  /// Pushes every local customer, transaction and profile to Firestore.
  /// Called once when a previously-offline user signs in for the first time.
  Future<void> pushAllLocalData(db.AppDatabase database, UserProfile? profile) async {
    final uid = _uid;
    if (uid == null) return;

    final customerRows = await database.select(database.customers).get();
    final txnRows      = await database.select(database.transactions).get();

    final batch = _fs.batch();

    for (final row in customerRows) {
      final ref = _fs
          .collection('users').doc(uid)
          .collection('customers').doc(row.id);
      batch.set(ref, {
        'id':                row.id,
        'name':              row.name,
        'phone':             row.phone,
        'shopName':          row.shopName,
        'netBalance':        row.netBalance,
        'contactId':         row.contactId,
        'reminderFrequency': row.reminderFrequency,
        'reminderDate':      row.reminderDate,
        'deleted':           false,
        'updatedAt':         FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    }

    for (final row in txnRows) {
      final ref = _fs
          .collection('users').doc(uid)
          .collection('transactions').doc(row.id);
      batch.set(ref, {
        'id':         row.id,
        'customerId': row.customerId,
        'amount':     row.amount,
        'isCredit':   row.isCredit,
        'note':       row.note,
        'createdAt':  row.createdAt,
        'deleted':    false,
        'updatedAt':  FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    }

    await batch.commit();

    if (profile != null) await pushProfile(profile);
  }

  // ── Pull (cloud wins) ─────────────────────────────────────────────────────────

  /// Fetches all non-deleted customers + transactions from Firestore.
  /// Called once on first sign-in; caller replaces local Drift data.
  Future<({List<Customer> customers, List<app.Transaction> transactions})>
      fetchCloudData(String uid) async {
    final custSnap = await _fs
        .collection('users')
        .doc(uid)
        .collection('customers')
        .where('deleted', isNotEqualTo: true)
        .get();

    final txnSnap = await _fs
        .collection('users')
        .doc(uid)
        .collection('transactions')
        .where('deleted', isNotEqualTo: true)
        .get();

    final customers = custSnap.docs
        .map((d) => _customerFromFirestore(d.id, d.data()))
        .whereType<Customer>()
        .toList();

    final transactions = txnSnap.docs
        .map((d) => _transactionFromFirestore(d.id, d.data(), customers))
        .whereType<app.Transaction>()
        .toList();

    return (customers: customers, transactions: transactions);
  }

  // ── Serialisation ─────────────────────────────────────────────────────────────

  static Map<String, dynamic> _customerToFirestore(Customer c) => {
        'id':                c.id,
        'name':              c.name,
        'phone':             c.phone,
        'shopName':          c.shopName,
        'netBalance':        c.netBalance,
        'contactId':         c.contactId,
        'reminderFrequency': c.reminderFrequency.toDbString(),
        'reminderDate':      c.reminderDate?.millisecondsSinceEpoch,
        'deleted':           false,
        'updatedAt':         FieldValue.serverTimestamp(),
      };

  static Map<String, dynamic> _transactionToFirestore(app.Transaction t) => {
        'id':         t.id,
        'customerId': t.customerId,
        'amount':     t.amount,
        'isCredit':   t.isCredit,
        'note':       t.note,
        'createdAt':  t.timestamp.millisecondsSinceEpoch,
        'deleted':    false,
        'updatedAt':  FieldValue.serverTimestamp(),
      };

  static Customer? _customerFromFirestore(
      String id, Map<String, dynamic> data) {
    try {
      final rdMs = data['reminderDate'];
      return Customer(
        id:                data['id'] as String? ?? id,
        name:              data['name'] as String,
        phone:             data['phone'] as String?,
        shopName:          data['shopName'] as String?,
        netBalance:        (data['netBalance'] as num).toDouble(),
        contactId:         data['contactId'] as String?,
        reminderFrequency:
            ReminderFrequency.fromString(data['reminderFrequency'] as String?),
        reminderDate: rdMs == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(rdMs as int),
      );
    } catch (_) {
      return null;
    }
  }

  static app.Transaction? _transactionFromFirestore(
      String id, Map<String, dynamic> data, List<Customer> customers) {
    try {
      final customerId = data['customerId'] as String;
      final customer = customers.firstWhere(
        (c) => c.id == customerId,
        orElse: () => Customer(id: customerId, name: '', netBalance: 0),
      );
      final name = customer.name;
      return app.Transaction(
        id:           data['id'] as String? ?? id,
        customerId:   customerId,
        customerName: name,
        shopName:     customer.shopName,
        avatarLabel:  name.isNotEmpty ? name[0].toUpperCase() : '?',
        amount:       (data['amount'] as num).toDouble(),
        isCredit:     data['isCredit'] as bool,
        note:         data['note'] as String?,
        timestamp:    DateTime.fromMillisecondsSinceEpoch(data['createdAt'] as int),
      );
    } catch (_) {
      return null;
    }
  }
}

final syncServiceProvider = Provider<SyncService>((_) => const SyncService());
