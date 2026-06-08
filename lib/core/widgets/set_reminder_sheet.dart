import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constants/app_dimensions.dart';
import '../../features/home/domain/models/customer.dart';
import '../../features/home/domain/models/reminder_frequency.dart';
import '../../features/home/presentation/providers/customer_provider.dart';
import '../../features/settings/presentation/providers/reminder_settings_provider.dart';
import '../../l10n/app_localizations.dart';
import '../services/reminder_scheduler.dart';
import 'permission_rationale_sheet.dart';

abstract final class _Dims {
  static const double handleTopPad  = 12.0;
  static const double titlePad      = 16.0;
  static const double bottomPad     = 24.0;
  static const double labelFieldGap = 4.0;
  static const double chipSpacing   = 8.0;
  static const double chipRunSpacing = 8.0;
  static const double chipPadH      = 14.0;
  static const double chipPadV      = 8.0;
  static const double sectionGap    = 16.0;
  static const double modeGap       = 12.0;
}

enum _ReminderHour {
  morning(9),
  afternoon(13),
  evening(18);

  const _ReminderHour(this.hour);
  final int hour;
}

/// Result returned by [SetReminderSheet.showForForm].
class ReminderFormResult {
  const ReminderFormResult({
    required this.frequency,
    this.date,
  });

  final ReminderFrequency frequency;

  /// Non-null only when a specific date was chosen (frequency is ignored).
  final DateTime? date;
}

/// Bottom sheet for choosing a reminder.
///
/// Three entry points:
/// - [show]        — per-customer mode: saves directly to Customer + schedules.
/// - [showGlobal]  — settings mode: saves to SharedPreferences default only.
/// - [showForForm] — form mode: returns [ReminderFormResult], caller saves.
class SetReminderSheet extends ConsumerStatefulWidget {
  const SetReminderSheet._({
    required this.initialFreq,
    required this.initialDate,
    required this.customer,
    required this.formMode,
  });

  final ReminderFrequency initialFreq;
  final DateTime?         initialDate;
  final Customer?         customer;
  final bool              formMode;

  static Future<void> show(
    BuildContext context,
    WidgetRef ref,
    Customer customer,
  ) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => SetReminderSheet._(
        initialFreq: customer.reminderFrequency,
        initialDate: customer.reminderDate,
        customer: customer,
        formMode: false,
      ),
    );
  }

  static Future<void> showGlobal(BuildContext context, WidgetRef ref) {
    final current = ref.read(reminderSettingsProvider).value ?? ReminderFrequency.none;
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => SetReminderSheet._(
        initialFreq: current,
        initialDate: null,
        customer: null,
        formMode: false,
      ),
    );
  }

  /// Opens the sheet without saving. Returns the user's selection or null if
  /// dismissed. The caller is responsible for persisting the result.
  static Future<ReminderFormResult?> showForForm(
    BuildContext context, {
    ReminderFrequency initialFreq = ReminderFrequency.none,
    DateTime? initialDate,
  }) {
    return showModalBottomSheet<ReminderFormResult>(
      context: context,
      isScrollControlled: true,
      builder: (_) => SetReminderSheet._(
        initialFreq: initialFreq,
        initialDate: initialDate,
        customer: null,
        formMode: true,
      ),
    );
  }

  @override
  ConsumerState<SetReminderSheet> createState() => _SetReminderSheetState();
}

class _SetReminderSheetState extends ConsumerState<SetReminderSheet> {
  late bool              _onDate;
  late ReminderFrequency _freq;
  DateTime?              _date;
  _ReminderHour          _hour = _ReminderHour.morning;

  @override
  void initState() {
    super.initState();
    _onDate = widget.initialDate != null;
    _freq   = widget.initialFreq;
    _date   = widget.initialDate;
    if (widget.initialDate != null) {
      final h = widget.initialDate!.hour;
      _hour = h >= 18 ? _ReminderHour.evening
            : h >= 13 ? _ReminderHour.afternoon
            :           _ReminderHour.morning;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs   = Theme.of(context).colorScheme;
    final tt   = Theme.of(context).textTheme;

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Handle ───────────────────────────────────────────────
            const SizedBox(height: _Dims.handleTopPad),
            Center(
              child: Container(
                width: AppDimensions.dragHandleWidth,
                height: AppDimensions.dragHandleThickness,
                decoration: BoxDecoration(
                  color: cs.outlineVariant,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
                ),
              ),
            ),

            // ── Title ────────────────────────────────────────────────
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
                    widget.customer == null && !widget.formMode
                        ? l10n.defaultReminderTitle
                        : l10n.setReminderTitle,
                    style: tt.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: cs.onSurface,
                    ),
                  ),
                  if (widget.customer == null && !widget.formMode) ...[
                    const SizedBox(height: _Dims.labelFieldGap),
                    Text(
                      l10n.defaultReminderSheetHint,
                      style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: _Dims.sectionGap),

            // ── Mode toggle (recurring / on date) ────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.buttonPaddingH,
              ),
              child: Row(
                children: [
                  _Chip(
                    label: l10n.reminderModeRecurring,
                    selected: !_onDate,
                    onTap: () => setState(() {
                      _onDate = false;
                      _date   = null;
                    }),
                  ),
                  const SizedBox(width: _Dims.chipSpacing),
                  _Chip(
                    label: l10n.reminderModeOnDate,
                    selected: _onDate,
                    onTap: () => setState(() {
                      _onDate = true;
                      _freq   = ReminderFrequency.none;
                    }),
                  ),
                ],
              ),
            ),

            const SizedBox(height: _Dims.modeGap),

            // ── Recurring: frequency radio list ──────────────────────
            if (!_onDate) ...[
              RadioGroup<ReminderFrequency>(
                groupValue: _freq,
                onChanged: (v) {
                  setState(() => _freq = v ?? _freq);
                  _confirm();
                },
                child: Column(
                  children: [
                    for (final (freq, label) in [
                      (ReminderFrequency.none,        l10n.reminderFrequencyNone),
                      (ReminderFrequency.weekly,      l10n.reminderFrequencyWeekly),
                      (ReminderFrequency.fortnightly, l10n.reminderFrequencyFortnightly),
                      (ReminderFrequency.monthly,     l10n.reminderFrequencyMonthly),
                    ])
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
            ],

            // ── Specific date ─────────────────────────────────────────
            if (_onDate) ...[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.buttonPaddingH,
                ),
                child: _DateTile(
                  date: _date,
                  onChanged: (d) => setState(() => _date = d),
                ),
              ),
              if (_date != null) ...[
                const SizedBox(height: _Dims.modeGap),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.buttonPaddingH,
                  ),
                  child: Wrap(
                    spacing: _Dims.chipSpacing,
                    runSpacing: _Dims.chipRunSpacing,
                    children: [
                      for (final (h, label) in [
                        (_ReminderHour.morning,   l10n.reminderTimeMorning),
                        (_ReminderHour.afternoon, l10n.reminderTimeAfternoon),
                        (_ReminderHour.evening,   l10n.reminderTimeEvening),
                      ])
                        _Chip(
                          label: label,
                          selected: _hour == h,
                          onTap: () => setState(() => _hour = h),
                        ),
                    ],
                  ),
                ),
              ],
            ],

            // ── Confirm button (date mode only) ──────────────────────
            if (_onDate) ...[
              Padding(
                padding: EdgeInsets.fromLTRB(
                  AppDimensions.buttonPaddingH,
                  _Dims.sectionGap,
                  AppDimensions.buttonPaddingH,
                  _Dims.bottomPad,
                ),
                child: FilledButton(
                  onPressed: _confirm,
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(AppDimensions.pillToggleHeight),
                  ),
                  child: Text(l10n.setReminderSave),
                ),
              ),
            ] else ...[
              const SizedBox(height: _Dims.bottomPad),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _confirm() async {
    final l10n = AppLocalizations.of(context)!;

    // Form mode — return result to caller, no saving here.
    if (widget.formMode) {
      final date = _onDate && _date != null
          ? DateTime(
              _date!.year, _date!.month, _date!.day, _hour.hour,
            )
          : null;
      if (mounted) {
        Navigator.of(context).pop(
          ReminderFormResult(
            frequency: _onDate ? ReminderFrequency.none : _freq,
            date: date,
          ),
        );
      }
      return;
    }

    final customer = widget.customer;

    // Recurring on existing customer — need notification permission.
    if (customer != null && _freq != ReminderFrequency.none && !_onDate) {
      final result = await ReminderScheduler.requestPermissions();
      if (!mounted) return;
      if (result != NotifPermResult.granted) {
        PermissionRationaleSheet.show(
          context,
          permission: PermissionContext.notifications,
          permanentlyDenied: result == NotifPermResult.permanentlyDenied,
          onPrimary: result == NotifPermResult.permanentlyDenied
              ? openAppSettings
              : _confirm,
        );
        return;
      }
    }

    if (customer != null) {
      final effectiveDate = _onDate && _date != null
          ? DateTime(_date!.year, _date!.month, _date!.day, _hour.hour)
          : null;
      final updated = customer.copyWith(
        reminderFrequency: _onDate ? ReminderFrequency.none : _freq,
        reminderDate: effectiveDate,
        clearReminderDate: effectiveDate == null,
      );
      await ref.read(customerProvider.notifier).updateCustomer(updated);
      await ReminderScheduler.scheduleForCustomer(
        updated,
        notifTitle: l10n.reminderNotifTitle,
        notifBody: l10n.reminderNotifBody(
          updated.name,
          updated.netBalance.abs().toStringAsFixed(0),
        ),
      );
    } else {
      await ref.read(reminderSettingsProvider.notifier).setFrequency(_freq);
    }
    if (mounted) context.pop();
  }
}

// ── Select chip ───────────────────────────────────────────────────────────────

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppDimensions.animShort,
        padding: const EdgeInsets.symmetric(
          horizontal: _Dims.chipPadH,
          vertical: _Dims.chipPadV,
        ),
        decoration: BoxDecoration(
          color: selected ? cs.primaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(AppDimensions.radiusInput),
          border: Border.all(
            color: selected ? cs.primary : cs.outlineVariant,
            width: selected ? AppDimensions.borderFocused : AppDimensions.borderDefault,
          ),
        ),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: tt.labelMedium?.copyWith(
            color: selected ? cs.onPrimaryContainer : cs.onSurfaceVariant,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

// ── Date picker tile ──────────────────────────────────────────────────────────

class _DateTile extends StatelessWidget {
  const _DateTile({required this.date, required this.onChanged});

  final DateTime? date;
  final ValueChanged<DateTime?> onChanged;

  @override
  Widget build(BuildContext context) {
    final cs   = Theme.of(context).colorScheme;
    final tt   = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    final hasDate     = date != null;
    final displayText = hasDate
        ? DateFormat('d MMM yyyy', l10n.localeName).format(date!)
        : l10n.reminderDateHint;

    return InkWell(
      onTap: () async {
        final now    = DateTime.now();
        final picked = await showDatePicker(
          context: context,
          initialDate: date ?? now.add(const Duration(days: 1)),
          firstDate:   now,
          lastDate:    now.add(const Duration(days: 365 * 2)),
        );
        if (picked != null) onChanged(picked);
      },
      borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
      child: InputDecorator(
        decoration: InputDecoration(
          hintText: l10n.reminderDateHint,
          prefixIcon: const Icon(Icons.calendar_today_rounded),
          suffixIcon: hasDate
              ? IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => onChanged(null),
                )
              : null,
        ),
        child: Text(
          displayText,
          style: tt.bodyLarge?.copyWith(
            color: hasDate ? cs.onSurface : cs.outline,
          ),
        ),
      ),
    );
  }
}
