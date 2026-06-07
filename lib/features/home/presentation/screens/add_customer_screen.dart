import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/services/contacts_service.dart';
import '../../../../core/services/reminder_scheduler.dart';
import '../../../../core/widgets/balance_direction_toggle.dart';
import '../../../../core/widgets/sticky_footer_cta.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/repositories/i_customer_repository.dart';
import '../../domain/models/customer.dart';
import '../../domain/models/reminder_frequency.dart';
import '../providers/customer_provider.dart';
import '../../../../features/settings/presentation/providers/reminder_settings_provider.dart';

/// All spacing tokens for the Add/Edit Customer form.
///
/// Tune these to trade breathing room for compactness when new fields arrive:
///   - Reduce [fieldGap] first (field-to-field rhythm).
///   - Reduce [sectionGap] second (balance↔reminder separator).
///   - Reduce [scrollPaddingV] last (top/bottom inset of the scroll area).
abstract final class _Dims {
  /// Gap between consecutive form fields.
  static const double fieldGap      = 16.0;

  /// Larger gap used before a new visual section (e.g. balance → reminder).
  static const double sectionGap    = 20.0;

  /// Vertical padding at the top and bottom of the scrollable form area.
  static const double scrollPaddingV = 20.0;

  /// Gap between the alarm icon and its label in the reminder row header.
  static const double reminderIconGap = 6.0;

  /// Gap between the reminder row header and its toggle/picker.
  static const double reminderHeaderGap = 12.0;

  /// Gap between mode toggle and the content below it.
  static const double reminderModeGap = 12.0;

  /// Gap between date picker and time slot chips.
  static const double reminderTimeGap = 10.0;
}

enum _ReminderHour {
  morning(9),
  afternoon(13),
  evening(18);

  const _ReminderHour(this.hour);
  final int hour;
}

class AddCustomerScreen extends ConsumerStatefulWidget {
  const AddCustomerScreen({super.key, this.existingCustomer});

  /// When non-null, the screen operates in edit mode.
  final Customer? existingCustomer;

  @override
  ConsumerState<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends ConsumerState<AddCustomerScreen> {
  final _formKey        = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _shopCtrl;
  late final TextEditingController _balanceCtrl;
  late bool  _theyOweMe;
  late ReminderFrequency _reminderFreq;
  late bool  _reminderOnDate;   // true = "On a date" mode
  DateTime?  _reminderDate;
  _ReminderHour _reminderHour = _ReminderHour.morning;
  bool  _saving         = false;

  String? _linkedContactId;

  static final _phoneRegex = RegExp(r'^\d{10,15}$');

  @override
  void initState() {
    super.initState();
    final e = widget.existingCustomer;
    _nameCtrl    = TextEditingController(text: e?.name ?? '');
    _phoneCtrl   = TextEditingController(text: e?.phone ?? '');
    _shopCtrl    = TextEditingController(text: e?.shopName ?? '');
    final bal    = e?.netBalance ?? 0.0;
    _balanceCtrl = TextEditingController(
      text: bal != 0 ? bal.abs().toStringAsFixed(bal.abs() % 1 == 0 ? 0 : 2) : '',
    );
    _theyOweMe       = e == null || e.netBalance >= 0;
    _linkedContactId = e?.contactId;
    _reminderFreq    = e?.reminderFrequency
        ?? ref.read(reminderSettingsProvider).value
        ?? ReminderFrequency.none;
    _reminderOnDate  = e?.reminderDate != null;
    _reminderDate    = e?.reminderDate;
    if (e?.reminderDate != null) {
      final h = e!.reminderDate!.hour;
      _reminderHour = h >= 18 ? _ReminderHour.evening
                    : h >= 13 ? _ReminderHour.afternoon
                    :           _ReminderHour.morning;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _shopCtrl.dispose();
    _balanceCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickContact() async {
    final service = ref.read(contactsServiceProvider);
    final granted = await service.requestPermission();
    if (!granted) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.contactsPermissionDenied)),
        );
      }
      return;
    }
    final contact = await service.pickContact();
    if (contact == null || !mounted) return;
    setState(() {
      _nameCtrl.text = contact.name.trim();
      if (contact.phone != null && contact.phone!.isNotEmpty) {
        _phoneCtrl.text = contact.phone!.replaceAll(RegExp(r'\D'), '');
      }
      _linkedContactId = contact.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n   = AppLocalizations.of(context)!;
    final cs     = Theme.of(context).colorScheme;
    final isEdit = widget.existingCustomer != null;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        surfaceTintColor: Colors.transparent,
        title: Text(isEdit ? l10n.editCustomerTitle : l10n.addCustomerTitle),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.buttonPaddingH,
                vertical: _Dims.scrollPaddingV,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Name ──────────────────────────────────────────
                    TextFormField(
                      controller: _nameCtrl,
                      autofocus: !isEdit,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: l10n.addCustomerNameLabel,
                        hintText: l10n.addCustomerNameHint,
                        prefixIcon: const Icon(Icons.person_outline_rounded),
                      ),
                      validator: (v) {
                        final s = v?.trim() ?? '';
                        if (s.isEmpty) return l10n.addCustomerNameRequired;
                        if (s.length > 80) return l10n.addCustomerNameTooLong;
                        return null;
                      },
                    ),
                    const SizedBox(height: _Dims.fieldGap),

                    // ── Phone + contacts import ────────────────────────
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _phoneCtrl,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: l10n.addCustomerPhoneLabel,
                                hintText: l10n.addCustomerPhoneHint,
                                prefixIcon: const Icon(Icons.phone_outlined),
                              ),
                              validator: (v) {
                                final s = v?.trim() ?? '';
                                if (s.isEmpty) return null;
                                if (!_phoneRegex.hasMatch(s)) return l10n.addCustomerPhoneInvalid;
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: AppDimensions.buttonStackGap),
                          Tooltip(
                            message: l10n.contactsImportButton,
                            child: InkWell(
                              onTap: _pickContact,
                              borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
                              child: Container(
                                width: AppDimensions.pillToggleHeight,
                                decoration: BoxDecoration(
                                  color: _linkedContactId != null
                                      ? cs.primaryContainer
                                      : cs.surfaceContainerHighest,
                                  borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
                                  border: Border.all(
                                    color: _linkedContactId != null
                                        ? cs.primary
                                        : cs.outlineVariant,
                                    width: AppDimensions.borderDefault,
                                  ),
                                ),
                                child: Icon(
                                  Symbols.contacts_product,
                                  color: _linkedContactId != null
                                      ? cs.primary
                                      : cs.onSurfaceVariant,
                                  size: AppDimensions.iconSizeMedium,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: _Dims.fieldGap),

                    // ── Shop name ─────────────────────────────────────
                    TextFormField(
                      controller: _shopCtrl,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: l10n.addCustomerShopLabel,
                        hintText: l10n.addCustomerShopHint,
                        prefixIcon: const Icon(Icons.storefront_outlined),
                      ),
                    ),
                    const SizedBox(height: _Dims.fieldGap),

                    // ── Opening balance ───────────────────────────────
                    TextFormField(
                      controller: _balanceCtrl,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                      ],
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        labelText: l10n.addCustomerBalanceLabel,
                        hintText: l10n.addCustomerBalanceHint,
                        prefixIcon: const Icon(Icons.currency_rupee_rounded),
                      ),
                      validator: (v) {
                        final s = v?.trim() ?? '';
                        if (s.isEmpty) return null;
                        final n = double.tryParse(s);
                        if (n == null || n < 0) return l10n.addCustomerBalanceInvalid;
                        return null;
                      },
                    ),
                    const SizedBox(height: _Dims.fieldGap),

                    BalanceDirectionToggle(
                      labelPositive: l10n.addCustomerDirectionTheyOwe,
                      labelNegative: l10n.addCustomerDirectionIOwe,
                      isPositive: _theyOweMe,
                      onChanged: (v) => setState(() => _theyOweMe = v),
                    ),
                    const SizedBox(height: _Dims.sectionGap),

                    // ── Reminder ──────────────────────────────────────
                    _ReminderSelector(
                      label: l10n.setReminderTitle,
                      onDate: _reminderOnDate,
                      freq: _reminderFreq,
                      date: _reminderDate,
                      hour: _reminderHour,
                      onModeChanged: (isOnDate) => setState(() {
                        _reminderOnDate = isOnDate;
                        if (isOnDate) {
                          _reminderFreq = ReminderFrequency.none;
                        } else {
                          _reminderDate = null;
                        }
                      }),
                      onFreqChanged: (v) => setState(() => _reminderFreq = v),
                      onDateChanged: (v) => setState(() => _reminderDate = v),
                      onHourChanged: (v) => setState(() => _reminderHour = v),
                    ),
                  ],
                ),
              ),
            ),
          ),

          StickyFooterCta(
            label: l10n.addCustomerSave,
            onPressed: _submit,
            loading: _saving,
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _saving = true);

    final name  = _nameCtrl.text.trim();
    final phone = _phoneCtrl.text.trim().isEmpty ? null : _phoneCtrl.text.trim();
    final l10n  = AppLocalizations.of(context)!;

    String? contactId = _linkedContactId;

    final service = ref.read(contactsServiceProvider);

    if (_linkedContactId == null) {
      final granted = await service.requestPermission();
      if (granted) {
        contactId = await service.createContact(name: name, phone: phone);
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.contactsPermissionDenied)),
        );
      }
    } else {
      // Contact already linked — keep it in sync with any name/phone edits.
      await service.updateContact(contactId: _linkedContactId!, name: name, phone: phone);
    }

    try {
      final rawBalance = double.tryParse(_balanceCtrl.text.trim()) ?? 0.0;
      final netBalance = _theyOweMe ? rawBalance : -rawBalance;

      // Combine picked date with selected time slot hour.
      final effectiveDate = _reminderOnDate && _reminderDate != null
          ? DateTime(
              _reminderDate!.year,
              _reminderDate!.month,
              _reminderDate!.day,
              _reminderHour.hour,
            )
          : null;

      final existing = widget.existingCustomer;
      if (existing != null) {
        final updated = existing.copyWith(
          name: name,
          phone: phone,
          shopName: _shopCtrl.text.trim().isEmpty ? null : _shopCtrl.text.trim(),
          netBalance: netBalance,
          contactId: contactId,
          clearContactId: contactId == null,
          reminderFrequency: _reminderOnDate ? ReminderFrequency.none : _reminderFreq,
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
        final customer = Customer(
          id: const Uuid().v4(),
          name: name,
          phone: phone,
          shopName: _shopCtrl.text.trim().isEmpty ? null : _shopCtrl.text.trim(),
          netBalance: netBalance,
          contactId: contactId,
          reminderFrequency: _reminderOnDate ? ReminderFrequency.none : _reminderFreq,
          reminderDate: effectiveDate,
        );
        await ref.read(customerProvider.notifier).addCustomer(customer);
      }

      if (mounted) context.pop();
    } on DuplicateCustomerException {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.addCustomerDuplicate)),
        );
        setState(() => _saving = false);
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.addCustomerError)),
        );
        setState(() => _saving = false);
      }
    }
  }
}

// ── Reminder selector (two-mode: Recurring | On a date) ──────────────────────

class _ReminderSelector extends StatelessWidget {
  const _ReminderSelector({
    required this.label,
    required this.onDate,
    required this.freq,
    required this.date,
    required this.hour,
    required this.onModeChanged,
    required this.onFreqChanged,
    required this.onDateChanged,
    required this.onHourChanged,
  });

  final String label;
  final bool onDate;
  final ReminderFrequency freq;
  final DateTime? date;
  final _ReminderHour hour;
  final ValueChanged<bool> onModeChanged;
  final ValueChanged<ReminderFrequency> onFreqChanged;
  final ValueChanged<DateTime?> onDateChanged;
  final ValueChanged<_ReminderHour> onHourChanged;

  @override
  Widget build(BuildContext context) {
    final cs   = Theme.of(context).colorScheme;
    final tt   = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Icon(Icons.alarm_rounded,
                size: AppDimensions.iconSizeSmall, color: cs.onSurfaceVariant),
            const SizedBox(width: _Dims.reminderIconGap),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: tt.labelMedium?.copyWith(color: cs.onSurfaceVariant),
              ),
            ),
          ],
        ),
        const SizedBox(height: _Dims.reminderHeaderGap),

        // ── Mode toggle ────────────────────────────────────────────────
        Row(
          children: [
            Flexible(
              child: _ModeChip(
                label: l10n.reminderModeRecurring,
                selected: !onDate,
                onTap: () => onModeChanged(false),
              ),
            ),
            const SizedBox(width: AppDimensions.buttonStackGap),
            Flexible(
              child: _ModeChip(
                label: l10n.reminderModeOnDate,
                selected: onDate,
                onTap: () => onModeChanged(true),
              ),
            ),
          ],
        ),
        const SizedBox(height: _Dims.reminderModeGap),

        // ── Content ────────────────────────────────────────────────────
        if (!onDate)
          _FreqChipRow(selected: freq, onChanged: onFreqChanged)
        else ...[
          _DatePickerTile(date: date, onChanged: onDateChanged),
          if (date != null) ...[
            const SizedBox(height: _Dims.reminderTimeGap),
            _TimeSlotRow(selected: hour, onChanged: onHourChanged),
          ],
        ],
      ],
    );
  }
}

// ── Mode toggle chip ──────────────────────────────────────────────────────────

class _ModeChip extends StatelessWidget {
  const _ModeChip({
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
          horizontal: AppDimensions.inputPaddingH,
          vertical: AppDimensions.buttonStackGap,
        ),
        decoration: BoxDecoration(
          color: selected ? cs.primaryContainer : cs.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
          border: Border.all(
            color: selected ? cs.primary : cs.outlineVariant,
            width: selected
                ? AppDimensions.borderFocused
                : AppDimensions.borderDefault,
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

// ── Frequency chip row ────────────────────────────────────────────────────────

class _FreqChipRow extends StatelessWidget {
  const _FreqChipRow({
    required this.selected,
    required this.onChanged,
  });

  final ReminderFrequency selected;
  final ValueChanged<ReminderFrequency> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final options = [
      (ReminderFrequency.none,        l10n.reminderFrequencyNone),
      (ReminderFrequency.weekly,      l10n.reminderFrequencyWeekly),
      (ReminderFrequency.fortnightly, l10n.reminderFrequencyFortnightly),
      (ReminderFrequency.monthly,     l10n.reminderFrequencyMonthly),
    ];

    return Wrap(
      spacing: AppDimensions.buttonStackGap,
      runSpacing: AppDimensions.buttonStackGap,
      children: [
        for (final (freq, chipLabel) in options)
          _FreqChip(
            label: chipLabel,
            selected: freq == selected,
            onTap: () => onChanged(freq),
          ),
      ],
    );
  }
}

// ── Date picker tile ──────────────────────────────────────────────────────────

class _DatePickerTile extends StatelessWidget {
  const _DatePickerTile({required this.date, required this.onChanged});

  final DateTime? date;
  final ValueChanged<DateTime?> onChanged;

  @override
  Widget build(BuildContext context) {
    final cs   = Theme.of(context).colorScheme;
    final tt   = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    final hasDate = date != null;
    final displayText = hasDate
        ? '${date!.day.toString().padLeft(2, '0')} / '
          '${date!.month.toString().padLeft(2, '0')} / '
          '${date!.year}'
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
                  tooltip: l10n.cancelAction,
                )
              : const Icon(Icons.chevron_right_rounded),
        ),
        child: Text(
          displayText,
          style: tt.bodyLarge?.copyWith(
            color: hasDate ? cs.onSurface : cs.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

// ── Time slot row (Morning / Afternoon / Evening) ─────────────────────────────

class _TimeSlotRow extends StatelessWidget {
  const _TimeSlotRow({required this.selected, required this.onChanged});

  final _ReminderHour selected;
  final ValueChanged<_ReminderHour> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final slots = [
      (_ReminderHour.morning,   l10n.reminderTimeMorning),
      (_ReminderHour.afternoon, l10n.reminderTimeAfternoon),
      (_ReminderHour.evening,   l10n.reminderTimeEvening),
    ];
    return Wrap(
      spacing: AppDimensions.buttonStackGap,
      runSpacing: AppDimensions.buttonStackGap,
      children: [
        for (final (slot, label) in slots)
          _FreqChip(
            label: label,
            selected: slot == selected,
            onTap: () => onChanged(slot),
          ),
      ],
    );
  }
}

// ── Frequency chip (used inside _FreqChipRow and _TimeSlotRow) ────────────────

class _FreqChip extends StatelessWidget {
  const _FreqChip({
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
          horizontal: AppDimensions.inputPaddingH,
          vertical: AppDimensions.buttonStackGap,
        ),
        decoration: BoxDecoration(
          color: selected ? cs.primaryContainer : cs.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
          border: Border.all(
            color: selected ? cs.primary : cs.outlineVariant,
            width: selected
                ? AppDimensions.borderFocused
                : AppDimensions.borderDefault,
          ),
        ),
        child: Text(
          label,
          style: tt.labelMedium?.copyWith(
            color: selected ? cs.onPrimaryContainer : cs.onSurfaceVariant,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
