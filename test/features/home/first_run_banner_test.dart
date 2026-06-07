import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khata_pro/core/constants/prefs_keys.dart';
import 'package:khata_pro/core/theme/app_theme.dart';
import 'package:khata_pro/features/home/presentation/widgets/first_run_banner.dart';
import 'package:khata_pro/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget _harness(Widget child) {
  return ProviderScope(
    child: MaterialApp(
      theme: AppTheme.light,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: child),
    ),
  );
}

void main() {
  group('FirstRunBanner', () {
    testWidgets('banner is visible when prefs are empty', (tester) async {
      SharedPreferences.setMockInitialValues({});

      await tester.pumpWidget(_harness(const FirstRunBanner()));
      await tester.pumpAndSettle();

      // Banner content (title key) should be present
      expect(find.byType(FirstRunBanner), findsOneWidget);
      // The SizedBox.shrink sentinel is NOT the only widget — actual banner card shown
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('banner is hidden when already dismissed in prefs', (tester) async {
      SharedPreferences.setMockInitialValues({
        PrefsKeys.firstRunBannerDismissed: true,
      });

      await tester.pumpWidget(_harness(const FirstRunBanner()));
      await tester.pumpAndSettle();

      // When dismissed=true the widget returns SizedBox.shrink, so no Container
      expect(find.byType(Container), findsNothing);
    });

    testWidgets('tapping close icon writes dismissed=true to prefs', (tester) async {
      SharedPreferences.setMockInitialValues({});

      await tester.pumpWidget(_harness(const FirstRunBanner()));
      await tester.pumpAndSettle();

      // Tap the close icon
      await tester.tap(find.byIcon(Icons.close_rounded));
      await tester.pumpAndSettle();

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool(PrefsKeys.firstRunBannerDismissed), isTrue);
    });

    testWidgets('banner hides after dismiss tap', (tester) async {
      SharedPreferences.setMockInitialValues({});

      await tester.pumpWidget(_harness(const FirstRunBanner()));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.close_rounded));
      await tester.pumpAndSettle();

      expect(find.byType(Container), findsNothing);
    });
  });
}
