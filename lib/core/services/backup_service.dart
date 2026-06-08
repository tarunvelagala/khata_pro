import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart' as drift;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../database/app_database.dart';

const _kBackupVersion = 1;

class BackupException implements Exception {
  const BackupException(this.message);
  final String message;
  @override
  String toString() => 'BackupException: $message';
}

abstract final class BackupService {
  /// Serializes all data to JSON and opens the system share sheet.
  /// Returns true if the share sheet was shown.
  /// Throws [BackupException] if there is no data to export.
  static Future<bool> export(AppDatabase db, BuildContext context) async {
    final customers    = await db.select(db.customers).get();
    if (customers.isEmpty) {
      throw const BackupException('backupEmptyError');
    }
    final transactions = await db.select(db.transactions).get();

    final payload = {
      'version':    _kBackupVersion,
      'exportedAt': DateTime.now().toIso8601String(),
      'customers': customers.map((c) => {
        'id':                c.id,
        'name':              c.name,
        'phone':             c.phone,
        'shopName':          c.shopName,
        'netBalance':        c.netBalance,
        'createdAt':         c.createdAt,
        'contactId':         c.contactId,
        'reminderFrequency': c.reminderFrequency,
        'reminderDate':      c.reminderDate,
      }).toList(),
      'transactions': transactions.map((t) => {
        'id':         t.id,
        'customerId': t.customerId,
        'amount':     t.amount,
        'isCredit':   t.isCredit,
        'note':       t.note,
        'createdAt':  t.createdAt,
      }).toList(),
    };

    final json     = const JsonEncoder.withIndent('  ').convert(payload);
    final datePart = DateFormat('yyyyMMdd').format(DateTime.now());
    final tmpDir   = await getTemporaryDirectory();
    final file     = File('${tmpDir.path}/khatabook_backup_$datePart.json');
    await file.writeAsString(json, flush: true);

    final result = await SharePlus.instance.share(
      ShareParams(files: [XFile(file.path)]),
    );
    return result.status != ShareResultStatus.unavailable;
  }

  /// Opens a file picker, validates the backup, then restores all data.
  /// Returns false if the user cancelled without selecting a file.
  /// Throws [BackupException] if the file is invalid.
  static Future<bool> import(AppDatabase db) async {
    final result = await FilePicker.pickFiles(
      type:              FileType.custom,
      allowedExtensions: ['json'],
    );
    if (result == null || result.files.isEmpty) return false;

    final bytes = await result.files.single.readAsBytes();
    if (bytes.isEmpty) throw const BackupException('restoreError');

    final Map<String, dynamic> payload;
    try {
      payload = jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>;
    } catch (_) {
      throw const BackupException('restoreError');
    }

    _validate(payload);

    final customerRows = (payload['customers'] as List).map((e) {
      final m = e as Map<String, dynamic>;
      return CustomersCompanion.insert(
        id:                m['id'] as String,
        name:              m['name'] as String,
        phone:             drift.Value(m['phone'] as String?),
        shopName:          drift.Value(m['shopName'] as String?),
        netBalance:        drift.Value((m['netBalance'] as num).toDouble()),
        createdAt:         (m['createdAt'] as num).toInt(),
        contactId:         drift.Value(m['contactId'] as String?),
        reminderFrequency: drift.Value(m['reminderFrequency'] as String?),
        reminderDate:      drift.Value((m['reminderDate'] as num?)?.toInt()),
      );
    }).toList();

    final txnRows = (payload['transactions'] as List).map((e) {
      final m = e as Map<String, dynamic>;
      return TransactionsCompanion.insert(
        id:         m['id'] as String,
        customerId: m['customerId'] as String,
        amount:     (m['amount'] as num).toDouble(),
        isCredit:   m['isCredit'] as bool,
        note:       drift.Value(m['note'] as String?),
        createdAt:  (m['createdAt'] as num).toInt(),
      );
    }).toList();

    await db.transaction(() async {
      await db.delete(db.transactions).go();
      await db.delete(db.customers).go();
      await db.batch((b) {
        b.insertAll(db.customers,    customerRows);
        b.insertAll(db.transactions, txnRows);
      });
    });

    return true;
  }

  static void _validate(Map<String, dynamic> payload) {
    if (payload['version'] is! int) {
      throw const BackupException('restoreError');
    }
    if (payload['customers'] is! List) {
      throw const BackupException('restoreError');
    }
    if (payload['transactions'] is! List) {
      throw const BackupException('restoreError');
    }

    final customerIds = <String>{};
    for (final raw in payload['customers'] as List) {
      final c = raw as Map<String, dynamic>;
      if (c['id'] is! String || c['name'] is! String || c['createdAt'] is! num) {
        throw const BackupException('restoreError');
      }
      customerIds.add(c['id'] as String);
    }

    for (final raw in payload['transactions'] as List) {
      final t = raw as Map<String, dynamic>;
      if (t['id'] is! String ||
          t['customerId'] is! String ||
          t['amount'] is! num ||
          t['isCredit'] is! bool ||
          t['createdAt'] is! num) {
        throw const BackupException('restoreError');
      }
      if (!customerIds.contains(t['customerId'] as String)) {
        throw const BackupException('restoreError');
      }
    }
  }
}
