import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/widgets/pill_toggle.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/repositories/i_customer_repository.dart';
import '../../domain/models/customer.dart';
import '../providers/customer_provider.dart';

abstract final class _Dims {
  static const double fieldGap       = 16.0;
  static const double sectionGap     = 24.0;
  static const double footerPaddingV = 12.0;
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
  bool  _saving         = false;

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
    _theyOweMe   = e == null || e.netBalance >= 0;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _shopCtrl.dispose();
    _balanceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n   = AppLocalizations.of(context)!;
    final cs     = Theme.of(context).colorScheme;
    final tt     = Theme.of(context).textTheme;
    final bottom = MediaQuery.paddingOf(context).bottom;
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
                vertical: _Dims.sectionGap,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _nameCtrl,
                      autofocus: !isEdit,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        labelText: l10n.addCustomerNameLabel,
                        hintText: l10n.addCustomerNameHint,
                      ),
                      validator: (v) {
                        final s = v?.trim() ?? '';
                        if (s.isEmpty) return l10n.addCustomerNameRequired;
                        if (s.length > 80) return l10n.addCustomerNameTooLong;
                        return null;
                      },
                    ),
                    const SizedBox(height: _Dims.fieldGap),
                    TextFormField(
                      controller: _phoneCtrl,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        labelText: l10n.addCustomerPhoneLabel,
                        hintText: l10n.addCustomerPhoneHint,
                      ),
                      validator: (v) {
                        final s = v?.trim() ?? '';
                        if (s.isEmpty) return null;
                        if (!_phoneRegex.hasMatch(s)) return l10n.addCustomerPhoneInvalid;
                        return null;
                      },
                    ),
                    const SizedBox(height: _Dims.fieldGap),
                    TextFormField(
                      controller: _shopCtrl,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        labelText: l10n.addCustomerShopLabel,
                        hintText: l10n.addCustomerShopHint,
                      ),
                    ),
                    const SizedBox(height: _Dims.sectionGap),
                    Text(
                      l10n.addCustomerBalanceLabel,
                      style: tt.labelLarge?.copyWith(color: cs.onSurface),
                    ),
                    const SizedBox(height: _Dims.fieldGap),
                    TextFormField(
                      controller: _balanceCtrl,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                      ],
                      decoration: InputDecoration(
                        labelText: l10n.addCustomerBalanceLabel,
                        hintText: l10n.addCustomerBalanceHint,
                        prefixText: '₹ ',
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
                    PillToggle(
                      labelA: l10n.addCustomerDirectionTheyOwe,
                      labelB: l10n.addCustomerDirectionIOwe,
                      selectedIndex: _theyOweMe ? 0 : 1,
                      onChanged: (i) => setState(() => _theyOweMe = i == 0),
                      selectedColor: _theyOweMe
                          ? cs.secondaryContainer
                          : cs.tertiaryContainer,
                      selectedTextColor: _theyOweMe
                          ? cs.onSecondaryContainer
                          : cs.onTertiaryContainer,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Sticky footer CTA ──────────────────────────────────────
          Container(
            decoration: BoxDecoration(
              color: cs.surface,
              boxShadow: [
                BoxShadow(
                  color: cs.shadow.withValues(alpha: AppDimensions.splashAlpha),
                  blurRadius: AppDimensions.shadowBlurCard,
                  offset: const Offset(0, AppDimensions.shadowOffsetFooter),
                ),
              ],
            ),
            padding: EdgeInsets.fromLTRB(
              AppDimensions.buttonPaddingH,
              _Dims.footerPaddingV,
              AppDimensions.buttonPaddingH,
              _Dims.footerPaddingV + bottom,
            ),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _saving ? null : _submit,
                child: _saving
                    ? const SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(l10n.addCustomerSave),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _saving = true);

    try {
      final rawBalance = double.tryParse(_balanceCtrl.text.trim()) ?? 0.0;
      final netBalance = _theyOweMe ? rawBalance : -rawBalance;

      final existing = widget.existingCustomer;
      if (existing != null) {
        final updated = existing.copyWith(
          name: _nameCtrl.text.trim(),
          phone: _phoneCtrl.text.trim().isEmpty ? null : _phoneCtrl.text.trim(),
          shopName: _shopCtrl.text.trim().isEmpty ? null : _shopCtrl.text.trim(),
          netBalance: netBalance,
        );
        await ref.read(customerProvider.notifier).updateCustomer(updated);
      } else {
        final customer = Customer(
          id: const Uuid().v4(),
          name: _nameCtrl.text.trim(),
          phone: _phoneCtrl.text.trim().isEmpty ? null : _phoneCtrl.text.trim(),
          shopName: _shopCtrl.text.trim().isEmpty ? null : _shopCtrl.text.trim(),
          netBalance: netBalance,
        );
        await ref.read(customerProvider.notifier).addCustomer(customer);
      }

      if (mounted) context.pop();
    } on DuplicateCustomerException {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.addCustomerDuplicate)),
        );
        setState(() => _saving = false);
      }
    } catch (_) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.addCustomerError)),
        );
        setState(() => _saving = false);
      }
    }
  }
}
