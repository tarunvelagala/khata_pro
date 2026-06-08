import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/widgets/app_avatar.dart';
import '../../../../core/widgets/button_spinner.dart';
import '../../../../core/widgets/kp_empty_state.dart';
import '../../../../core/widgets/kp_error_view.dart';
import '../../../../core/widgets/segment_toggle.dart';
import '../../../../design_system/atoms/kp_tonal_icon_button.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../home/presentation/providers/customer_provider.dart';
import '../../data/pdf_report_builder.dart';
import '../../domain/models/report_data.dart';
import '../providers/reports_provider.dart';

export '../providers/reports_provider.dart' show reportsUiProvider, ReportsUiNotifier;

abstract final class _Dims {
  static const double sectionGap       = 20.0;
  static const double cardPadding      = 16.0;
  static const double cardRadius       = 12.0;
  static const double cardGap          = 10.0;
  static const double statLabelGap     = 6.0;
  static const double tileAvatarGap    = 12.0;
  static const double sheetInitialSize = 0.6;
  static const double sheetMaxSize     = 0.9;
  static const double customerCardGap  = 8.0;
  static const double netBadgePadH     = 10.0;
  static const double netBadgePadV     = 4.0;
  static const double netBadgeRadius   = 6.0;
  static const double subRowGap        = 4.0;
  static const double subAmountGap     = 16.0;
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
      appBar: AppBar(
        backgroundColor: cs.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          l10n.navReports,
          style: tt.headlineSmall?.copyWith(
            color: cs.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          _CustomerFilterButton(ui: ui, l10n: l10n),
          const SizedBox(width: AppDimensions.buttonPaddingH),
        ],
      ),
      floatingActionButton: report.value?.rows.isNotEmpty == true
          ? FloatingActionButton.extended(
              onPressed: ui.exporting
                  ? null
                  : () => ReportsScreen.triggerExport(context, ref),
              icon: ui.exporting
                  ? const ButtonSpinner()
                  : const Icon(Icons.share_rounded),
              label: Text(l10n.reportsDownloadPdf),
            )
          : null,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // ── Period filter row ─────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.buttonPaddingH,
              ),
              child: SegmentToggle<ReportPeriod>(
                values: ReportPeriod.values,
                labels: [
                  l10n.reportsFilterMonth,
                  l10n.reportsFilterYear,
                  l10n.reportsFilterAll,
                ],
                selected: ui.period,
                onChanged: (p) =>
                    ref.read(reportsUiProvider.notifier).setPeriod(p),
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
        AppDimensions.fabClearance,
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

// ── Customer card list ────────────────────────────────────────────────────────

class _CustomerTable extends StatelessWidget {
  const _CustomerTable({required this.data, required this.l10n});

  final ReportData data;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < data.rows.length; i++) ...[
          if (i > 0) const SizedBox(height: _Dims.customerCardGap),
          _CustomerCard(row: data.rows[i], l10n: l10n),
        ],
      ],
    );
  }
}

class _CustomerCard extends StatelessWidget {
  const _CustomerCard({required this.row, required this.l10n});

  final CustomerReportRow row;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final cs      = Theme.of(context).colorScheme;
    final tt      = Theme.of(context).textTheme;
    final fmt     = NumberFormat('#,##,##0', l10n.localeName);
    final isOwed  = row.net >= 0; // positive net → you'll receive money
    final netColor     = isOwed ? cs.secondary : cs.tertiary;
    final netBgColor   = isOwed
        ? cs.secondaryContainer.withValues(alpha: 0.5)
        : cs.tertiaryContainer.withValues(alpha: 0.5);
    final initial = row.customerName.isNotEmpty
        ? row.customerName.characters.first.toUpperCase()
        : '?';

    return Container(
      padding: const EdgeInsets.all(_Dims.cardPadding),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(_Dims.cardRadius),
        border: Border.all(
          color: cs.outlineVariant,
          width: AppDimensions.borderDefault,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Top row: avatar + name/shop + net badge ──────────────────
          Row(
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
                      style: tt.bodyLarge?.copyWith(
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
              const SizedBox(width: _Dims.tileAvatarGap),
              // Net balance badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: _Dims.netBadgePadH,
                  vertical: _Dims.netBadgePadV,
                ),
                decoration: BoxDecoration(
                  color: netBgColor,
                  borderRadius: BorderRadius.circular(_Dims.netBadgeRadius),
                ),
                child: Text(
                  '₹ ${fmt.format(row.net.abs())}',
                  style: tt.titleSmall?.copyWith(
                    color: netColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: _Dims.subRowGap + 4),
          const Divider(height: AppDimensions.dividerThickness),
          const SizedBox(height: _Dims.subRowGap),

          // ── Bottom row: gave + got breakdown ─────────────────────────
          Row(
            children: [
              _SubAmount(
                label: l10n.reportsColGave,
                amount: row.gave,
                color: cs.tertiary,
                fmt: fmt,
                tt: tt,
              ),
              const SizedBox(width: _Dims.subAmountGap),
              _SubAmount(
                label: l10n.reportsColGot,
                amount: row.got,
                color: cs.secondary,
                fmt: fmt,
                tt: tt,
              ),
              const Spacer(),
              Text(
                isOwed ? l10n.reportsWillReceive : l10n.reportsWillPay,
                style: tt.labelSmall?.copyWith(color: netColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SubAmount extends StatelessWidget {
  const _SubAmount({
    required this.label,
    required this.amount,
    required this.color,
    required this.fmt,
    required this.tt,
  });

  final String label;
  final double amount;
  final Color color;
  final NumberFormat fmt;
  final TextTheme tt;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: tt.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          '₹ ${fmt.format(amount)}',
          style: tt.bodySmall?.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// ── Customer filter button (icon only, tonal when active) ────────────────────

class _CustomerFilterButton extends ConsumerWidget {
  const _CustomerFilterButton({required this.ui, required this.l10n});

  final ReportsUiState ui;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFiltered = ui.selectedCustomerId != null;
    final initial    = (ui.selectedCustomerName?.isNotEmpty == true)
        ? ui.selectedCustomerName!.characters.first.toUpperCase()
        : null;

    return KpTonalIconButton(
      icon: const Icon(Icons.person_search_rounded),
      isActive: isFiltered,
      activeChild: initial != null
          ? Text(
              initial,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
                fontWeight: FontWeight.w700,
              ),
            )
          : null,
      tooltip: isFiltered
          ? l10n.reportsCustomerSelected(ui.selectedCustomerName ?? '')
          : l10n.reportsFilterCustomer,
      onPressed: isFiltered
          ? () => ref.read(reportsUiProvider.notifier).setCustomer(null, null)
          : () => _CustomerPickerSheet.show(context, ref, l10n),
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
