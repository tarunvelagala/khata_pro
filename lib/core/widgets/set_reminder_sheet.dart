import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_dimensions.dart';
import '../../features/home/domain/models/customer.dart';
import '../../features/home/domain/models/reminder_frequency.dart';
import '../../features/home/presentation/providers/customer_provider.dart';
import '../../features/settings/presentation/providers/reminder_settings_provider.dart';
import '../../l10n/app_localizations.dart';
import '../services/reminder_scheduler.dart';

abstract final class _Dims {
  static const double handleTopPad  = 12.0;
  static const double titlePad      = 16.0;
  static const double bottomPad     = 24.0;
  static const double labelFieldGap = 4.0;
}

/// Bottom sheet for choosing a reminder frequency.
///
/// [show] — per-customer mode: saves to the Customer model + schedules.
/// [showGlobal] — settings mode: saves to SharedPreferences default only.
class SetReminderSheet extends ConsumerStatefulWidget {
  const SetReminderSheet._({
    required this.initial,
    required this.customer,
  });

  final ReminderFrequency initial;
  final Customer? customer; // null → global-settings mode

  static Future<void> show(
    BuildContext context,
    WidgetRef ref,
    Customer customer,
  ) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => SetReminderSheet._(
        initial: customer.reminderFrequency,
        customer: customer,
      ),
    );
  }

  static Future<void> showGlobal(BuildContext context, WidgetRef ref) {
    final current = ref.read(reminderSettingsProvider).value ?? ReminderFrequency.none;
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => SetReminderSheet._(
        initial: current,
        customer: null,
      ),
    );
  }

  @override
  ConsumerState<SetReminderSheet> createState() => _SetReminderSheetState();
}

class _SetReminderSheetState extends ConsumerState<SetReminderSheet> {
  late ReminderFrequency _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs   = Theme.of(context).colorScheme;
    final tt   = Theme.of(context).textTheme;

    final options = [
      (ReminderFrequency.none,        l10n.reminderFrequencyNone),
      (ReminderFrequency.weekly,      l10n.reminderFrequencyWeekly),
      (ReminderFrequency.fortnightly, l10n.reminderFrequencyFortnightly),
      (ReminderFrequency.monthly,     l10n.reminderFrequencyMonthly),
    ];

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: _Dims.handleTopPad),
          Container(
            width: AppDimensions.dragHandleWidth,
            height: AppDimensions.dragHandleThickness,
            decoration: BoxDecoration(
              color: cs.outlineVariant,
              borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppDimensions.buttonPaddingH,
              _Dims.titlePad,
              AppDimensions.buttonPaddingH,
              0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.customer == null
                      ? l10n.defaultReminderTitle
                      : l10n.setReminderTitle,
                  style: tt.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface,
                  ),
                ),
                if (widget.customer == null) ...[
                  const SizedBox(height: _Dims.labelFieldGap),
                  Text(
                    l10n.defaultReminderSheetHint,
                    style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                  ),
                ],
              ],
            ),
          ),
          RadioGroup<ReminderFrequency>(
            groupValue: _selected,
            onChanged: (v) => setState(() => _selected = v ?? _selected),
            child: Column(
              children: [
                for (final (freq, label) in options)
                  RadioListTile<ReminderFrequency>(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.buttonPaddingH,
                    ),
                    title: Text(label),
                    value: freq,
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppDimensions.buttonPaddingH,
              AppDimensions.buttonStackGap,
              AppDimensions.buttonPaddingH,
              _Dims.bottomPad,
            ),
            child: FilledButton(
              onPressed: _confirm,
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(AppDimensions.pillToggleHeight),
              ),
              child: Text(l10n.addCustomerSave),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirm() async {
    final customer    = widget.customer;
    final l10n        = AppLocalizations.of(context)!;

    if (customer != null && _selected != ReminderFrequency.none) {
      final granted = await ReminderScheduler.requestPermissions();
      if (!mounted) return;
      if (!granted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.notifPermDenied)),
        );
        if (mounted) context.pop();
        return;
      }
    }

    if (customer != null) {
      final updated    = customer.copyWith(reminderFrequency: _selected);
      final notifTitle = l10n.reminderNotifTitle;
      final notifBody  = l10n.reminderNotifBody(
        updated.name,
        updated.netBalance.abs().toStringAsFixed(0),
      );
      await ref.read(customerProvider.notifier).updateCustomer(updated);
      await ReminderScheduler.scheduleForCustomer(
        updated,
        notifTitle: notifTitle,
        notifBody: notifBody,
      );
    } else {
      await ref.read(reminderSettingsProvider.notifier).setFrequency(_selected);
    }
    if (mounted) context.pop();
  }
}
