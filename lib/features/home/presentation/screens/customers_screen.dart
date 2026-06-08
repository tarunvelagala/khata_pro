import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/widgets/kp_action_sheet.dart';
import '../../../../core/widgets/kp_search_bar.dart';
import '../../../../core/widgets/kp_delete_dialog.dart';
import '../../../../core/widgets/kp_empty_state.dart';
import '../../../../core/widgets/kp_error_view.dart';
import '../../../../core/widgets/scroll_hint_wrapper.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/models/customer.dart';
import '../providers/customer_provider.dart';
import '../widgets/customer_list_tile.dart';


class CustomersScreen extends ConsumerStatefulWidget {
  const CustomersScreen({super.key});

  @override
  ConsumerState<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends ConsumerState<CustomersScreen>
    with SmartSearchMixin {
  bool _isMasked = false;

  List<Customer> _filtered(List<Customer> all) {
    final q = searchQuery.trim().toLowerCase();
    if (q.isEmpty) return all;
    return all.where((c) {
      return c.name.toLowerCase().contains(q) ||
          (c.shopName?.toLowerCase().contains(q) ?? false) ||
          (c.phone?.contains(q) ?? false);
    }).toList();
  }

  @override
  void onSearchChanged(String v) {
    super.onSearchChanged(v);
    final all = ref.read(customerProvider).value ?? [];
    final matches = _filtered(all);
    if (matches.length == 1 && v.trim().isNotEmpty) {
      clearSearch();
      context.push('/customers/${matches.first.id}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n      = AppLocalizations.of(context)!;
    final cs        = Theme.of(context).colorScheme;
    final tt        = Theme.of(context).textTheme;
    final customers = ref.watch(customerProvider);

    return Scaffold(
      backgroundColor: cs.surface,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/customers/add'),
        icon: const Icon(Icons.person_add_rounded),
        label: Text(l10n.addCustomerTitle),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // ── Header ──────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.buttonPaddingH,
                vertical: AppDimensions.inputPaddingV / 2,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.navCustomers,
                      style: tt.headlineSmall?.copyWith(
                        color: cs.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => setState(() => _isMasked = !_isMasked),
                    icon: Icon(
                      _isMasked
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: cs.onSurfaceVariant,
                    ),
                    tooltip: _isMasked
                        ? l10n.balanceShowTooltip
                        : l10n.balanceHideTooltip,
                  ),
                ],
              ),
            ),

            // ── Search bar ──────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.buttonPaddingH,
              ),
              child: KpSearchBar(
                controller: searchController,
                hint: l10n.customersSearch,
                onChanged: onSearchChanged,
              ),
            ),

            const SizedBox(height: AppDimensions.inputPaddingV / 2),

            // ── List ────────────────────────────────────────────────
            Expanded(
              child: customers.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => KpErrorView(
                  onRetry: () => ref.invalidate(customerProvider),
                ),
                data: (all) {
                  final filtered = _filtered(all);
                  if (all.isEmpty) {
                    return KpEmptyState(
                      icon: Icons.people_outline_rounded,
                      title: l10n.homeEmptyTitle,
                      body: l10n.homeEmptyBody,
                    );
                  }
                  if (filtered.isEmpty) {
                    return KpEmptyState(
                      icon: Icons.search_off_rounded,
                      title: l10n.customersNoResults(searchQuery),
                    );
                  }
                  return ScrollHintWrapper(
                    hintLabel: l10n.scrollForMore,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: AppDimensions.fabClearance),
                      itemCount: filtered.length,
                      itemBuilder: (context, i) => CustomerListTile(
                        customer: filtered[i],
                        isMasked: _isMasked,
                        onTap: () {
                          clearSearch();
                          context.push('/customers/${filtered[i].id}');
                        },
                        onMoreTap: () => _showCustomerActions(context, filtered[i]),
                      ),
                    ),
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }

  void _showCustomerActions(BuildContext context, Customer customer) {
    final l10n = AppLocalizations.of(context)!;

    KpActionSheet.show(context, actions: [
      KpAction(
        icon: Icons.edit_outlined,
        label: l10n.editCustomerTitle,
        onTap: () => context.push('/customers/${customer.id}/edit', extra: customer),
      ),
      KpAction(
        icon: Icons.delete_outline_rounded,
        label: l10n.deleteAction,
        isDestructive: true,
        onTap: () => _confirmDelete(context, customer, l10n),
      ),
    ]);
  }

  Future<void> _confirmDelete(
    BuildContext context,
    Customer customer,
    AppLocalizations l10n,
  ) async {
    final confirmed = await KpDeleteDialog.show(
      context,
      body: l10n.deleteCustomerConfirmBody,
    );
    if (confirmed == true && context.mounted) {
      await ref.read(customerProvider.notifier).deleteCustomer(customer.id);
    }
  }
}

