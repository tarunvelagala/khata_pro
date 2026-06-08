import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/services/contacts_service.dart';
import '../../../../core/services/reminder_scheduler.dart';
import '../../../../core/widgets/balance_direction_toggle.dart';
import '../../../../core/widgets/button_spinner.dart';
import '../../../../core/widgets/permission_rationale_sheet.dart';
import '../../../../core/widgets/set_reminder_sheet.dart';
import '../../../../design_system/atoms/kp_tonal_icon_button.dart';
import '../../../../design_system/molecules/kp_labeled_field.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/repositories/i_customer_repository.dart';
import '../../domain/models/customer.dart';
import '../../domain/models/reminder_frequency.dart';
import '../providers/customer_provider.dart';

abstract final class _Dims {
  static const double fieldGap        = 20.0;
  static const double sectionGap      = 28.0;
  static const double scrollPaddingV  = 24.0;
  static const double reminderRowH    = 52.0;
}


class AddCustomerScreen extends ConsumerStatefulWidget {
  const AddCustomerScreen({super.key, this.existingCustomer});

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
  DateTime?  _reminderDate;
  bool _saving           = false;

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
    _reminderFreq    = e?.reminderFrequency ?? ReminderFrequency.none;
    _reminderDate    = e?.reminderDate;
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
    final result  = await service.requestPermission();
    if (!mounted) return;

    if (result == ContactsPermResult.granted) {
      final contact = await service.pickContact();
      if (contact == null || !mounted) return;
      setState(() {
        _nameCtrl.text = contact.name.trim();
        if (contact.phone != null && contact.phone!.isNotEmpty) {
          _phoneCtrl.text = contact.phone!.replaceAll(RegExp(r'\D'), '');
        }
        _linkedContactId = contact.id;
      });
      return;
    }

    PermissionRationaleSheet.show(
      context,
      permission: PermissionContext.contacts,
      permanentlyDenied: result == ContactsPermResult.permanentlyDenied,
      onPrimary: result == ContactsPermResult.permanentlyDenied
          ? service.openSettings
          : _pickContact,
    );
  }

  Future<void> _openReminderSheet(AppLocalizations l10n) async {
    final result = await SetReminderSheet.showForForm(
      context,
      initialFreq: _reminderFreq,
      initialDate: _reminderDate,
    );
    if (result == null || !mounted) return;
    setState(() {
      _reminderFreq = result.frequency;
      _reminderDate = result.date;
    });
  }

  String _reminderSummary(AppLocalizations l10n) {
    if (_reminderDate != null) {
      return DateFormat('d MMM yyyy', l10n.localeName).format(_reminderDate!);
    }
    return switch (_reminderFreq) {
      ReminderFrequency.weekly      => l10n.reminderFrequencyWeekly,
      ReminderFrequency.fortnightly => l10n.reminderFrequencyFortnightly,
      ReminderFrequency.monthly     => l10n.reminderFrequencyMonthly,
      _                             => l10n.reminderFrequencyNone,
    };
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
        elevation: 0,
        scrolledUnderElevation: 0,
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
                    KpLabeledField(
                      label: l10n.addCustomerNameLabel,
                      child: TextFormField(
                        controller: _nameCtrl,
                        autofocus: !isEdit,
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: l10n.addCustomerNameHint,
                        ),
                        validator: (v) {
                          final s = v?.trim() ?? '';
                          if (s.isEmpty) return l10n.addCustomerNameRequired;
                          if (s.length > 80) return l10n.addCustomerNameTooLong;
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: _Dims.fieldGap),

                    // ── Phone ─────────────────────────────────────────
                    KpLabeledField(
                      label: l10n.addCustomerPhoneLabel,
                      child: TextFormField(
                        controller: _phoneCtrl,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: l10n.addCustomerPhoneHint,
                          suffixIcon: KpTonalIconButton(
                            tooltip: l10n.contactsImportButton,
                            icon: const Icon(Symbols.contacts_product),
                            isActive: _linkedContactId != null,
                            activeContainerColor: Theme.of(context).colorScheme.primaryContainer,
                            activeForegroundColor: Theme.of(context).colorScheme.primary,
                            onPressed: _pickContact,
                          ),
                        ),
                        validator: (v) {
                          final s = v?.trim() ?? '';
                          if (s.isEmpty) return null;
                          if (!_phoneRegex.hasMatch(s)) return l10n.addCustomerPhoneInvalid;
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: _Dims.fieldGap),

                    // ── Shop name ─────────────────────────────────────
                    KpLabeledField(
                      label: l10n.addCustomerShopLabel,
                      child: TextFormField(
                        controller: _shopCtrl,
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: l10n.addCustomerShopHint,
                        ),
                      ),
                    ),
                    const SizedBox(height: _Dims.sectionGap),

                    // ── Opening balance ───────────────────────────────
                    KpLabeledField(
                      label: l10n.addCustomerBalanceLabel,
                      child: TextFormField(
                        controller: _balanceCtrl,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                        ],
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          hintText: l10n.addCustomerBalanceHint,
                          prefixText: '₹  ',
                        ),
                        validator: (v) {
                          final s = v?.trim() ?? '';
                          if (s.isEmpty) return null;
                          final n = double.tryParse(s);
                          if (n == null || n < 0) return l10n.addCustomerBalanceInvalid;
                          return null;
                        },
                      ),
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
                    _ReminderRow(
                      summary: _reminderSummary(l10n),
                      onTap: () => _openReminderSheet(l10n),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Builder(
            builder: (ctx) {
              final bottom = MediaQuery.paddingOf(ctx).bottom;
              return Padding(
                padding: EdgeInsets.fromLTRB(
                  AppDimensions.buttonPaddingH,
                  AppDimensions.buttonPaddingV / 2,
                  AppDimensions.buttonPaddingH,
                  AppDimensions.buttonPaddingV / 2 + bottom,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: _saving
                      ? FilledButton(onPressed: null, child: const ButtonSpinner())
                      : FilledButton(
                          onPressed: _submit,
                          child: Text(l10n.addCustomerSave),
                        ),
                ),
              );
            },
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
      final result = await service.requestPermission();
      if (result == ContactsPermResult.granted) {
        contactId = await service.createContact(name: name, phone: phone);
      }
      // On denial: silently skip contact creation — customer save proceeds regardless
    } else {
      await service.updateContact(contactId: _linkedContactId!, name: name, phone: phone);
    }

    try {
      final rawBalance = double.tryParse(_balanceCtrl.text.trim()) ?? 0.0;
      final netBalance = _theyOweMe ? rawBalance : -rawBalance;

      final existing = widget.existingCustomer;
      if (existing != null) {
        final updated = existing.copyWith(
          name: name,
          phone: phone,
          shopName: _shopCtrl.text.trim().isEmpty ? null : _shopCtrl.text.trim(),
          netBalance: netBalance,
          contactId: contactId,
          clearContactId: contactId == null,
          reminderFrequency: _reminderDate != null ? ReminderFrequency.none : _reminderFreq,
          reminderDate: _reminderDate,
          clearReminderDate: _reminderDate == null,
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
          reminderFrequency: _reminderDate != null ? ReminderFrequency.none : _reminderFreq,
          reminderDate: _reminderDate,
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


// ── Reminder row ──────────────────────────────────────────────────────────────

class _ReminderRow extends StatelessWidget {
  const _ReminderRow({
    required this.summary,
    required this.onTap,
  });

  final String summary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;
    final isSet = summary != l10n.reminderFrequencyNone;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
      child: Container(
        constraints: const BoxConstraints(minHeight: _Dims.reminderRowH),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.inputPaddingH,
          vertical: AppDimensions.buttonStackGap,
        ),
        decoration: BoxDecoration(
          color: cs.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.alarm_rounded,
              size: AppDimensions.iconSizeMedium,
              color: isSet ? cs.primary : cs.onSurfaceVariant,
            ),
            const SizedBox(width: AppDimensions.inputPaddingH),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.setReminderTitle,
                    style: tt.bodyLarge?.copyWith(
                      color: cs.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    summary,
                    style: tt.bodySmall?.copyWith(
                      color: isSet ? cs.primary : cs.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: cs.onSurfaceVariant,
              size: AppDimensions.iconSizeMedium,
            ),
          ],
        ),
      ),
    );
  }
}
