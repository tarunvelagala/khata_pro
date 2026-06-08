import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/widgets/kp_empty_state.dart';
import '../../../../core/widgets/kp_error_view.dart';
import '../../../../core/widgets/button_spinner.dart';
import '../../../../core/widgets/segment_toggle.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/bill_pdf_builder.dart';
import '../../domain/models/bill_data.dart';
import '../providers/bill_provider.dart';

abstract final class _Dims {
  static const double sectionGap    = 20.0;
  static const double cardPadding   = 14.0;
  static const double cardRadius    = 12.0;
  static const double cardGap       = 8.0;
  static const double statLabelGap  = 4.0;
  static const double colDate       = 64.0;
  static const double colAmount     = 76.0;
  static const double colGap        = 6.0;
  static const double colHeaderV    = 6.0;
  static const double rowMinHeight  = 44.0;
}

class GenerateBillScreen extends ConsumerWidget {
  const GenerateBillScreen({super.key, required this.customerId});

  final String customerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n   = AppLocalizations.of(context)!;
    final cs     = Theme.of(context).colorScheme;
    final tt     = Theme.of(context).textTheme;
    final ui     = ref.watch(billUiProvider);
    final async  = ref.watch(billDataProvider(customerId));
    final customer = ref.watch(billCustomerProvider(customerId));

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.billScreenTitle),
            if (customer != null)
              Text(
                customer.shopName != null
                    ? '${customer.name} (${customer.shopName})'
                    : customer.name,
                style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
          ],
        ),
      ),
      floatingActionButton: async.value?.rows.isNotEmpty == true
          ? FloatingActionButton.extended(
              onPressed: ui.sharing
                  ? null
                  : () => _share(context, ref, l10n, async.value!),
              icon: ui.sharing
                  ? const ButtonSpinner()
                  : const Icon(Icons.share_rounded),
              label: Text(l10n.billShareButton),
            )
          : null,
      body: Column(
        children: [
          // ── Period selector ─────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppDimensions.buttonPaddingH,
              AppDimensions.inputPaddingV / 2,
              AppDimensions.buttonPaddingH,
              0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.billFilterHint,
                  style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant),
                ),
                const SizedBox(height: AppDimensions.buttonStackGap),
                SegmentToggle<BillPeriod>(
                  values: BillPeriod.values,
                  labels: [
                    l10n.billPeriodMonth,
                    l10n.billPeriodYear,
                    l10n.billPeriodAll,
                    l10n.billPeriodCustom,
                  ],
                  selected: ui.period,
                  onChanged: (p) => ref.read(billUiProvider.notifier).setPeriod(p),
                  overrideTaps: {
                    BillPeriod.custom: () => _pickDateRange(context, ref, l10n, ui),
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: _Dims.sectionGap),

          // ── Content ─────────────────────────────────────────────────
          Expanded(
            child: async.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error:   (e, _) => KpErrorView(
                onRetry: () => ref.invalidate(billDataProvider(customerId)),
              ),
              data: (bill) {
                if (bill == null || bill.rows.isEmpty) {
                  return KpEmptyState(
                    icon:  Icons.receipt_long_outlined,
                    title: l10n.billEmpty,
                  );
                }
                return _BillBody(bill: bill, l10n: l10n);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDateRange(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    BillUiState ui,
  ) async {
    final now    = DateTime.now();
    final picked = await showDateRangePicker(
      context:       context,
      firstDate:     DateTime(2000),
      lastDate:      now,
      initialDateRange: ui.customRange != null
          ? DateTimeRange(
              start: ui.customRange!.from,
              end:   ui.customRange!.to,
            )
          : DateTimeRange(
              start: DateTime(now.year, now.month),
              end:   now,
            ),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx),
        child: child!,
      ),
    );
    if (picked == null) return;
    ref.read(billUiProvider.notifier).setCustomRange(
      BillDateRange(
        from: picked.start,
        to:   picked.end.copyWith(
          hour: 23, minute: 59, second: 59, millisecond: 999,
        ),
      ),
    );
  }

  Future<void> _share(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    BillData bill,
  ) async {
    ref.read(billUiProvider.notifier).setSharing(true);
    try {
      final bytes    = await BillPdfBuilder.build(bill, l10n);
      final safeName = bill.customer.name
          .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')
          .toLowerCase();
      await Printing.sharePdf(
        bytes:    bytes,
        filename: 'statement_$safeName.pdf',
      );
    } finally {
      ref.read(billUiProvider.notifier).setSharing(false);
    }
  }
}

// ── Bill body (summary + transaction rows) ────────────────────────────────────

class _BillBody extends StatelessWidget {
  const _BillBody({required this.bill, required this.l10n});

  final BillData bill;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.buttonPaddingH,
        0,
        AppDimensions.buttonPaddingH,
        AppDimensions.fabClearance,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SummaryRow(bill: bill, l10n: l10n),
          const SizedBox(height: _Dims.sectionGap),
          _TxnTable(bill: bill, l10n: l10n),
        ],
      ),
    );
  }
}

// ── Summary cards ─────────────────────────────────────────────────────────────

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.bill, required this.l10n});

  final BillData         bill;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final cs  = Theme.of(context).colorScheme;
    final fmt = NumberFormat('#,##,##0', l10n.localeName);
    final net = bill.netBalance;
    return Row(
      children: [
        _SummaryCard(
          label:  l10n.billTotalGave,
          amount: bill.totalGave,
          color:  cs.tertiary,
          fmt:    fmt,
        ),
        const SizedBox(width: _Dims.cardGap),
        _SummaryCard(
          label:  l10n.billTotalGot,
          amount: bill.totalGot,
          color:  cs.secondary,
          fmt:    fmt,
        ),
        const SizedBox(width: _Dims.cardGap),
        _SummaryCard(
          label:  net >= 0 ? l10n.billYouAreOwed : l10n.billYouOwe,
          amount: net.abs(),
          color:  net >= 0 ? cs.secondary : cs.tertiary,
          fmt:    fmt,
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.label,
    required this.amount,
    required this.color,
    required this.fmt,
  });

  final String label;
  final double amount;
  final Color  color;
  final NumberFormat fmt;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(_Dims.cardPadding),
        decoration: BoxDecoration(
          color: cs.surfaceContainerLow,
          borderRadius: BorderRadius.circular(_Dims.cardRadius),
          border: Border.all(
            color: cs.outlineVariant,
            width: AppDimensions.borderDefault / 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: _Dims.statLabelGap),
            Text(
              '₹ ${fmt.format(amount)}',
              style: tt.titleSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Transaction table ─────────────────────────────────────────────────────────

class _TxnTable extends StatelessWidget {
  const _TxnTable({required this.bill, required this.l10n});

  final BillData         bill;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: _Dims.colHeaderV),
          child: Row(
            children: [
              SizedBox(
                width: _Dims.colDate,
                child: Text(l10n.billColDate,
                    style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant)),
              ),
              const SizedBox(width: _Dims.colGap),
              Expanded(
                child: Text(l10n.billColNote,
                    style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant)),
              ),
              SizedBox(
                width: _Dims.colAmount,
                child: Text(l10n.billColGave,
                    style: tt.labelSmall?.copyWith(color: cs.tertiary),
                    textAlign: TextAlign.end),
              ),
              const SizedBox(width: _Dims.colGap),
              SizedBox(
                width: _Dims.colAmount,
                child: Text(l10n.billColGot,
                    style: tt.labelSmall?.copyWith(color: cs.secondary),
                    textAlign: TextAlign.end),
              ),
            ],
          ),
        ),
        const Divider(height: AppDimensions.dividerThickness),
        ...bill.rows.map((row) => _TxnRow(row: row, l10n: l10n)),
      ],
    );
  }
}

class _TxnRow extends StatelessWidget {
  const _TxnRow({required this.row, required this.l10n});

  final BillRow          row;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final cs      = Theme.of(context).colorScheme;
    final tt      = Theme.of(context).textTheme;
    final dateFmt = DateFormat('d MMM', l10n.localeName);
    final amtFmt  = NumberFormat('#,##,##0', l10n.localeName);

    return Container(
      constraints: const BoxConstraints(minHeight: _Dims.rowMinHeight),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: _Dims.colDate,
            child: Text(
              dateFmt.format(row.date),
              style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
            ),
          ),
          const SizedBox(width: _Dims.colGap),
          Expanded(
            child: Text(
              row.note?.isNotEmpty == true ? row.note! : '—',
              style: tt.bodySmall?.copyWith(color: cs.onSurface),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: _Dims.colAmount,
            child: Text(
              row.isCredit ? '₹ ${amtFmt.format(row.amount)}' : '',
              style: tt.bodySmall?.copyWith(
                color: cs.tertiary,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: _Dims.colGap),
          SizedBox(
            width: _Dims.colAmount,
            child: Text(
              row.isCredit ? '' : '₹ ${amtFmt.format(row.amount)}',
              style: tt.bodySmall?.copyWith(
                color: cs.secondary,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
