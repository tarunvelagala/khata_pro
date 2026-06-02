import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/widgets/pill_toggle.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/models/customer.dart';
import '../../domain/models/transaction.dart';
import '../providers/customer_provider.dart';
import '../providers/customer_transactions_provider.dart';

abstract final class _Dims {
  static const double fieldGap       = 16.0;
  static const double sectionGap     = 24.0;
  static const double amountFontSize = 48.0;
  static const double footerPaddingV = 12.0;
}

class AddEntryScreen extends ConsumerStatefulWidget {
  const AddEntryScreen({
    super.key,
    required this.customerId,
    this.existingTxn,
  });

  final String customerId;
  /// When non-null the screen operates in edit mode (delete-old + insert-new).
  final Transaction? existingTxn;

  @override
  ConsumerState<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends ConsumerState<AddEntryScreen> {
  late final TextEditingController _amountCtrl;
  late final TextEditingController _noteCtrl;
  late bool  _isGave;
  bool  _saving = false;

  @override
  void initState() {
    super.initState();
    final e = widget.existingTxn;
    _amountCtrl = TextEditingController(
      text: e != null ? e.amount.toStringAsFixed(e.amount % 1 == 0 ? 0 : 2) : '',
    );
    _noteCtrl = TextEditingController(text: e?.note ?? '');
    _isGave   = e?.isCredit ?? true;
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n   = AppLocalizations.of(context)!;
    final cs     = Theme.of(context).colorScheme;
    final tt     = Theme.of(context).textTheme;
    final bottom = MediaQuery.paddingOf(context).bottom;
    final isEdit = widget.existingTxn != null;

    final customersAsync = ref.watch(customerProvider);
    final customer = customersAsync.value
        ?.where((c) => c.id == widget.customerId)
        .firstOrNull;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        surfaceTintColor: Colors.transparent,
        title: Text(isEdit ? l10n.editEntryTitle : (customer?.name ?? l10n.addEntryTitle)),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PillToggle(
                    labelA: l10n.addEntryGave,
                    labelB: l10n.addEntryReceived,
                    selectedIndex: _isGave ? 0 : 1,
                    onChanged: (i) => setState(() => _isGave = i == 0),
                    selectedColor: _isGave
                        ? cs.secondaryContainer
                        : cs.tertiaryContainer,
                    selectedTextColor: _isGave
                        ? cs.onSecondaryContainer
                        : cs.onTertiaryContainer,
                  ),
                  const SizedBox(height: _Dims.sectionGap),

                  // Large centred amount field
                  TextField(
                    controller: _amountCtrl,
                    autofocus: true,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*')),
                    ],
                    textAlign: TextAlign.center,
                    style: tt.displaySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: cs.onSurface,
                      fontSize: _Dims.amountFontSize,
                    ),
                    decoration: InputDecoration(
                      hintText: '0',
                      hintStyle: tt.displaySmall?.copyWith(
                        color: cs.onSurfaceVariant,
                        fontSize: _Dims.amountFontSize,
                      ),
                      prefixText: '₹  ',
                      prefixStyle: tt.displaySmall?.copyWith(
                        color: cs.onSurfaceVariant,
                        fontSize: _Dims.amountFontSize,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                  const SizedBox(height: _Dims.fieldGap),

                  TextFormField(
                    controller: _noteCtrl,
                    maxLines: 3,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      labelText: l10n.addEntryNoteLabel,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Sticky footer CTA ────────────────────────────────────
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
                onPressed: _saving ? null : () => _submit(customer),
                child: _saving
                    ? const SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(l10n.addEntrySave),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submit(Customer? customer) async {
    final l10n   = AppLocalizations.of(context)!;
    final amount = double.tryParse(_amountCtrl.text.trim());

    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.addEntryAmountRequired)),
      );
      return;
    }
    if (customer == null) return;

    setState(() => _saving = true);

    final notifier = ref.read(customerTransactionsProvider(customer.id).notifier);

    try {
      if (widget.existingTxn != null) {
        await notifier.deleteTransaction(widget.existingTxn!.id);
      }

      final txn = Transaction(
        id: const Uuid().v4(),
        customerId: customer.id,
        customerName: customer.name,
        shopName: customer.shopName,
        avatarLabel:
            customer.name.isNotEmpty ? customer.name[0].toUpperCase() : '?',
        amount: amount,
        isCredit: _isGave,
        note: _noteCtrl.text.trim().isEmpty ? null : _noteCtrl.text.trim(),
        timestamp: DateTime.now(),
      );

      await notifier.addTransaction(txn);
      if (mounted) context.pop();
    } catch (_) {
      if (mounted) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.addEntryAmountInvalid)),
        );
      }
    }
  }
}
