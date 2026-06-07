import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/offline_banner.dart';
import '../../../../core/widgets/unsynced_banner.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/shell_nav_provider.dart';
import 'customers_screen.dart';
import 'dashboard_screen.dart';
import '../../../../features/reports/presentation/screens/reports_screen.dart';
import '../../../../features/settings/presentation/screens/settings_screen.dart';

class HomeShell extends ConsumerWidget {
  const HomeShell({super.key});

  static const List<Widget> _screens = [
    DashboardScreen(),
    CustomersScreen(),
    ReportsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n          = AppLocalizations.of(context)!;
    final selectedIndex = ref.watch(shellNavProvider);

    return Scaffold(
      body: Column(
        children: [
          const OfflineBanner(),
          const UnsyncedBanner(),
          Expanded(
            child: IndexedStack(index: selectedIndex, children: _screens),
          ),
        ],
      ),
      bottomNavigationBar: Material(
        child: NavigationBar(
          selectedIndex: selectedIndex,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          onDestinationSelected: (i) =>
              ref.read(shellNavProvider.notifier).select(i),
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: const Icon(Icons.home_rounded),
              label: l10n.navHome,
            ),
            NavigationDestination(
              icon: const Icon(Icons.people_outline_rounded),
              selectedIcon: const Icon(Icons.people_rounded),
              label: l10n.navCustomers,
            ),
            NavigationDestination(
              icon: const Icon(Icons.leaderboard_outlined),
              selectedIcon: const Icon(Icons.leaderboard_rounded),
              label: l10n.navReports,
            ),
            NavigationDestination(
              icon: const Icon(Icons.settings_outlined),
              selectedIcon: const Icon(Icons.settings_rounded),
              label: l10n.navSettings,
            ),
          ],
        ),
      ),
    );
  }
}
