import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/services/reminder_service.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/widgets/amount_text.dart';
import '../../../../core/widgets/app_avatar.dart';
import '../../../../core/widgets/kp_action_sheet.dart';
import '../../../../core/widgets/kp_delete_dialog.dart';
import '../../../../core/widgets/kp_empty_state.dart';
import '../../../../core/widgets/kp_error_view.dart';
import '../../../../core/widgets/more_icon_button.dart';
import '../../../../core/widgets/set_reminder_sheet.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/models/customer.dart';
import '../widgets/catalog_image_row.dart';
import '../../domain/models/reminder_frequency.dart';
import '../../domain/models/transaction.dart';
import '../providers/customer_provider.dart';
import '../providers/customer_transactions_provider.dart';
import '../screens/attach_image_screen.dart';
import '../../../settings/presentation/providers/profile_provider.dart';
import '../../../settings/domain/extensions/profile_extensions.dart';

abstract final class _Dims {
  static const double heroExpandedHeight = 200.0;
  static const double balanceFontSize    = 28.0;
  static const double dateLabelGap       = 8.0;
  static const double tileMinHeight      = 64.0;
  static const double actionBarHeight    = 64.0;
  static const double actionBarDividerW  = 1.0;
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
  bool _isMasked = false;

  @override
  Widget build(BuildContext context) {
    final l10n          = AppLocalizations.of(context)!;
    final colorScheme   = Theme.of(context).colorScheme;
    final customerAsync = ref.watch(customerProvider);
    final txnsAsync     = ref.watch(customerTransactionsProvider(widget.customerId));

    return customerAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(
        body: KpErrorView(onRetry: () => ref.invalidate(customerProvider)),
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
          backgroundColor: colorScheme.surface,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => context.push('/customers/${widget.customerId}/entry'),
            icon: const Icon(Icons.add_rounded),
            label: Text(l10n.addEntryTitle),
          ),
          body: Stack(
            children: [
              txnsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => KpErrorView(
                  onRetry: () => ref.invalidate(
                    customerTransactionsProvider(widget.customerId),
                  ),
                ),
                data: (txns) => _buildBody(context, l10n, colorScheme, customer, txns),
              ),
              Positioned(
                left: 0, right: 0, bottom: 0,
                child: _BottomActionBar(
                  onWhatsApp:     () => _sendReminder(context, l10n, customer),
                  onGenerateBill: () => context.push('/customers/${customer.id}/bill'),
                  l10n: l10n,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    AppLocalizations l10n,
    ColorScheme colorScheme,
    Customer customer,
    List<Transaction> txns,
  ) {
    final items = _buildListItems(txns, l10n);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: _Dims.heroExpandedHeight,
          backgroundColor: colorScheme.surfaceContainerLow,
          foregroundColor: colorScheme.onSurface,
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
              onPressed: () => _showCustomerActions(context, l10n, customer),
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
          ...[
          SliverToBoxAdapter(
            child: CatalogImageRow(customerId: customer.id),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Builder(
              builder: (ctx) {
                final l = AppLocalizations.of(ctx)!;
                return KpEmptyState(
                  icon: Icons.receipt_long_outlined,
                  title: l.customerDetailNoEntries,
                  body: l.customerDetailNoEntriesBody,
                );
              },
            ),
          ),
        ]
        else ...[
          SliverToBoxAdapter(
            child: CatalogImageRow(customerId: customer.id),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, i) => _buildListItem(ctx, items[i], colorScheme),
              childCount: items.length,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(
              bottom: AppDimensions.fabClearance + _Dims.actionBarHeight,
            ),
            sliver: SliverFillRemaining(
              hasScrollBody: false,
              fillOverscroll: false,
              child: ColoredBox(color: colorScheme.surface),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildListItem(BuildContext context, _ListItem item, ColorScheme colorScheme) {
    final textTheme = Theme.of(context).textTheme;
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
            style: textTheme.labelMedium?.copyWith(color: colorScheme.onSurfaceVariant),
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
      final dateLabel = DateFormatter.dayLabel(txn.timestamp, l10n);
      if (dateLabel != lastDate) {
        items.add(_DateHeader(dateLabel));
        lastDate = dateLabel;
      }
      items.add(_TxnRow(txn));
    }

    return items;
  }

  Future<void> _sendReminder(
    BuildContext context,
    AppLocalizations l10n,
    Customer customer,
  ) async {
    final phone = customer.phone;
    if (phone == null || phone.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.reminderNoPhone)),
      );
      return;
    }
    final balance = customer.netBalance;
    if (balance == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.reminderNoBalance)),
      );
      return;
    }
    final profile      = ref.read(profileProvider).value;
    final businessName = profile.businessName;
    final message = l10n.reminderMessage(
      customer.name,
      balance.abs().toStringAsFixed(0),
      businessName,
    );
    final catalogPaths = profile?.catalogImagePaths ?? const [];
    if (catalogPaths.isEmpty) {
      await ReminderService.send(
          context: context, phone: phone, message: message);
      return;
    }
    if (!context.mounted) return;
    final result = await context.push<AttachResult>(
      '/reminder/attach',
      extra: AttachImageExtra(message: message, imagePaths: catalogPaths),
    );
    if (!context.mounted) return;
    await ReminderService.send(
      context: context,
      phone: phone,
      message: message,
      imagePath: result?.imagePath,
    );
  }

  void _showCustomerActions(
    BuildContext context,
    AppLocalizations l10n,
    Customer customer,
  ) {
    KpActionSheet.show(context, actions: [
      KpAction(
        icon: Icons.alarm_rounded,
        label: l10n.setReminderTitle,
        onTap: () => SetReminderSheet.show(context, ref, customer),
      ),
      KpAction(
        icon: Icons.edit_outlined,
        label: l10n.editCustomerTitle,
        onTap: () => context.push('/customers/${customer.id}/edit', extra: customer),
      ),
      KpAction(
        icon: Icons.delete_outline_rounded,
        label: l10n.deleteAction,
        isDestructive: true,
        onTap: () => _confirmDeleteCustomer(context, l10n, customer),
      ),
    ]);
  }

  Future<void> _confirmDeleteCustomer(
    BuildContext context,
    AppLocalizations l10n,
    Customer customer,
  ) async {
    final confirmed = await KpDeleteDialog.show(
      context,
      body: l10n.deleteCustomerConfirmBody,
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

    final initial = customer.name.isNotEmpty ? customer.name[0].toUpperCase() : '?';
    final balance = customer.netBalance;

    final (amountColor, dirLabel) = switch (balance) {
      > 0 => (cs.tertiary,  l10n.customerDetailOwesYou),
      < 0 => (cs.secondary, l10n.customerDetailYouOwe),
      _   => (cs.onSurfaceVariant, l10n.customerDetailSettled),
    };

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
          HeroAvatar(initial: initial),
          const SizedBox(width: AppDimensions.inputPaddingH),
          Expanded(
            flex: 3,
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
                  maxLines: 1,
                ),
                if (customer.shopName != null)
                  Text(
                    customer.shopName!,
                    style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppDimensions.inputPaddingH),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AmountText.balance(
                  balance: balance,
                  isMasked: isMasked,
                  style: tt.titleLarge?.copyWith(
                    fontSize: _Dims.balanceFontSize,
                  ),
                ),
                Text(
                  dirLabel,
                  style: tt.labelSmall?.copyWith(color: amountColor),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.end,
                ),
                if (customer.reminderFrequency != ReminderFrequency.none)
                  _ReminderChip(frequency: customer.reminderFrequency),
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
    final cs   = Theme.of(context).colorScheme;
    final tt   = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    final timeStr  = DateFormat.jm(l10n.localeName).format(transaction.timestamp);
    final isCredit = transaction.isCredit;

    return InkWell(
      onTap: () => _showActions(context, ref, l10n),
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
                      isCredit ? l10n.txnDirectionGave : l10n.txnDirectionReceived,
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
            AmountText.transaction(
              amount: transaction.amount,
              isCredit: isCredit,
              isMasked: isMasked,
            ),
            const SizedBox(width: AppDimensions.buttonStackGap),
            MoreIconButton(onTap: () => _showActions(context, ref, l10n)),
          ],
        ),
      ),
    );
  }

  void _showActions(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) {
    KpActionSheet.show(context, actions: [
      KpAction(
        icon: Icons.edit_outlined,
        label: l10n.editEntryTitle,
        onTap: () => context.push(
          '/customers/${transaction.customerId}/entry/edit',
          extra: transaction,
        ),
      ),
      KpAction(
        icon: Icons.delete_outline_rounded,
        label: l10n.deleteAction,
        isDestructive: true,
        onTap: () => _confirmDelete(context, ref, l10n),
      ),
    ]);
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) async {
    final confirmed = await KpDeleteDialog.show(
      context,
      body: l10n.deleteTxnConfirmBody,
    );
    if (confirmed == true && context.mounted) {
      await ref
          .read(customerTransactionsProvider(transaction.customerId).notifier)
          .deleteTransaction(transaction.id);
    }
  }
}

// ── Reminder frequency chip ───────────────────────────────────────────────────

class _ReminderChip extends StatelessWidget {
  const _ReminderChip({required this.frequency});

  final ReminderFrequency frequency;

  @override
  Widget build(BuildContext context) {
    final cs   = Theme.of(context).colorScheme;
    final tt   = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    final label = switch (frequency) {
      ReminderFrequency.weekly      => l10n.reminderFrequencyWeekly,
      ReminderFrequency.fortnightly => l10n.reminderFrequencyFortnightly,
      ReminderFrequency.monthly     => l10n.reminderFrequencyMonthly,
      ReminderFrequency.none        => '',
    };

    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: cs.primaryContainer,
        borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.alarm_rounded, size: 10, color: cs.onPrimaryContainer),
          const SizedBox(width: 4),
          Text(
            label,
            style: tt.labelSmall?.copyWith(color: cs.onPrimaryContainer),
          ),
        ],
      ),
    );
  }
}

// ── Bottom action bar ─────────────────────────────────────────────────────────

class _BottomActionBar extends StatelessWidget {
  const _BottomActionBar({
    required this.onWhatsApp,
    required this.onGenerateBill,
    required this.l10n,
  });

  final VoidCallback onWhatsApp;
  final VoidCallback onGenerateBill;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      elevation: AppDimensions.elevationLifted,
      color: colorScheme.surface,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: _Dims.actionBarHeight,
          child: Row(
            children: [
              _ActionBarButton(
                icon:  Icons.send_rounded,
                label: l10n.reminderSendButton,
                onTap: onWhatsApp,
              ),
              VerticalDivider(
                width:     _Dims.actionBarDividerW,
                thickness: _Dims.actionBarDividerW,
                color:     colorScheme.outlineVariant,
              ),
              _ActionBarButton(
                icon:  Icons.receipt_long_rounded,
                label: l10n.generateBillTitle,
                onTap: onGenerateBill,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionBarButton extends StatelessWidget {
  const _ActionBarButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme   = Theme.of(context).textTheme;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: AppDimensions.iconSizeMedium, color: colorScheme.primary),
            const SizedBox(height: 4),
            Text(
              label,
              style: textTheme.labelSmall?.copyWith(color: colorScheme.primary),
            ),
          ],
        ),
      ),
    );
  }
}
