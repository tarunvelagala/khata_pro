import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/widgets/balance_direction_toggle.dart';
import '../../../../core/widgets/sticky_footer_cta.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/models/customer.dart';
import '../../domain/models/transaction.dart';
import '../providers/customer_provider.dart';
import '../providers/customer_transactions_provider.dart';

abstract final class _Dims {
  static const double fieldGap          = 16.0;
  static const double sectionGap        = 24.0;
  static const double amountFontSize    = 48.0;
  static const double toolbarHeightTall = 64.0;
}

class AddEntryScreen extends ConsumerStatefulWidget {
  const AddEntryScreen({
    super.key,
    required this.customerId,
    this.existingTxn,
    this.initialIsGave = true,
  });

  final String customerId;
  /// When non-null the screen operates in edit mode (delete-old + insert-new).
  final Transaction? existingTxn;
  /// Pre-selects the direction toggle. Ignored in edit mode.
  final bool initialIsGave;

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
    _isGave   = e?.isCredit ?? widget.initialIsGave;
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
    final isEdit = widget.existingTxn != null;

    final customersAsync = ref.watch(customerProvider);
    final customer = customersAsync.value
        ?.where((c) => c.id == widget.customerId)
        .firstOrNull;

    final hasTwoLines = !isEdit && customer?.shopName != null;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        surfaceTintColor: Colors.transparent,
        toolbarHeight: hasTwoLines ? _Dims.toolbarHeightTall : kToolbarHeight,
        title: _AppBarTitle(
          isEdit: isEdit,
          customer: customer,
          fallback: l10n.addEntryTitle,
          editLabel: l10n.editEntryTitle,
        ),
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
                  BalanceDirectionToggle(
                    labelPositive: l10n.addEntryGave,
                    labelNegative: l10n.addEntryReceived,
                    isPositive: _isGave,
                    onChanged: (v) => setState(() => _isGave = v),
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
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: AppDimensions.inputPaddingH),
                        child: Text(
                          '₹',
                          style: tt.displaySmall?.copyWith(
                            color: cs.onSurface,
                            fontSize: _Dims.amountFontSize,
                          ),
                        ),
                      ),
                      prefixIconConstraints: const BoxConstraints(),
                      hintText: '0',
                      hintStyle: tt.displaySmall?.copyWith(
                        color: cs.onSurfaceVariant,
                        fontSize: _Dims.amountFontSize,
                      ),
                    ),
                  ),
                  const SizedBox(height: _Dims.fieldGap),

                  TextFormField(
                    controller: _noteCtrl,
                    maxLines: 3,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      labelText: l10n.addEntryNoteLabel,
                      alignLabelWithHint: true,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(
                          left: AppDimensions.inputPaddingH,
                          bottom: 48, // pins icon to top of 3-line field
                        ),
                        child: Icon(Icons.notes_rounded, color: cs.onSurfaceVariant),
                      ),
                      prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Sticky footer CTA ────────────────────────────────────
          StickyFooterCta(
            label: l10n.addEntrySave,
            onPressed: _saving ? null : () => _submit(customer),
            loading: _saving,
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

// ── Two-line app bar title ─────────────────────────────────────────────────────

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle({
    required this.isEdit,
    required this.customer,
    required this.fallback,
    required this.editLabel,
  });

  final bool isEdit;
  final Customer? customer;
  final String fallback;
  final String editLabel;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    if (isEdit) {
      return Text(editLabel);
    }

    final name     = customer?.name ?? fallback;
    final shopName = customer?.shopName;

    if (shopName == null) {
      return Text(name, overflow: TextOverflow.ellipsis);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name,
          style: tt.titleMedium?.copyWith(
            color: cs.onSurface,
            fontWeight: FontWeight.w600,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        Text(
          shopName,
          style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }
}
