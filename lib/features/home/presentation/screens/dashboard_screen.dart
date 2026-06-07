import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/widgets/kp_empty_state.dart';
import '../../../../core/widgets/kp_error_view.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/customer_provider.dart';
import '../providers/dashboard_summary_provider.dart';
import '../providers/shell_nav_provider.dart';
import '../providers/transaction_provider.dart';
import '../widgets/balance_card.dart';
import '../widgets/dashboard_app_bar.dart' show DashboardHeader;
import '../widgets/first_run_banner.dart';
import '../widgets/quick_actions_row.dart';
import '../widgets/transaction_list_tile.dart';

abstract final class _Dims {
  static const double sectionGap    = 16.0;
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
          error: (e, _) => KpErrorView(
            onRetry: () => ref.invalidate(customerProvider),
          ),
          data: (customers) {
            final summary = ref.watch(dashboardSummaryProvider);

            if (customers.isEmpty) {
              return SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    const FirstRunBanner(),
                    Expanded(
                      child: KpEmptyState(
                        icon: Icons.people_outline_rounded,
                        title: l10n.homeEmptyTitle,
                        body: l10n.homeEmptyBody,
                        ctaLabel: l10n.homeEmptyAddCustomer,
                        ctaIcon: Icons.person_add_rounded,
                        onCta: () => context.push('/customers/add'),
                      ),
                    ),
                  ],
                ),
              );
            }

            return transactionsAsync.when(
              loading: () => const _LoadingView(),
              error: (e, _) => KpErrorView(
                onRetry: () => ref.invalidate(transactionProvider),
              ),
              data: (transactions) => CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: _HeroBand(
                      topInset: topInset,
                      netBalance: summary.netBalance,
                      totalIncome: summary.totalIncome,
                      totalExpense: summary.totalExpense,
                      isMasked: _isMasked,
                      onToggleMask: () =>
                          setState(() => _isMasked = !_isMasked),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        AppDimensions.buttonPaddingH,
                        _Dims.sectionGap,
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
                              if (transactions.isNotEmpty)
                                Flexible(
                                  child: TextButton(
                                    onPressed: () => ref
                                        .read(shellNavProvider.notifier)
                                        .select(1),
                                    child: Text(
                                      l10n.homeSeeAll,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (transactions.isEmpty)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: KpEmptyState(
                        icon: Icons.receipt_long_outlined,
                        title: l10n.homeNoTransactions,
                      ),
                    )
                  else
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
                    child: SizedBox(height: AppDimensions.buttonPaddingV),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Hero band: plain surface background, header + balance + inline stats.
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
    return Container(
      color: cs.surfaceContainerLow,
      padding: EdgeInsets.only(
        top: topInset + AppDimensions.heroContentPaddingTop,
        bottom: AppDimensions.heroContentPaddingBottom,
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
          BalanceCard(
            netBalance: netBalance,
            totalIncome: totalIncome,
            totalExpense: totalExpense,
            isMasked: isMasked,
            onToggleMask: onToggleMask,
          ),
        ],
      ),
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

