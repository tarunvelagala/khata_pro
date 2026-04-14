import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khata_pro/features/onboarding/presentation/screens/language_selection_screen.dart';
import 'package:khata_pro/features/onboarding/presentation/screens/permissions_screen.dart';
import 'package:khata_pro/features/onboarding/presentation/screens/shop_details_screen.dart';
import 'package:khata_pro/features/onboarding/presentation/screens/theme_selection_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/onboarding/language',
  routes: [
    GoRoute(
      path: '/onboarding/language',
      builder: (context, state) => const LanguageSelectionScreen(),
    ),
    GoRoute(
      path: '/onboarding/theme',
      builder: (context, state) => const ThemeSelectionScreen(),
    ),
    GoRoute(
      path: '/onboarding/shop-details',
      builder: (context, state) => const ShopDetailsScreen(),
    ),
    GoRoute(
      path: '/onboarding/permissions',
      builder: (context, state) => const PermissionsScreen(),
    ),
    // Placeholder until the main app feature is built
    GoRoute(
      path: '/home',
      builder: (context, state) => const Scaffold(
        body: Center(child: Text('KhataPro — Coming soon!')),
      ),
    ),
  ],
);
