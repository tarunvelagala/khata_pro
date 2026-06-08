import 'package:flutter/material.dart';
import '../constants/app_dimensions.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';
import 'kp_theme_extension.dart';

abstract final class AppTheme {
  // ── Shared TextTheme ───────────────────────────────────────────────────
  // Cached as a static field so the same instances are reused on every
  // theme rebuild.
  static final TextTheme _textTheme = TextTheme(
    displayLarge: AppTextStyles.displayLarge,
    displayMedium: AppTextStyles.displayMedium,
    displaySmall: AppTextStyles.displaySmall,
    headlineLarge: AppTextStyles.headlineLarge,
    headlineMedium: AppTextStyles.headlineMedium,
    headlineSmall: AppTextStyles.headlineSmall,
    titleLarge: AppTextStyles.titleLarge,
    titleMedium: AppTextStyles.titleMedium,
    titleSmall: AppTextStyles.titleSmall,
    bodyLarge: AppTextStyles.bodyLarge,
    bodyMedium: AppTextStyles.bodyMedium,
    bodySmall: AppTextStyles.bodySmall,
    labelLarge: AppTextStyles.labelLarge,
    labelMedium: AppTextStyles.labelMedium,
    labelSmall: AppTextStyles.labelSmall,
  );

  // ── Color schemes ──────────────────────────────────────────────────────
  // Exposed as consts so unit tests can verify color tokens without
  // constructing ThemeData.

  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,
    primaryContainer: AppColors.primaryContainer,
    onPrimaryContainer: AppColors.onPrimaryContainer,
    secondary: AppColors.secondary,
    onSecondary: AppColors.onSecondary,
    secondaryContainer: AppColors.secondaryContainer,
    onSecondaryContainer: AppColors.onSecondaryContainer,
    tertiary: AppColors.tertiary,
    onTertiary: AppColors.onTertiary,
    tertiaryContainer: AppColors.tertiaryContainer,
    onTertiaryContainer: AppColors.onTertiaryContainer,
    error: AppColors.error,
    onError: AppColors.onError,
    errorContainer: AppColors.errorContainer,
    onErrorContainer: AppColors.onErrorContainer,
    surface: AppColors.surface,
    onSurface: AppColors.onSurface,
    surfaceDim: AppColors.surfaceDim,
    surfaceBright: AppColors.surfaceBright,
    surfaceContainerLowest: AppColors.surfaceContainerLowest,
    surfaceContainerLow: AppColors.surfaceContainerLow,
    surfaceContainer: AppColors.surfaceContainer,
    surfaceContainerHigh: AppColors.surfaceContainerHigh,
    surfaceContainerHighest: AppColors.surfaceContainerHighest,
    onSurfaceVariant: AppColors.onSurfaceVariant,
    outline: AppColors.outline,
    outlineVariant: AppColors.outlineVariant,
    inverseSurface: AppColors.inverseSurface,
    onInverseSurface: AppColors.inverseOnSurface,
    inversePrimary: AppColors.inversePrimary,
    scrim: Colors.black,
    shadow: Colors.black,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.darkPrimary,
    onPrimary: AppColors.darkOnPrimary,
    primaryContainer: AppColors.darkPrimaryContainer,
    onPrimaryContainer: AppColors.darkOnPrimaryContainer,
    secondary: AppColors.darkSecondary,
    onSecondary: AppColors.darkOnSecondary,
    secondaryContainer: AppColors.darkSecondaryContainer,
    onSecondaryContainer: AppColors.darkOnSecondaryContainer,
    tertiary: AppColors.darkTertiary,
    onTertiary: AppColors.darkOnTertiary,
    tertiaryContainer: AppColors.darkTertiaryContainer,
    onTertiaryContainer: AppColors.darkOnTertiaryContainer,
    error: AppColors.darkError,
    onError: AppColors.darkOnError,
    errorContainer: AppColors.darkErrorContainer,
    onErrorContainer: AppColors.darkOnErrorContainer,
    surface: AppColors.darkSurface,
    onSurface: AppColors.darkOnSurface,
    surfaceDim: AppColors.darkSurfaceDim,
    surfaceBright: AppColors.darkSurfaceBright,
    surfaceContainerLowest: AppColors.darkSurfaceContainerLowest,
    surfaceContainerLow: AppColors.darkSurfaceContainerLow,
    surfaceContainer: AppColors.darkSurfaceContainer,
    surfaceContainerHigh: AppColors.darkSurfaceContainerHigh,
    surfaceContainerHighest: AppColors.darkSurfaceContainerHighest,
    onSurfaceVariant: AppColors.darkOnSurfaceVariant,
    outline: AppColors.darkOutline,
    outlineVariant: AppColors.darkOutlineVariant,
    inverseSurface: AppColors.darkInverseSurface,
    onInverseSurface: AppColors.darkInverseOnSurface,
    inversePrimary: AppColors.darkInversePrimary,
    scrim: Colors.black,
    shadow: Colors.black,
  );

  // ── ThemeData ──────────────────────────────────────────────────────────

  static final ThemeData light = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: _textTheme,
    extensions: const [KpColorsExtension.light, KpTextThemeExtension.instance],
    cardTheme: _cardTheme(AppColors.surfaceContainerLowest),
    elevatedButtonTheme: _elevatedButtonTheme(
      bg: AppColors.primary,
      fg: AppColors.onPrimary,
    ),
    outlinedButtonTheme: _outlinedButtonTheme(
      fg: AppColors.primary,
      outline: AppColors.outline,
    ),
    filledButtonTheme: _filledButtonTheme(
      bg: AppColors.primary,
      fg: AppColors.onPrimary,
    ),
    inputDecorationTheme: _inputTheme(
      fill: AppColors.surfaceContainerHighest,
      focusBorder: AppColors.primary,
      errorColor: AppColors.error,
      outlineVariant: AppColors.outlineVariant,
      hintColor: AppColors.outline,
    ),
    appBarTheme: _appBarTheme(
      bg: AppColors.surfaceContainerLowest,
      icon: AppColors.primary,
    ),
    navigationBarTheme: _navigationBarTheme(
      bg: AppColors.surfaceContainerLowest,
      indicator: AppColors.primaryContainer,
      selectedIcon: AppColors.primary,
      selectedLabel: AppColors.primary,
      unselectedIcon: AppColors.onSurfaceVariant,
    ),
    floatingActionButtonTheme: _fabTheme(
      bg: AppColors.primary,
      fg: AppColors.onPrimary,
    ),
    dividerTheme: _dividerTheme(AppColors.outlineVariant),
  );

  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    scaffoldBackgroundColor: AppColors.darkBackground,
    textTheme: _textTheme,
    extensions: const [KpColorsExtension.dark, KpTextThemeExtension.instance],
    cardTheme: _cardTheme(AppColors.darkSurfaceContainerLowest),
    elevatedButtonTheme: _elevatedButtonTheme(
      bg: AppColors.darkPrimary,
      fg: AppColors.darkOnPrimary,
    ),
    outlinedButtonTheme: _outlinedButtonTheme(
      fg: AppColors.darkPrimary,
      outline: AppColors.darkOutline,
    ),
    filledButtonTheme: _filledButtonTheme(
      bg: AppColors.darkPrimary,
      fg: AppColors.darkOnPrimary,
    ),
    inputDecorationTheme: _inputTheme(
      fill: AppColors.darkSurfaceContainerHigh,
      focusBorder: AppColors.darkPrimary,
      errorColor: AppColors.darkError,
      outlineVariant: AppColors.darkOutlineVariant,
      hintColor: AppColors.darkOutline,
    ),
    appBarTheme: _appBarTheme(
      bg: AppColors.darkSurfaceContainerLowest,
      icon: AppColors.darkPrimary,
    ),
    navigationBarTheme: _navigationBarTheme(
      bg: AppColors.darkSurfaceContainerLowest,
      indicator: AppColors.darkPrimaryContainer,
      selectedIcon: AppColors.darkPrimary,
      selectedLabel: AppColors.darkPrimary,
      unselectedIcon: AppColors.darkOnSurfaceVariant,
    ),
    floatingActionButtonTheme: _fabTheme(
      bg: AppColors.darkPrimary,
      fg: AppColors.darkOnPrimary,
    ),
    dividerTheme: _dividerTheme(AppColors.darkOutlineVariant),
  );

  // ── Private component builders ─────────────────────────────────────────
  // These eliminate the light/dark duplication. Each builder encodes the
  // layout/shape decisions; callers supply only the color tokens.

  static CardThemeData _cardTheme(Color color) => CardThemeData(
    color: color,
    elevation: AppDimensions.elevationFlat,
    shadowColor: AppColors.shadowCard,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
    ),
  );

  static ElevatedButtonThemeData _elevatedButtonTheme({
    required Color bg,
    required Color fg,
  }) => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: bg,
      foregroundColor: fg,
      elevation: AppDimensions.elevationFlat,
      padding: const EdgeInsets.symmetric(
        vertical: AppDimensions.buttonPaddingV,
        horizontal: AppDimensions.buttonPaddingH,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
      ),
    ),
  );

  static OutlinedButtonThemeData _outlinedButtonTheme({
    required Color fg,
    required Color outline,
  }) => OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: fg,
      side: BorderSide(color: outline, width: AppDimensions.borderDefault),
      padding: const EdgeInsets.symmetric(
        vertical: AppDimensions.buttonPaddingV,
        horizontal: AppDimensions.buttonPaddingH,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
      ),
    ),
  );

  // Primary CTAs (ScreenFooter "Continue", "Get Started", "Add Customer") use
  // FilledButton. Pill shape signals a decisive, full-width action — distinct
  // from the more neutral ElevatedButton used for inline actions.
  static FilledButtonThemeData _filledButtonTheme({
    required Color bg,
    required Color fg,
  }) => FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: bg,
      foregroundColor: fg,
      padding: const EdgeInsets.symmetric(
        vertical: AppDimensions.buttonPaddingV,
        horizontal: AppDimensions.buttonPaddingH,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
      ),
    ),
  );

  static InputDecorationTheme _inputTheme({
    required Color fill,
    required Color focusBorder,
    required Color errorColor,
    required Color outlineVariant,
    required Color hintColor,
  }) => InputDecorationTheme(
    filled: false,
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusInput),
      borderSide: BorderSide(color: outlineVariant, width: AppDimensions.borderDefault),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusInput),
      borderSide: BorderSide(color: outlineVariant, width: AppDimensions.borderDefault),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusInput),
      borderSide: BorderSide(color: focusBorder, width: AppDimensions.borderFocused),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusInput),
      borderSide: BorderSide(color: errorColor, width: AppDimensions.borderDefault),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusInput),
      borderSide: BorderSide(color: errorColor, width: AppDimensions.borderFocused),
    ),
    labelStyle: AppTextStyles.bodyLarge.copyWith(color: AppColors.onSurfaceVariant),
    floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) {
      final color = states.contains(WidgetState.focused)
          ? focusBorder
          : AppColors.onSurfaceVariant;
      return AppTextStyles.labelSmall.copyWith(color: color);
    }),
    contentPadding: const EdgeInsets.fromLTRB(
      AppDimensions.inputPaddingH,
      AppDimensions.inputPaddingV + 6,
      AppDimensions.inputPaddingH,
      AppDimensions.inputPaddingV - 6,
    ),
    hintStyle: AppTextStyles.bodyLarge.copyWith(color: hintColor),
  );

  static AppBarTheme _appBarTheme({required Color bg, required Color icon}) =>
      AppBarTheme(
        backgroundColor: bg.withValues(alpha: AppDimensions.appBarOpacity),
        elevation: AppDimensions.elevationFlat,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(color: icon),
      );

  static DividerThemeData _dividerTheme(Color color) => DividerThemeData(
    color: color,
    thickness: AppDimensions.dividerThickness,
    space: AppDimensions.dividerSpace,
  );

  // The navigation bar uses elevationLifted so it visually separates from
  // content when home_shell removes the ClipRRect.
  static NavigationBarThemeData _navigationBarTheme({
    required Color bg,
    required Color indicator,
    required Color selectedIcon,
    required Color selectedLabel,
    required Color unselectedIcon,
  }) => NavigationBarThemeData(
    backgroundColor: bg,
    elevation: AppDimensions.elevationLifted,
    shadowColor: AppColors.shadowCard,
    indicatorColor: indicator,
    indicatorShape: const StadiumBorder(),
    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    iconTheme: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return IconThemeData(color: selectedIcon);
      }
      return IconThemeData(color: unselectedIcon);
    }),
    labelTextStyle: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppTextStyles.labelSmall.copyWith(color: selectedLabel);
      }
      return AppTextStyles.labelSmall.copyWith(color: unselectedIcon);
    }),
  );

  static FloatingActionButtonThemeData _fabTheme({
    required Color bg,
    required Color fg,
  }) => FloatingActionButtonThemeData(
    backgroundColor: bg,
    foregroundColor: fg,
    elevation: AppDimensions.elevationFlat,
    focusElevation: AppDimensions.elevationFlat,
    hoverElevation: AppDimensions.elevationFlat,
    shape: const StadiumBorder(),
  );
}
