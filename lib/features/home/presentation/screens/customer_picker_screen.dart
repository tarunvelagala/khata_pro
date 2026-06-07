import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/widgets/app_avatar.dart';
import '../../../../core/widgets/kp_search_bar.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/models/customer.dart';
import '../providers/customer_provider.dart';

abstract final class _Dims {
  static const double tileMinHeight = 56.0;
}

/// Route payload for [CustomerPickerScreen].
class CustomerPickerExtra {
  const CustomerPickerExtra({required this.title});
  final String title;
}

/// Full-screen customer picker. Pops with the selected customer ID (`String`).
///
/// Route: `/customers/pick`, `extra: CustomerPickerExtra`
class CustomerPickerScreen extends ConsumerStatefulWidget {
  const CustomerPickerScreen({super.key, required this.extra});

  final CustomerPickerExtra extra;

  @override
  ConsumerState<CustomerPickerScreen> createState() =>
      _CustomerPickerScreenState();
}

class _CustomerPickerScreenState extends ConsumerState<CustomerPickerScreen>
    with SmartSearchMixin {

  List<Customer> _filtered(List<Customer> all) {
    final q = searchQuery.trim().toLowerCase();
    if (q.isEmpty) return all;
    return all.where((c) {
      return c.name.toLowerCase().contains(q) ||
          (c.shopName?.toLowerCase().contains(q) ?? false);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n     = AppLocalizations.of(context)!;
    final cs       = Theme.of(context).colorScheme;
    final tt       = Theme.of(context).textTheme;
    final allAsync = ref.watch(customerProvider);

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(widget.extra.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.buttonPaddingH,
            ),
            child: KpSearchBar(
              controller: searchController,
              hint: l10n.recordPaymentPickerHint,
              onChanged: onSearchChanged,
              autofocus: true,
              showShadow: false,
            ),
          ),
          const SizedBox(height: AppDimensions.inputPaddingV / 2),
          Expanded(
            child: allAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) => const SizedBox.shrink(),
              data: (all) {
                final filtered = _filtered(all);
                if (filtered.isEmpty) {
                  return Center(
                    child: Text(
                      l10n.customersNoResults(searchQuery),
                      style: tt.bodyMedium?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (_, i) {
                    final c       = filtered[i];
                    final initial = c.name.isNotEmpty
                        ? c.name.characters.first.toUpperCase()
                        : '?';
                    return InkWell(
                      onTap: () => context.pop(c.id),
                      child: Container(
                        constraints: const BoxConstraints(
                          minHeight: _Dims.tileMinHeight,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.buttonPaddingH,
                          vertical: AppDimensions.inputPaddingV / 2,
                        ),
                        child: Row(
                          children: [
                            ListTileAvatar(initial: initial),
                            const SizedBox(width: AppDimensions.inputPaddingH),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    c.name,
                                    style: tt.bodyMedium?.copyWith(
                                      color: cs.onSurface,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  if (c.shopName != null)
                                    Text(
                                      c.shopName!,
                                      style: tt.bodySmall?.copyWith(
                                        color: cs.onSurfaceVariant,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
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
