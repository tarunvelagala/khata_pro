import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/widgets/avatar_palette.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/models/customer.dart';
import '../../domain/models/transaction.dart';
import '../providers/customer_provider.dart';
import '../providers/customer_transactions_provider.dart';

abstract final class _Dims {
  static const double heroExpandedHeight = 200.0;
  static const double avatarRadius       = 32.0;
  static const double avatarFontSize     = 22.0;
  static const double balanceFontSize    = 28.0;
  static const double dateLabelGap       = 8.0;
  static const double tileMinHeight      = 64.0;
}

// ── sealed list items for date-grouped view ───────────────────────────────────

sealed class _ListItem {}

final class _DateHeader extends _ListItem {
  _DateHeader(this.label);
  final String label;
}

final class _TxnRow extends _ListItem {
  _TxnRow(this.txn);
  final Transaction txn;
}

class CustomerDetailScreen extends ConsumerStatefulWidget {
  const CustomerDetailScreen({super.key, required this.customerId});

  final String customerId;

  @override
  ConsumerState<CustomerDetailScreen> createState() =>
      _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends ConsumerState<CustomerDetailScreen> {
  final _scrollCtrl = ScrollController();
  bool  _isMasked   = false;
  bool  _fabVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollCtrl.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollCtrl.removeListener(_onScroll);
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _onScroll() {
    final scrollingDown = _scrollCtrl.position.userScrollDirection.index == 2;
    if (scrollingDown && _fabVisible) setState(() => _fabVisible = false);
    if (!scrollingDown && !_fabVisible) setState(() => _fabVisible = true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n       = AppLocalizations.of(context)!;
    final cs         = Theme.of(context).colorScheme;
    final customerAsync = ref.watch(customerProvider);
    final txnsAsync  = ref.watch(customerTransactionsProvider(widget.customerId));

    return customerAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(
        body: Center(child: Text(e.toString())),
      ),
      data: (customers) {
        final customer = customers.where((c) => c.id == widget.customerId).firstOrNull;
        if (customer == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Icon(Icons.error_outline_rounded)),
          );
        }

        return Scaffold(
          backgroundColor: cs.surface,
          body: txnsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(
              child: Text(e.toString(), style: TextStyle(color: cs.error)),
            ),
            data: (txns) => _buildBody(context, l10n, cs, customer, txns),
          ),
          floatingActionButton: AnimatedSlide(
            offset: _fabVisible ? Offset.zero : const Offset(0, 2),
            duration: AppDimensions.animShort,
            child: AnimatedOpacity(
              opacity: _fabVisible ? 1.0 : 0.0,
              duration: AppDimensions.animShort,
              child: FloatingActionButton(
                onPressed: () =>
                    context.push('/customers/${widget.customerId}/entry'),
                tooltip: l10n.homeAddEntry,
                child: const Icon(Icons.add_rounded),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    AppLocalizations l10n,
    ColorScheme cs,
    Customer customer,
    List<Transaction> txns,
  ) {
    final items = _buildListItems(txns, l10n);

    return CustomScrollView(
      controller: _scrollCtrl,
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: _Dims.heroExpandedHeight,
          backgroundColor: cs.surfaceContainerLow,
          foregroundColor: cs.onSurface,
          actions: [
            IconButton(
              icon: Icon(
                _isMasked
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
              tooltip: _isMasked ? l10n.balanceShowTooltip : l10n.balanceHideTooltip,
              onPressed: () => setState(() => _isMasked = !_isMasked),
            ),
            IconButton(
              icon: const Icon(Icons.more_vert_rounded),
              onPressed: () => _showCustomerActions(context, l10n, cs, customer),
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            background: _CustomerHeroBand(
              customer: customer,
              isMasked: _isMasked,
            ),
          ),
        ),
        if (txns.isEmpty)
          SliverFillRemaining(
            child: _EmptyState(customerId: widget.customerId),
          )
        else
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, i) => _buildListItem(ctx, items[i], cs),
              childCount: items.length,
            ),
          ),
        const SliverToBoxAdapter(
          child: SizedBox(height: AppDimensions.fabClearance),
        ),
      ],
    );
  }

  Widget _buildListItem(BuildContext context, _ListItem item, ColorScheme cs) {
    final tt = Theme.of(context).textTheme;
    switch (item) {
      case _DateHeader(:final label):
        return Padding(
          padding: const EdgeInsets.fromLTRB(
            AppDimensions.buttonPaddingH,
            _Dims.dateLabelGap * 2,
            AppDimensions.buttonPaddingH,
            _Dims.dateLabelGap,
          ),
          child: Text(
            label,
            style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant),
          ),
        );
      case _TxnRow(:final txn):
        return _TxnListTile(transaction: txn, isMasked: _isMasked);
    }
  }

  List<_ListItem> _buildListItems(List<Transaction> txns, AppLocalizations l10n) {
    final sorted = List<Transaction>.from(txns)
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

    final items = <_ListItem>[];
    String? lastDate;

    for (final txn in sorted) {
      final dateLabel = _dateLabel(txn.timestamp, l10n);
      if (dateLabel != lastDate) {
        items.add(_DateHeader(dateLabel));
        lastDate = dateLabel;
      }
      items.add(_TxnRow(txn));
    }

    return items;
  }

  String _dateLabel(DateTime dt, AppLocalizations l10n) {
    final now   = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date  = DateTime(dt.year, dt.month, dt.day);
    final diff  = today.difference(date).inDays;

    if (diff == 0) return l10n.dateToday;
    if (diff == 1) return l10n.dateYesterday;
    return DateFormat('d MMMM yyyy').format(dt);
  }

  void _showCustomerActions(
    BuildContext context,
    AppLocalizations l10n,
    ColorScheme cs,
    Customer customer,
  ) {
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: Text(l10n.editCustomerTitle),
              onTap: () {
                Navigator.of(ctx).pop();
                context.push('/customers/${customer.id}/edit', extra: customer);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete_outline_rounded, color: cs.error),
              title: Text(l10n.deleteAction, style: TextStyle(color: cs.error)),
              onTap: () {
                Navigator.of(ctx).pop();
                _confirmDeleteCustomer(context, l10n, cs, customer);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDeleteCustomer(
    BuildContext context,
    AppLocalizations l10n,
    ColorScheme cs,
    Customer customer,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.deleteConfirmTitle),
        content: Text(l10n.deleteCustomerConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.cancelAction),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(foregroundColor: cs.error),
            child: Text(l10n.deleteAction),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      await ref.read(customerProvider.notifier).deleteCustomer(customer.id);
      if (context.mounted) context.go('/home');
    }
  }
}

// ── Hero band ─────────────────────────────────────────────────────────────────

class _CustomerHeroBand extends StatelessWidget {
  const _CustomerHeroBand({required this.customer, required this.isMasked});

  final Customer customer;
  final bool isMasked;

  @override
  Widget build(BuildContext context) {
    final cs     = Theme.of(context).colorScheme;
    final tt     = Theme.of(context).textTheme;
    final l10n   = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();

    final initial = customer.name.isNotEmpty ? customer.name[0].toUpperCase() : '?';
    final balance = customer.netBalance;

    final (amountColor, dirLabel) = switch (balance) {
      > 0 => (cs.secondary, l10n.customerDetailOwesYou),
      < 0 => (cs.tertiary,  l10n.customerDetailYouOwe),
      _   => (cs.onSurfaceVariant, l10n.customerDetailSettled),
    };

    final formattedBalance = isMasked
        ? '₹ ••••'
        : NumberFormat.currency(
            locale: locale,
            symbol: '₹ ',
            decimalDigits: 0,
          ).format(balance.abs());

    return Container(
      color: cs.surfaceContainerLow,
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.buttonPaddingH,
        AppDimensions.heroContentPaddingTop,
        AppDimensions.buttonPaddingH,
        AppDimensions.heroContentPaddingBottom,
      ),
      alignment: Alignment.bottomLeft,
      child: Row(
        children: [
          CircleAvatar(
            radius: _Dims.avatarRadius,
            backgroundColor: avatarColorFor(initial),
            child: Text(
              initial,
              style: tt.headlineSmall?.copyWith(
                fontSize: _Dims.avatarFontSize,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: AppDimensions.inputPaddingH),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customer.name,
                  style: tt.titleLarge?.copyWith(
                    color: cs.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (customer.shopName != null)
                  Text(
                    customer.shopName!,
                    style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  formattedBalance,
                  style: tt.titleLarge?.copyWith(
                    fontSize: _Dims.balanceFontSize,
                    color: amountColor,
                    fontWeight: FontWeight.w700,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  dirLabel,
                  style: tt.labelSmall?.copyWith(color: amountColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Transaction tile (within the detail view) ─────────────────────────────────

class _TxnListTile extends ConsumerWidget {
  const _TxnListTile({required this.transaction, required this.isMasked});

  final Transaction transaction;
  final bool isMasked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs     = Theme.of(context).colorScheme;
    final tt     = Theme.of(context).textTheme;
    final locale = Localizations.localeOf(context).toString();
    final l10n   = AppLocalizations.of(context)!;

    final amountColor  = transaction.isCredit ? cs.secondary : cs.tertiary;
    final amountPrefix = transaction.isCredit ? '+ ' : '- ';

    final formattedAmount = isMasked
        ? '₹ ••••'
        : '$amountPrefix₹ ${NumberFormat.currency(
            locale: locale,
            symbol: '',
            decimalDigits: 0,
          ).format(transaction.amount).trim()}';

    final timeStr = DateFormat.jm().format(transaction.timestamp);

    return InkWell(
      onTap: () => _showActions(context, ref, l10n, cs, tt),
      child: Container(
        constraints: const BoxConstraints(minHeight: _Dims.tileMinHeight),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.buttonPaddingH,
          vertical: AppDimensions.inputPaddingH,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (transaction.note != null)
                    Text(
                      transaction.note!,
                      style: tt.bodyMedium?.copyWith(color: cs.onSurface),
                      overflow: TextOverflow.ellipsis,
                    )
                  else
                    Text(
                      transaction.isCredit ? l10n.txnDirectionGave : l10n.txnDirectionReceived,
                      style: tt.bodyMedium?.copyWith(color: cs.onSurface),
                      overflow: TextOverflow.ellipsis,
                    ),
                  Text(
                    timeStr,
                    style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            Text(
              formattedAmount,
              style: tt.titleMedium?.copyWith(
                color: amountColor,
                fontWeight: FontWeight.w700,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
            const SizedBox(width: AppDimensions.buttonStackGap),
            Icon(Icons.more_vert_rounded, size: 20, color: cs.onSurfaceVariant),
          ],
        ),
      ),
    );
  }

  void _showActions(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    ColorScheme cs,
    TextTheme tt,
  ) {
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: Text(l10n.editEntryTitle),
              onTap: () {
                Navigator.of(ctx).pop();
                context.push(
                  '/customers/${transaction.customerId}/entry/edit',
                  extra: transaction,
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.delete_outline_rounded, color: cs.error),
              title: Text(l10n.deleteAction, style: TextStyle(color: cs.error)),
              onTap: () {
                Navigator.of(ctx).pop();
                _confirmDelete(context, ref, l10n, cs);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    ColorScheme cs,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.deleteConfirmTitle),
        content: Text(l10n.deleteTxnConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.cancelAction),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(foregroundColor: cs.error),
            child: Text(l10n.deleteAction),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      await ref
          .read(customerTransactionsProvider(transaction.customerId).notifier)
          .deleteTransaction(transaction.id);
    }
  }
}

// ── Empty state ───────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.customerId});

  final String customerId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs   = Theme.of(context).colorScheme;
    final tt   = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.buttonPaddingH * 2,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.receipt_long_outlined, size: AppDimensions.emptyIconSize, color: cs.outlineVariant),
            const SizedBox(height: AppDimensions.inputPaddingV),
            Text(
              l10n.customerDetailNoEntries,
              style: tt.titleMedium?.copyWith(color: cs.onSurface),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.buttonStackGap),
            Text(
              l10n.customerDetailNoEntriesBody,
              style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.inputPaddingV),
            FilledButton(
              onPressed: () =>
                  context.push('/customers/$customerId/entry'),
              child: Text(l10n.customerDetailAddFirstEntry),
            ),
          ],
        ),
      ),
    );
  }
}
