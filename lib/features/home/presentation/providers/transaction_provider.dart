import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/transaction.dart';

class TransactionNotifier extends Notifier<List<Transaction>> {
  @override
  List<Transaction> build() => _stub;
}

final transactionProvider =
    NotifierProvider<TransactionNotifier, List<Transaction>>(
        TransactionNotifier.new);

final _stub = [
  Transaction(
    id: '1',
    customerName: 'Anjali Sharma',
    shopName: 'Anjali Boutique',
    avatarLabel: 'AS',
    amount: 1200,
    isCredit: true,
    timestamp: DateTime.now().subtract(const Duration(hours: 2)),
  ),
  Transaction(
    id: '2',
    customerName: 'Rajesh Kirana',
    shopName: 'Rajesh General Store',
    avatarLabel: 'RK',
    amount: 350,
    isCredit: false,
    timestamp: DateTime.now().subtract(const Duration(hours: 5)),
  ),
  Transaction(
    id: '3',
    customerName: 'Amit Verma',
    avatarLabel: 'AV',
    amount: 5000,
    isCredit: true,
    timestamp: DateTime.now().subtract(const Duration(days: 1)),
  ),
  Transaction(
    id: '4',
    customerName: 'Electricity Bill',
    avatarLabel: 'EB',
    amount: 2100,
    isCredit: false,
    timestamp: DateTime.now().subtract(const Duration(days: 2)),
  ),
  Transaction(
    id: '5',
    customerName: 'Sunil Kumar',
    shopName: 'Sunil Hardware',
    avatarLabel: 'SK',
    amount: 850,
    isCredit: true,
    timestamp: DateTime.now().subtract(const Duration(days: 3)),
  ),
];
