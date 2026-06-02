import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/customer_provider.dart';
import '../providers/transaction_provider.dart';
import '../widgets/balance_card.dart';
import '../widgets/dashboard_app_bar.dart' show DashboardHeader;
import '../widgets/home_empty_state.dart';
import '../widgets/quick_actions_row.dart';
import '../widgets/summary_pills.dart';
import '../widgets/transaction_list_tile.dart';

abstract final class _Dims {
  static const double sectionGap    = 16.0;
  static const double listHeaderGap = 8.0;
}

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  bool _isMasked = false;

  @override
  Widget build(BuildContext context) {
    final l10n             = AppLocalizations.of(context)!;
    final cs               = Theme.of(context).colorScheme;
    final tt               = Theme.of(context).textTheme;
    final topInset         = MediaQuery.paddingOf(context).top;
    final customersAsync   = ref.watch(customerProvider);
    final transactionsAsync = ref.watch(transactionProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: cs.brightness == Brightness.dark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: cs.surface,
        body: customersAsync.when(
          loading: () => const _LoadingView(),
          error: (e, _) => _ErrorView(
            onRetry: () => ref.invalidate(customerProvider),
          ),
          data: (customers) {
            final netBalance   = customers.fold(0.0, (sum, c) => sum + c.netBalance);
            final totalIncome  = customers
                .where((c) => c.netBalance > 0)
                .fold(0.0, (sum, c) => sum + c.netBalance);
            final totalExpense = customers
                .where((c) => c.netBalance < 0)
                .fold(0.0, (sum, c) => sum + c.netBalance.abs());

            if (customers.isEmpty) {
              return SafeArea(
                bottom: false,
                child: HomeEmptyState(
                  onAddCustomer: () => context.push('/customers/add'),
                ),
              );
            }

            return transactionsAsync.when(
              loading: () => const _LoadingView(),
              error: (e, _) => _ErrorView(
                onRetry: () => ref.invalidate(transactionProvider),
              ),
              data: (transactions) => CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: _HeroBand(
                      topInset: topInset,
                      netBalance: netBalance,
                      totalIncome: totalIncome,
                      totalExpense: totalExpense,
                      isMasked: _isMasked,
                      onToggleMask: () =>
                          setState(() => _isMasked = !_isMasked),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        AppDimensions.buttonPaddingH,
                        AppDimensions.heroCardOverlap + _Dims.sectionGap,
                        AppDimensions.buttonPaddingH,
                        0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const QuickActionsRow(),
                          const SizedBox(height: _Dims.sectionGap),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  l10n.homeRecentTransactions,
                                  style: tt.titleMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(l10n.homeSeeAll),
                              ),
                            ],
                          ),
                          const SizedBox(height: _Dims.listHeaderGap),
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => TransactionListTile(
                        transaction: transactions[index],
                        isMasked: _isMasked,
                      ),
                      childCount: transactions.length,
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: AppDimensions.fabClearance),
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.push('/customers/add'),
          tooltip: l10n.homeAddEntry,
          child: const Icon(Icons.add_rounded),
        ),
      ),
    );
  }
}

/// Hero band: plain surface background, header + balance stacked above the
/// overlapping summary card. No illustration or gradient.
class _HeroBand extends StatelessWidget {
  const _HeroBand({
    required this.topInset,
    required this.netBalance,
    required this.totalIncome,
    required this.totalExpense,
    required this.isMasked,
    required this.onToggleMask,
  });

  final double topInset;
  final double netBalance;
  final double totalIncome;
  final double totalExpense;
  final bool isMasked;
  final VoidCallback onToggleMask;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          color: cs.surfaceContainerLow,
          padding: EdgeInsets.only(
            top: topInset + AppDimensions.heroContentPaddingTop,
            bottom: AppDimensions.heroContentPaddingBottom +
                AppDimensions.heroCardOverlap,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.buttonPaddingH,
                ),
                child: DashboardHeader(foregroundColor: cs.onSurface),
              ),
              const SizedBox(height: _Dims.sectionGap),
              BalanceCard(
                netBalance: netBalance,
                isMasked: isMasked,
                onToggleMask: onToggleMask,
              ),
            ],
          ),
        ),
        Positioned(
          left: AppDimensions.buttonPaddingH,
          right: AppDimensions.buttonPaddingH,
          bottom: -AppDimensions.heroCardOverlap,
          child: SummaryPills(
            totalIncome: totalIncome,
            totalExpense: totalExpense,
            isMasked: isMasked,
          ),
        ),
      ],
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline_rounded, color: cs.error, size: AppDimensions.errorIconSize),
          const SizedBox(height: AppDimensions.errorIconGap),
          FilledButton(onPressed: onRetry, child: Text(AppLocalizations.of(context)!.retryButton)),
        ],
      ),
    );
  }
}
