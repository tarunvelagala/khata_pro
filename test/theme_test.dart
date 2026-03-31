import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khata_mitra/core/theme/app_colors.dart';
import 'package:khata_mitra/core/theme/app_text_styles.dart';
import 'package:khata_mitra/core/theme/app_theme.dart';

void main() {
  testWidgets('Theme integration tests', (WidgetTester tester) async {
    // Test AppColors
    expect(AppColors.primary, const Color(0xFF004D99));

    // Test AppTextStyles by building them in a widget tree
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: Column(
            children: [
              Text('Display', style: AppTextStyles.displayLarge),
              Text('Body', style: AppTextStyles.bodyLarge),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Display'), findsOneWidget);
    expect(find.text('Body'), findsOneWidget);

    // Test ColorScheme
    final theme = Theme.of(tester.element(find.text('Display')));
    expect(theme.colorScheme.primary, AppColors.primary);
    expect(theme.colorScheme.brightness, Brightness.light);

    // Test AppSurfaceColors extension
    final surfaceColors = theme.extension<AppSurfaceColors>();
    expect(surfaceColors, isNotNull);
    expect(surfaceColors!.lowest, AppColors.surfaceContainerLowest);
  });

  test('AppSurfaceColors logic', () {
    const a = AppSurfaceColors(
      lowest: Colors.white,
      low: Colors.white,
      medium: Colors.white,
      high: Colors.white,
      highest: Colors.white,
    );
    const b = AppSurfaceColors(
      lowest: Colors.black,
      low: Colors.black,
      medium: Colors.black,
      high: Colors.black,
      highest: Colors.black,
    );
    
    // Test lerp
    final result = a.lerp(b, 0.5);
    expect(result.lowest, Color.lerp(Colors.white, Colors.black, 0.5));

    // Test lerp with null
    expect(a.lerp(null, 0.5), a);

    // Test lerp with incompatible type (for branch coverage)
    // We use a dummy ThemeExtension to trigger the "other is! AppSurfaceColors" branch
    expect(a.lerp(const _IncompatibleExtension(), 0.5), a);

    // Test copyWith
    final updated = a.copyWith(lowest: Colors.red);
    expect(updated.lowest, Colors.red);
    expect(updated.low, Colors.white);
  });

  testWidgets('Sub-theme verification', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: Column(
            children: [
              ElevatedButton(onPressed: () {}, child: const Text('Elevated')),
              const Card(child: Text('Card')),
              const Chip(label: Text('Chip')),
              const TextField(decoration: InputDecoration(labelText: 'Input')),
            ],
          ),
        ),
      ),
    );

    // Verify ElevatedButton
    final elevatedButtonTheme = Theme.of(tester.element(find.byType(ElevatedButton))).elevatedButtonTheme;
    final elevatedButtonStyle = elevatedButtonTheme.style!;
    expect(elevatedButtonStyle.backgroundColor?.resolve({}), AppColors.primary);

    // Verify Card
    final cardTheme = Theme.of(tester.element(find.byType(Card))).cardTheme;
    expect(cardTheme.color, AppColors.surfaceContainerLowest);

    // Verify Chip
    final chipTheme = Theme.of(tester.element(find.byType(Chip))).chipTheme;
    expect(chipTheme.backgroundColor, AppColors.surfaceContainerHighest);

    // Verify TextField / InputDecoration
    final inputDecorationTheme = Theme.of(tester.element(find.byType(TextField))).inputDecorationTheme;
    expect(inputDecorationTheme.fillColor, AppColors.surfaceContainerHigh);
  });
}

class _IncompatibleExtension extends ThemeExtension<AppSurfaceColors> {
  const _IncompatibleExtension();
  @override
  AppSurfaceColors copyWith() => const AppSurfaceColors(
    lowest: Colors.black,
    low: Colors.black,
    medium: Colors.black,
    high: Colors.black,
    highest: Colors.black,
  );
  @override
  AppSurfaceColors lerp(ThemeExtension<AppSurfaceColors>? other, double t) => copyWith();
}
