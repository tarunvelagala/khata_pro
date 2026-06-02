import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/models/customer.dart';
import '../providers/customer_provider.dart';
import '../widgets/customer_list_tile.dart';

abstract final class _Dims {
  static const double searchIconSize = 20.0;
  static const double addIconSize    = 20.0;
  static const double searchShadowBlur = 8.0;
}

class CustomersScreen extends ConsumerStatefulWidget {
  const CustomersScreen({super.key});

  @override
  ConsumerState<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends ConsumerState<CustomersScreen> {
  final _searchController = TextEditingController();
  String _query = '';
  bool _isMasked = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Customer> _filtered(List<Customer> all) {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return all;
    return all.where((c) {
      return c.name.toLowerCase().contains(q) ||
          (c.shopName?.toLowerCase().contains(q) ?? false) ||
          (c.phone?.contains(q) ?? false);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n      = AppLocalizations.of(context)!;
    final cs        = Theme.of(context).colorScheme;
    final tt        = Theme.of(context).textTheme;
    final customers = ref.watch(customerProvider);
    final bottom    = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: cs.surface,
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
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowCard,
                      blurRadius: _Dims.searchShadowBlur,
                      offset: const Offset(0, AppDimensions.shadowOffsetCard),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: _onQueryChanged,
                  decoration: InputDecoration(
                    hintText: l10n.customersSearch,
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      size: _Dims.searchIconSize,
                      color: cs.onSurfaceVariant,
                    ),
                    suffixIcon: _query.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.close_rounded),
                            iconSize: _Dims.searchIconSize,
                            color: cs.onSurfaceVariant,
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _query = '');
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: cs.surfaceContainerLow,
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusPill),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusPill),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusPill),
                      borderSide: BorderSide(
                        color: cs.primary,
                        width: AppDimensions.borderFocused,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.inputPaddingH,
                      vertical: AppDimensions.inputPaddingV / 2,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppDimensions.inputPaddingV / 2),

            // ── List ────────────────────────────────────────────────
            Expanded(
              child: customers.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(
                  child: Text(
                    e.toString(),
                    style: TextStyle(color: cs.error),
                  ),
                ),
                data: (all) {
                  final filtered = _filtered(all);
                  if (all.isEmpty) return _EmptyState(onAdd: _openAdd);
                  if (filtered.isEmpty) return _NoResults(query: _query);
                  return ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (context, i) => CustomerListTile(
                      customer: filtered[i],
                      isMasked: _isMasked,
                      onTap: () => context.push('/customers/${filtered[i].id}'),
                      onMoreTap: () => _showCustomerActions(context, filtered[i]),
                    ),
                  );
                },
              ),
            ),

            // ── Add Customer CTA ────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppDimensions.buttonPaddingH,
                AppDimensions.buttonPaddingV / 2,
                AppDimensions.buttonPaddingH,
                AppDimensions.buttonPaddingV / 2 + bottom,
              ),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _openAdd,
                  icon: Icon(Icons.add_rounded, size: _Dims.addIconSize),
                  label: Text(l10n.customersAddButton),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openAdd() => context.push('/customers/add');

  void _onQueryChanged(String v) {
    setState(() => _query = v);
    // Smart search: auto-navigate when exactly one customer matches.
    final all = ref.read(customerProvider).value ?? [];
    final matches = _filtered(all);
    if (matches.length == 1 && v.trim().isNotEmpty) {
      context.push('/customers/${matches.first.id}');
    }
  }

  void _showCustomerActions(BuildContext context, Customer customer) {
    final l10n = AppLocalizations.of(context)!;
    final cs   = Theme.of(context).colorScheme;

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
                _confirmDelete(context, customer, l10n, cs);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    Customer customer,
    AppLocalizations l10n,
    ColorScheme cs,
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
    }
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onAdd});

  final VoidCallback onAdd;

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
            Icon(Icons.people_outline_rounded, size: AppDimensions.emptyIconSize, color: cs.outlineVariant),
            const SizedBox(height: AppDimensions.inputPaddingV),
            Text(
              l10n.homeEmptyTitle,
              style: tt.titleMedium?.copyWith(color: cs.onSurface),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.buttonStackGap),
            Text(
              l10n.homeEmptyBody,
              style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ── No results (search returned nothing) ──────────────────────────────────────

class _NoResults extends StatelessWidget {
  const _NoResults({required this.query});

  final String query;

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
            Icon(Icons.search_off_rounded, size: AppDimensions.errorIconSize, color: cs.outlineVariant),
            const SizedBox(height: AppDimensions.inputPaddingV),
            Text(
              l10n.customersNoResults(query),
              style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
