import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/reminder_scheduler.dart';
import '../../../../core/services/sync_service.dart';
import '../../../../features/settings/presentation/providers/reminder_settings_provider.dart';
import '../../domain/models/customer.dart';
import 'repository_providers.dart';

class CustomerNotifier extends StreamNotifier<List<Customer>> {
  @override
  Stream<List<Customer>> build() {
    return ref.watch(customerRepoProvider).watchAll();
  }

  Future<void> addCustomer(Customer customer) async {
    final repo = ref.read(customerRepoProvider);
    final defaultFreq =
        ref.read(reminderSettingsProvider).value ?? customer.reminderFrequency;
    final withDefault = customer.copyWith(reminderFrequency: defaultFreq);
    await repo.insert(withDefault);
    if (defaultFreq.days > 0) {
      await ReminderScheduler.scheduleForCustomer(withDefault);
    }
    unawaited(ref.read(syncServiceProvider).pushCustomer(withDefault));
  }

  Future<void> updateCustomer(Customer customer) async {
    await ref.read(customerRepoProvider).update(customer);
    unawaited(ref.read(syncServiceProvider).pushCustomer(customer));
  }

  Future<void> deleteCustomer(String id) async {
    await ReminderScheduler.cancelForCustomer(id);
    await ref.read(customerRepoProvider).delete(id);
    unawaited(ref.read(syncServiceProvider).deleteCustomer(id));
  }
}

final customerProvider =
    StreamNotifierProvider<CustomerNotifier, List<Customer>>(
        CustomerNotifier.new);
