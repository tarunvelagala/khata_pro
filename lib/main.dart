import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/services/reminder_scheduler.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/app_lock_wrapper.dart';
import 'features/home/presentation/providers/customer_provider.dart';
import 'features/settings/presentation/providers/locale_provider.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';
import 'router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    debugPrint('Firebase init failed: $e');
    // Continue without Firebase — local features still work
  }

  // Initialise notifications and reschedule active reminders.
  // Customer list may not be loaded yet — init with empty list; customers are
  // rescheduled individually whenever their frequency is changed.
  await ReminderScheduler.init([]);

  // Handle notification tap that launched the app from terminated state.
  final launchDetails =
      await ReminderScheduler.plugin.getNotificationAppLaunchDetails();
  final launchCustomerId =
      launchDetails?.didNotificationLaunchApp == true
          ? launchDetails?.notificationResponse?.payload
          : null;

  // Wire foreground / background tap → navigate to customer.
  ReminderScheduler.plugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    ),
    onDidReceiveNotificationResponse: (resp) {
      final id = resp.payload;
      if (id != null) appRouter.go('/customers/$id');
    },
  );

  runApp(ProviderScope(
    child: KhataProApp(launchCustomerId: launchCustomerId),
  ));
}

class KhataProApp extends ConsumerWidget {
  const KhataProApp({super.key, this.launchCustomerId});

  final String? launchCustomerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeAsync = ref.watch(localeProvider);

    // Reschedule reminders whenever the customer list changes.
    ref.listen(customerProvider, (_, next) {
      next.whenData((customers) {
        for (final c in customers) {
          final hasDate = c.reminderDate != null && c.reminderDate!.isAfter(DateTime.now());
          if (hasDate || c.reminderFrequency.days > 0) {
            ReminderScheduler.scheduleForCustomer(c);
          }
        }
      });
    });

    // Navigate to the customer that was tapped from a notification.
    if (launchCustomerId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        appRouter.go('/customers/$launchCustomerId');
      });
    }

    return MaterialApp.router(
        title: 'KhataPro',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        routerConfig: appRouter,
        locale: localeAsync.value,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        builder: (context, child) => AppLockWrapper(child: child ?? const SizedBox.shrink()),
      );
  }
}
