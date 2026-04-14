import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'features/onboarding/presentation/providers/onboarding_providers.dart';
import 'l10n/app_localizations.dart';
import 'router/app_router.dart';

void main() {
  runApp(const ProviderScope(child: KhataProApp()));
}

class KhataProApp extends ConsumerWidget {
  const KhataProApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final language = ref.watch(selectedLanguageProvider);

    return MaterialApp.router(
      title: 'KhataPro',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      routerConfig: appRouter,
      locale: Locale(language.code),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('hi'),
        Locale('kn'),
        Locale('ta'),
        Locale('bn'),
        Locale('mr'),
        Locale('ml'),
        Locale('te'),
      ],
    );
  }
}
