import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/auth/presentation/screens/otp_verify_screen.dart';
import '../features/auth/presentation/screens/phone_number_screen.dart';
import '../features/auth/presentation/screens/set_pin_screen.dart';
import '../features/auth/presentation/screens/sign_in_screen.dart';
import '../features/home/domain/models/customer.dart';
import '../features/home/domain/models/transaction.dart';
import '../features/home/presentation/screens/add_customer_screen.dart';
import '../features/home/presentation/screens/add_entry_screen.dart';
import '../features/home/presentation/screens/attach_image_screen.dart';
import '../features/home/presentation/screens/catalog_image_viewer_screen.dart';
import '../features/home/presentation/screens/customer_detail_screen.dart';
import '../features/home/presentation/screens/customer_picker_screen.dart';
import '../features/home/presentation/screens/home_shell.dart';
import '../features/onboarding/presentation/screens/profile_setup_screen.dart';
import '../features/reports/presentation/screens/generate_bill_screen.dart';
import '../features/settings/presentation/screens/add_image_screen.dart';
import '../features/settings/presentation/screens/language_selection_screen.dart';
import '../features/settings/presentation/screens/profile_screen.dart';
import '../features/splash/presentation/screens/splash_screen.dart';
import '../features/tour/presentation/screens/tour_screen.dart';
import '../core/constants/prefs_keys.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text(state.error?.message ?? 'Page not found'),
    ),
  ),
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/redirect',
      redirect: (context, state) async {
        final prefs = await SharedPreferences.getInstance();
        if (prefs.getString(PrefsKeys.selectedLocale) == null) return '/settings/language';
        if (!(prefs.getBool(PrefsKeys.tourSeen) ?? false)) return '/tour';
        if (!(prefs.getBool(PrefsKeys.profileSetupDone) ?? false)) return '/auth/sign-in';
        return '/home';
      },
    ),
    GoRoute(path: '/tour', builder: (context, state) => const TourScreen()),
    GoRoute(
      path: '/auth/sign-in',
      builder: (context, state) => SignInScreen(
        isOnboarding: state.extra != false,
      ),
    ),
    GoRoute(
      path: '/auth/phone',
      builder: (context, state) => const PhoneNumberScreen(),
    ),
    GoRoute(
      path: '/auth/otp',
      redirect: (context, state) {
        if (state.extra is! OtpScreenArgs) return '/auth/phone';
        return null;
      },
      builder: (context, state) => OtpVerifyScreen(
        args: state.extra! as OtpScreenArgs,
      ),
    ),
    GoRoute(
      path: '/profile',
      pageBuilder: (context, state) => const MaterialPage(
        child: ProfileScreen(),
      ),
    ),
    GoRoute(
      path: '/onboarding/profile',
      pageBuilder: (context, state) => const MaterialPage(
        child: ProfileSetupScreen(),
      ),
    ),
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
      path: '/customers/pick',
      redirect: (context, state) {
        if (state.extra is! CustomerPickerExtra) return '/home';
        return null;
      },
      pageBuilder: (context, state) => MaterialPage(
        fullscreenDialog: true,
        child: CustomerPickerScreen(
          extra: state.extra! as CustomerPickerExtra,
        ),
      ),
    ),
    GoRoute(
      path: '/reminder/attach',
      redirect: (context, state) {
        if (state.extra is! AttachImageExtra) return '/home';
        return null;
      },
      pageBuilder: (context, state) => MaterialPage(
        fullscreenDialog: true,
        child: AttachImageScreen(
          extra: state.extra! as AttachImageExtra,
        ),
      ),
    ),
    GoRoute(
      path: '/profile/add-image',
      pageBuilder: (context, state) => const MaterialPage(
        fullscreenDialog: true,
        child: AddImageScreen(),
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
          existingCustomer: state.extra as Customer?,
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
      path: '/customers/:id/entry/receive',
      pageBuilder: (context, state) => MaterialPage(
        fullscreenDialog: true,
        child: AddEntryScreen(
          customerId: state.pathParameters['id']!,
          initialIsGave: false,
        ),
      ),
    ),
    GoRoute(
      path: '/customers/:id/entry/edit',
      pageBuilder: (context, state) => MaterialPage(
        fullscreenDialog: true,
        child: AddEntryScreen(
          customerId: state.pathParameters['id']!,
          existingTxn: state.extra as Transaction?,
        ),
      ),
    ),
    GoRoute(
      path: '/auth/set-pin',
      pageBuilder: (context, state) => const MaterialPage(
        fullscreenDialog: true,
        child: SetPinScreen(),
      ),
    ),
    GoRoute(
      path: '/customers/:id/bill',
      pageBuilder: (context, state) => MaterialPage(
        fullscreenDialog: true,
        child: GenerateBillScreen(
          customerId: state.pathParameters['id']!,
        ),
      ),
    ),
    GoRoute(
      path: '/customers/:id/image',
      redirect: (context, state) {
        if (state.extra is! String) return '/customers/${state.pathParameters['id']}';
        return null;
      },
      pageBuilder: (context, state) => MaterialPage(
        fullscreenDialog: true,
        child: CatalogImageViewerScreen(
          customerId: state.pathParameters['id']!,
          imagePath: state.extra! as String,
        ),
      ),
    ),
  ],
);
