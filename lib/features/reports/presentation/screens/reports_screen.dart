import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/widgets/app_avatar.dart';
import '../../../../core/widgets/kp_empty_state.dart';
import '../../../../core/widgets/kp_error_view.dart';
import '../../../../core/widgets/sticky_footer_cta.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../home/presentation/providers/customer_provider.dart';
import '../../data/pdf_report_builder.dart';
import '../../domain/models/report_data.dart';
import '../providers/reports_provider.dart';

export '../providers/reports_provider.dart' show reportsUiProvider, ReportsUiNotifier;

abstract final class _Dims {
  static const double filterHeight     = 44.0;
  static const double sectionGap       = 20.0;
  static const double cardPadding      = 16.0;
  static const double cardRadius       = 12.0;
  static const double colNet           = 72.0;
  static const double colAmount        = 80.0;
  static const double rowMinHeight     = 52.0;
  static const double cardGap          = 10.0;
  static const double colGap           = 8.0;
  static const double statLabelGap     = 6.0;
  static const double colHeaderV       = 6.0;
  static const double tileAvatarGap    = 10.0;
  static const double sheetInitialSize = 0.6;
  static const double sheetMaxSize     = 0.9;
}

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n   = AppLocalizations.of(context)!;
    final cs     = Theme.of(context).colorScheme;
    final tt     = Theme.of(context).textTheme;
    final ui     = ref.watch(reportsUiProvider);
    final report = ref.watch(reportsProvider(ui.period));

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // ── Header ───────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimensions.buttonPaddingH,
                AppDimensions.inputPaddingV / 2,
                AppDimensions.buttonPaddingH,
                0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.navReports,
                      style: tt.headlineSmall?.copyWith(
                        color: cs.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppDimensions.inputPaddingV / 2),

            // ── Period filter ─────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.buttonPaddingH,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.reportsFilterHint,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.buttonStackGap),
                  _PeriodToggle(
                    selected: ui.period,
                    onChanged: (p) =>
                        ref.read(reportsUiProvider.notifier).setPeriod(p),
                    labels: [
                      l10n.reportsFilterMonth,
                      l10n.reportsFilterYear,
                      l10n.reportsFilterAll,
                    ],
                  ),
                  const SizedBox(height: AppDimensions.buttonStackGap),
                  _CustomerFilterChip(ui: ui, l10n: l10n),
                ],
              ),
            ),

            const SizedBox(height: _Dims.sectionGap),

            // ── Content ───────────────────────────────────────────────
            Expanded(
              child: report.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => KpErrorView(
                  onRetry: () => ref.invalidate(reportsProvider(ui.period)),
                ),
                data: (data) {
                    final filteredData = ui.selectedCustomerId != null
                        ? data.filteredBy(ui.selectedCustomerId!)
                        : data;
                    return filteredData.rows.isEmpty
                        ? KpEmptyState(
                            icon: Icons.leaderboard_outlined,
                            title: l10n.reportsEmpty,
                          )
                        : _ReportBody(data: filteredData, l10n: l10n);
                  },
              ),
            ),

            // ── Share button ─────────────────────────────────────────
            StickyFooterCta(
              label:     l10n.reportsDownloadPdf,
              icon:      const Icon(Icons.share_rounded),
              loading:   ui.exporting,
              onPressed: report.value?.rows.isNotEmpty == true && !ui.exporting
                  ? () => ReportsScreen.triggerExport(context, ref)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  /// Called by HomeShell's FAB. Returns false if there is nothing to export.
  static Future<void> triggerExport(BuildContext context, WidgetRef ref) async {
    final l10n   = AppLocalizations.of(context)!;
    final ui     = ref.read(reportsUiProvider);
    final data   = ref.read(reportsProvider(ui.period)).value;
    if (data == null) return;

    ref.read(reportsUiProvider.notifier).setExporting(true);
    try {
      final bytes = await PdfReportBuilder.build(data, l10n);
      await Printing.sharePdf(bytes: bytes, filename: 'khata_report.pdf');
    } finally {
      ref.read(reportsUiProvider.notifier).setExporting(false);
    }
  }
}

// ── 3-segment period toggle ───────────────────────────────────────────────────

class _PeriodToggle extends StatelessWidget {
  const _PeriodToggle({
    required this.selected,
    required this.onChanged,
    required this.labels,
  });

  final ReportPeriod selected;
  final ValueChanged<ReportPeriod> onChanged;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final periods = ReportPeriod.values;

    return Container(
      height: _Dims.filterHeight,
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
        border: Border.all(
            color: cs.outlineVariant, width: AppDimensions.borderDefault),
      ),
      child: Row(
        children: List.generate(periods.length, (i) {
          final isSelected = periods[i] == selected;
          final innerR = AppDimensions.radiusSmall - AppDimensions.borderDefault;
          final br = BorderRadius.horizontal(
            left:  i == 0 ? Radius.circular(innerR) : Radius.zero,
            right: i == periods.length - 1 ? Radius.circular(innerR) : Radius.zero,
          );
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(periods[i]),
              child: AnimatedContainer(
                duration: AppDimensions.animShort,
                decoration: BoxDecoration(
                  color: isSelected
                      ? cs.secondaryContainer
                      : Colors.transparent,
                  borderRadius: br,
                ),
                alignment: Alignment.center,
                child: AnimatedDefaultTextStyle(
                  duration: AppDimensions.animShort,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: isSelected
                            ? cs.onSecondaryContainer
                            : cs.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                  child: Text(
                    labels[i],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ── Report body (summary + table) ─────────────────────────────────────────────

class _ReportBody extends StatelessWidget {
  const _ReportBody({required this.data, required this.l10n});

  final ReportData data;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.buttonPaddingH,
        0,
        AppDimensions.buttonPaddingH,
        AppDimensions.buttonPaddingV,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SummaryRow(data: data, l10n: l10n),
          const SizedBox(height: _Dims.sectionGap),
          _CustomerTable(data: data, l10n: l10n),
        ],
      ),
    );
  }
}

// ── Summary cards ─────────────────────────────────────────────────────────────

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.data, required this.l10n});

  final ReportData data;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final cs  = Theme.of(context).colorScheme;
    final fmt = NumberFormat('#,##,##0', l10n.localeName);

    return Row(
      children: [
        _Card(label: l10n.reportsTotalGave, amount: data.totalGave,  color: cs.tertiary,  fmt: fmt),
        const SizedBox(width: _Dims.cardGap),
        _Card(label: l10n.reportsTotalGot,  amount: data.totalGot,   color: cs.secondary, fmt: fmt),
        const SizedBox(width: _Dims.cardGap),
        _Card(
          label:  l10n.reportsNetBalance,
          amount: data.netBalance,
          color:  data.netBalance >= 0 ? cs.secondary : cs.tertiary,
          fmt:    fmt,
        ),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    required this.label,
    required this.amount,
    required this.color,
    required this.fmt,
  });

  final String label;
  final double amount;
  final Color color;
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
          border: Border.all(color: cs.outlineVariant, width: AppDimensions.borderDefault / 2),
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
              '₹ ${fmt.format(amount.abs())}',
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

// ── Customer table ────────────────────────────────────────────────────────────

class _CustomerTable extends StatelessWidget {
  const _CustomerTable({required this.data, required this.l10n});

  final ReportData data;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final cs  = Theme.of(context).colorScheme;
    final tt  = Theme.of(context).textTheme;

    return Column(
      children: [
        // Column header
        Padding(
          padding: const EdgeInsets.symmetric(vertical: _Dims.colHeaderV),
          child: Row(
            children: [
              Expanded(
                child: Text(l10n.reportsColCustomer,
                    style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant)),
              ),
              SizedBox(
                width: _Dims.colAmount,
                child: Text(l10n.reportsColGave,
                    style: tt.labelSmall?.copyWith(color: cs.tertiary),
                    textAlign: TextAlign.end),
              ),
              const SizedBox(width: _Dims.colGap),
              SizedBox(
                width: _Dims.colAmount,
                child: Text(l10n.reportsColGot,
                    style: tt.labelSmall?.copyWith(color: cs.secondary),
                    textAlign: TextAlign.end),
              ),
              const SizedBox(width: _Dims.colGap),
              SizedBox(
                width: _Dims.colNet,
                child: Text(l10n.reportsColNet,
                    style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant),
                    textAlign: TextAlign.end),
              ),
            ],
          ),
        ),
        const Divider(height: AppDimensions.dividerThickness),
        // Rows
        ...data.rows.map((row) => _CustomerRow(row: row, l10n: l10n)),
      ],
    );
  }
}

class _CustomerRow extends StatelessWidget {
  const _CustomerRow({required this.row, required this.l10n});

  final CustomerReportRow row;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final cs       = Theme.of(context).colorScheme;
    final tt       = Theme.of(context).textTheme;
    final fmt      = NumberFormat('#,##,##0', l10n.localeName);
    final netColor = row.net >= 0 ? cs.secondary : cs.tertiary;
    final initial  = row.customerName.isNotEmpty
        ? row.customerName.characters.first.toUpperCase()
        : '?';

    return Container(
      constraints: const BoxConstraints(minHeight: _Dims.rowMinHeight),
      child: Row(
        children: [
          ListTileAvatar(initial: initial),
          const SizedBox(width: _Dims.tileAvatarGap),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  row.customerName,
                  style: tt.bodyMedium?.copyWith(
                    color: cs.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (row.shopName != null)
                  Text(
                    row.shopName!,
                    style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          SizedBox(
            width: _Dims.colAmount,
            child: Text(
              '₹ ${fmt.format(row.gave)}',
              style: tt.bodySmall?.copyWith(color: cs.tertiary),
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: _Dims.colGap),
          SizedBox(
            width: _Dims.colAmount,
            child: Text(
              '₹ ${fmt.format(row.got)}',
              style: tt.bodySmall?.copyWith(color: cs.secondary),
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: _Dims.colGap),
          SizedBox(
            width: _Dims.colNet,
            child: Text(
              '₹ ${fmt.format(row.net.abs())}',
              style: tt.bodySmall?.copyWith(
                color: netColor,
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

// ── Customer filter chip ──────────────────────────────────────────────────────

class _CustomerFilterChip extends ConsumerWidget {
  const _CustomerFilterChip({required this.ui, required this.l10n});

  final ReportsUiState ui;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFiltered = ui.selectedCustomerId != null;

    return GestureDetector(
      onTap: isFiltered
          ? null
          : () => _CustomerPickerSheet.show(context, ref, l10n),
      child: InputChip(
        avatar: isFiltered
            ? null
            : const Icon(Icons.person_search_rounded, size: 16),
        label: Text(
          isFiltered
              ? l10n.reportsCustomerSelected(ui.selectedCustomerName ?? '')
              : l10n.reportsFilterCustomer,
        ),
        selected: isFiltered,
        onPressed: isFiltered
            ? null
            : () => _CustomerPickerSheet.show(context, ref, l10n),
        onDeleted: isFiltered
            ? () => ref.read(reportsUiProvider.notifier).setCustomer(null, null)
            : null,
      ),
    );
  }
}

// ── Customer picker bottom sheet ──────────────────────────────────────────────

class _CustomerPickerSheet extends ConsumerStatefulWidget {
  const _CustomerPickerSheet({required this.l10n});

  final AppLocalizations l10n;

  static Future<void> show(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => _CustomerPickerSheet(l10n: l10n),
    );
  }

  @override
  ConsumerState<_CustomerPickerSheet> createState() =>
      _CustomerPickerSheetState();
}

class _CustomerPickerSheetState
    extends ConsumerState<_CustomerPickerSheet> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final cs        = Theme.of(context).colorScheme;
    final tt        = Theme.of(context).textTheme;
    final customers = ref.watch(customerProvider).asData?.value ?? [];
    final filtered  = _query.isEmpty
        ? customers
        : customers
            .where((c) => c.name.toLowerCase().contains(_query.toLowerCase()))
            .toList();

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: _Dims.sheetInitialSize,
      maxChildSize: _Dims.sheetMaxSize,
      builder: (_, scrollController) => Column(
        children: [
          const SizedBox(height: 12),
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
              12,
              AppDimensions.buttonPaddingH,
              8,
            ),
            child: Text(
              widget.l10n.reportsFilterByCustomer,
              style: tt.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700, color: cs.onSurface),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.buttonPaddingH,
            ),
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: widget.l10n.recordPaymentPickerHint,
                prefixIcon: const Icon(Icons.search_rounded),
                isDense: true,
              ),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: filtered.length,
              itemBuilder: (_, i) {
                final c = filtered[i];
                return ListTile(
                  leading: ListTileAvatar(
                    initial: c.name.isNotEmpty
                        ? c.name.characters.first.toUpperCase()
                        : '?',
                  ),
                  title: Text(c.name),
                  subtitle: c.shopName != null ? Text(c.shopName!) : null,
                  onTap: () {
                    ref
                        .read(reportsUiProvider.notifier)
                        .setCustomer(c.id, c.name);
                    context.pop();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
