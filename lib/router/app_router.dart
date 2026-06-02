import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/home/domain/models/customer.dart';
import '../features/home/domain/models/transaction.dart';
import '../features/home/presentation/screens/add_customer_screen.dart';
import '../features/home/presentation/screens/add_entry_screen.dart';
import '../features/home/presentation/screens/customer_detail_screen.dart';
import '../features/home/presentation/screens/home_shell.dart';
import '../features/settings/presentation/screens/language_selection_screen.dart';
import '../features/splash/presentation/screens/splash_screen.dart';
import '../features/tour/presentation/screens/tour_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/redirect',
      redirect: (context, state) async {
        final prefs = await SharedPreferences.getInstance();
        final hasLocale = prefs.getString('selected_locale') != null;
        if (!hasLocale) return '/settings/language';
        final tourSeen = prefs.getBool('tour_seen') ?? false;
        return tourSeen ? '/home' : '/tour';
      },
    ),
    GoRoute(path: '/tour', builder: (context, state) => const TourScreen()),
    GoRoute(
      path: '/settings/language',
      builder: (context, state) => const LanguageSelectionScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeShell(),
    ),
    GoRoute(
      path: '/customers/add',
      pageBuilder: (context, state) => const MaterialPage(
        fullscreenDialog: true,
        child: AddCustomerScreen(),
      ),
    ),
    GoRoute(
      path: '/customers/:id',
      builder: (context, state) => CustomerDetailScreen(
        customerId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/customers/:id/edit',
      pageBuilder: (context, state) => MaterialPage(
        fullscreenDialog: true,
        child: AddCustomerScreen(
          existingCustomer: state.extra as Customer,
        ),
      ),
    ),
    GoRoute(
      path: '/customers/:id/entry',
      pageBuilder: (context, state) => MaterialPage(
        fullscreenDialog: true,
        child: AddEntryScreen(customerId: state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/customers/:id/entry/edit',
      pageBuilder: (context, state) => MaterialPage(
        fullscreenDialog: true,
        child: AddEntryScreen(
          customerId: state.pathParameters['id']!,
          existingTxn: state.extra as Transaction,
        ),
      ),
    ),
  ],
);
