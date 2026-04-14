import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khata_pro/core/theme/app_theme.dart';
import 'package:khata_pro/features/onboarding/presentation/widgets/step_indicator.dart';

// ── Helper ────────────────────────────────────────────────────────────────────

Widget _wrap(Widget child, {Brightness brightness = Brightness.light}) =>
    MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(body: Center(child: child)),
    );

// Returns all AnimatedContainers rendered by the indicator.
Iterable<AnimatedContainer> _dots(WidgetTester tester) =>
    tester.widgetList<AnimatedContainer>(find.byType(AnimatedContainer));

// Width of the i-th dot (0-based).
double _dotWidth(WidgetTester tester, int index) =>
    _dots(tester).elementAt(index).constraints!.maxWidth;

// Padding widgets that are direct children of the indicator's Row.
List<Padding> _dotPaddings(WidgetTester tester) {
  final rowElement = tester.element(
    find.descendant(
      of: find.byType(OnboardingStepIndicator),
      matching: find.byType(Row),
    ),
  );
  final children = <Padding>[];
  rowElement.visitChildren((child) {
    final widget = child.widget;
    if (widget is Padding) children.add(widget);
  });
  return children;
}

// ── Tests ─────────────────────────────────────────────────────────────────────

void main() {
  group('OnboardingStepIndicator — structure', () {
    testWidgets('renders exactly `total` dots', (tester) async {
      await tester.pumpWidget(_wrap(
        const OnboardingStepIndicator(current: 1, total: 4),
      ));
      expect(_dots(tester).length, 4);
    });

    testWidgets('renders correct count for total=3', (tester) async {
      await tester.pumpWidget(_wrap(
        const OnboardingStepIndicator(current: 2, total: 3),
      ));
      expect(_dots(tester).length, 3);
    });

    testWidgets('uses Row with mainAxisSize.min', (tester) async {
      await tester.pumpWidget(_wrap(
        const OnboardingStepIndicator(current: 1, total: 4),
      ));
      final row = tester.widget<Row>(
        find.descendant(
          of: find.byType(OnboardingStepIndicator),
          matching: find.byType(Row),
        ),
      );
      expect(row.mainAxisSize, MainAxisSize.min);
    });
  });

  group('OnboardingStepIndicator — active dot width', () {
    testWidgets('active dot (step 1) is wider than inactive dots', (tester) async {
      await tester.pumpWidget(_wrap(
        const OnboardingStepIndicator(current: 1, total: 4),
      ));
      final activeDotWidth = _dotWidth(tester, 0);
      for (var i = 1; i < 4; i++) {
        expect(activeDotWidth, greaterThan(_dotWidth(tester, i)));
      }
    });

    testWidgets('active dot (step 2) is wider than inactive dots', (tester) async {
      await tester.pumpWidget(_wrap(
        const OnboardingStepIndicator(current: 2, total: 4),
      ));
      final activeDotWidth = _dotWidth(tester, 1);
      for (var i = 0; i < 4; i++) {
        if (i == 1) continue;
        expect(activeDotWidth, greaterThan(_dotWidth(tester, i)));
      }
    });

    testWidgets('active dot (step 4) is wider than inactive dots', (tester) async {
      await tester.pumpWidget(_wrap(
        const OnboardingStepIndicator(current: 4, total: 4),
      ));
      final activeDotWidth = _dotWidth(tester, 3);
      for (var i = 0; i < 3; i++) {
        expect(activeDotWidth, greaterThan(_dotWidth(tester, i)));
      }
    });

    testWidgets('exactly one dot is wider than the rest', (tester) async {
      await tester.pumpWidget(_wrap(
        const OnboardingStepIndicator(current: 3, total: 4),
      ));
      final widths = List.generate(4, (i) => _dotWidth(tester, i));
      final maxWidth = widths.reduce((a, b) => a > b ? a : b);
      final widerCount = widths.where((w) => w == maxWidth).length;
      expect(widerCount, 1);
    });

    testWidgets('all inactive dots have equal width', (tester) async {
      await tester.pumpWidget(_wrap(
        const OnboardingStepIndicator(current: 2, total: 4),
      ));
      final inactiveWidths = [0, 2, 3].map((i) => _dotWidth(tester, i)).toSet();
      expect(inactiveWidths.length, 1);
    });
  });

  group('OnboardingStepIndicator — dot colours', () {
    testWidgets('active dot uses primary colour in light theme', (tester) async {
      await tester.pumpWidget(_wrap(
        const OnboardingStepIndicator(current: 1, total: 4),
      ));
      final cs = Theme.of(tester.element(find.byType(OnboardingStepIndicator))).colorScheme;
      final activeDot = _dots(tester).first;
      final decoration = activeDot.decoration as BoxDecoration;
      expect(decoration.color, cs.primary);
    });

    testWidgets('inactive dot uses outlineVariant colour in light theme', (tester) async {
      await tester.pumpWidget(_wrap(
        const OnboardingStepIndicator(current: 1, total: 4),
      ));
      final cs = Theme.of(tester.element(find.byType(OnboardingStepIndicator))).colorScheme;
      final inactiveDot = _dots(tester).elementAt(1);
      final decoration = inactiveDot.decoration as BoxDecoration;
      expect(decoration.color, cs.outlineVariant);
    });

    testWidgets('active dot uses primary colour in dark theme', (tester) async {
      await tester.pumpWidget(_wrap(
        const OnboardingStepIndicator(current: 2, total: 4),
        brightness: Brightness.dark,
      ));
      final cs = Theme.of(tester.element(find.byType(OnboardingStepIndicator))).colorScheme;
      final activeDot = _dots(tester).elementAt(1);
      final decoration = activeDot.decoration as BoxDecoration;
      expect(decoration.color, cs.primary);
    });
  });

  group('OnboardingStepIndicator — spacing', () {
    testWidgets('last dot has no right padding', (tester) async {
      await tester.pumpWidget(_wrap(
        const OnboardingStepIndicator(current: 1, total: 4),
      ));
      final paddings = _dotPaddings(tester);
      expect(paddings.length, 4);
      final lastPad = paddings.last.padding as EdgeInsets;
      expect(lastPad.right, 0.0);
    });

    testWidgets('non-last dots have positive right padding', (tester) async {
      await tester.pumpWidget(_wrap(
        const OnboardingStepIndicator(current: 1, total: 4),
      ));
      final paddings = _dotPaddings(tester);
      for (var i = 0; i < paddings.length - 1; i++) {
        final pad = paddings[i].padding as EdgeInsets;
        expect(pad.right, greaterThan(0.0));
      }
    });
  });

  group('OnboardingStepIndicator — step changes', () {
    testWidgets('active dot moves when current changes', (tester) async {
      // Start at step 1
      await tester.pumpWidget(_wrap(
        const OnboardingStepIndicator(current: 1, total: 4),
      ));
      final widthAtStep1 = _dotWidth(tester, 0);

      // Move to step 2
      await tester.pumpWidget(_wrap(
        const OnboardingStepIndicator(current: 2, total: 4),
      ));
      await tester.pumpAndSettle();

      // Dot 0 (step 1) should now be inactive (narrower)
      expect(_dotWidth(tester, 0), lessThan(widthAtStep1));
      // Dot 1 (step 2) should now be active (same width as dot 0 was before)
      expect(_dotWidth(tester, 1), widthAtStep1);
    });
  });
}
