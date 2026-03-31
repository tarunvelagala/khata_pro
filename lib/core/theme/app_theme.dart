import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

/// AppTheme manages the ThemeData for KhataMitra, implementing both light
/// and dark modes based on the Stitch Design System.
abstract class AppTheme {
  /// Defines Light Theme Data
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: lightColorScheme,
      scaffoldBackgroundColor: lightColorScheme.surface,
      textTheme: _textTheme,
      cardTheme: _cardTheme(lightColorScheme),
      elevatedButtonTheme: _elevatedButtonTheme(lightColorScheme),
      outlinedButtonTheme: _outlinedButtonTheme(lightColorScheme),
      textButtonTheme: _textButtonTheme(lightColorScheme),
      inputDecorationTheme: _inputDecorationTheme(lightColorScheme),
      chipTheme: _chipTheme(lightColorScheme),
      dividerTheme: _dividerTheme,
      extensions: [
        AppSurfaceColors(
          lowest: lightColorScheme.surfaceContainerLowest,
          low: AppColors.surfaceContainerLow,
          medium: AppColors.surfaceContainer,
          high: AppColors.surfaceContainerHigh,
          highest: AppColors.surfaceContainerHighest,
        ),
      ],
    );
  }

  /// Defines Dark Theme Data
  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
      scaffoldBackgroundColor: darkColorScheme.surface,
      textTheme: _textTheme,
      cardTheme: _cardTheme(darkColorScheme),
      elevatedButtonTheme: _elevatedButtonTheme(darkColorScheme),
      outlinedButtonTheme: _outlinedButtonTheme(darkColorScheme),
      textButtonTheme: _textButtonTheme(darkColorScheme),
      inputDecorationTheme: _inputDecorationTheme(darkColorScheme),
      chipTheme: _chipTheme(darkColorScheme),
      dividerTheme: _dividerTheme,
      extensions: [
        AppSurfaceColors(
          lowest: darkColorScheme.surfaceContainerLowest,
          low: AppColors.darkSurfaceContainerLow,
          medium: AppColors.darkSurfaceContainer,
          high: AppColors.darkSurfaceContainerHigh,
          highest: AppColors.darkSurfaceContainerHighest,
        ),
      ],
    );
  }

  /// Explicit Light Color Scheme
  static ColorScheme get lightColorScheme => const ColorScheme(
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
    surfaceContainerLowest: AppColors.surfaceContainerLowest,
    surfaceContainerLow: AppColors.surfaceContainerLow,
    surfaceContainer: AppColors.surfaceContainer,
    surfaceContainerHigh: AppColors.surfaceContainerHigh,
    surfaceContainerHighest: AppColors.surfaceContainerHighest,
    outline: AppColors.outline,
    outlineVariant: AppColors.outlineVariant,
    inverseSurface: AppColors.inverseSurface,
    onInverseSurface: AppColors.inverseOnSurface,
    inversePrimary: AppColors.inversePrimary,
    onSurfaceVariant: AppColors.onSurfaceVariant,
  );

  /// Explicit Dark Color Scheme
  static ColorScheme get darkColorScheme => const ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.darkPrimary,
    onPrimary: AppColors.darkOnPrimary,
    primaryContainer: AppColors.darkPrimaryContainer,
    onPrimaryContainer: AppColors.onPrimaryContainer, // Placeholder
    secondary: AppColors.darkSecondary,
    onSecondary: AppColors.onSecondary, // Placeholder
    secondaryContainer: AppColors.secondaryContainer, // Placeholder
    onSecondaryContainer: AppColors.onSecondaryContainer, // Placeholder
    tertiary: AppColors.darkTertiary,
    onTertiary: AppColors.onTertiary, // Placeholder
    tertiaryContainer: AppColors.tertiaryContainer, // Placeholder
    onTertiaryContainer: AppColors.onTertiaryContainer, // Placeholder
    error: AppColors.error,
    onError: AppColors.onError,
    errorContainer: AppColors.errorContainer,
    onErrorContainer: AppColors.onErrorContainer,
    surface: AppColors.darkSurface,
    onSurface: AppColors.darkOnSurface,
    surfaceContainerLowest: AppColors.darkSurfaceContainerLowest,
    surfaceContainerLow: AppColors.darkSurfaceContainerLow,
    surfaceContainer: AppColors.darkSurfaceContainer,
    surfaceContainerHigh: AppColors.darkSurfaceContainerHigh,
    surfaceContainerHighest: AppColors.darkSurfaceContainerHighest,
    outline: AppColors.outline,
    outlineVariant: AppColors.outlineVariant,
    inversePrimary: AppColors.darkInversePrimary,
  );

  static TextTheme get _textTheme => TextTheme(
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

  static CardThemeData _cardTheme(ColorScheme colors) => CardThemeData(
    color: colors.surfaceContainerLowest,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0), // lg (Large)
    ),
    margin: EdgeInsets.zero,
  );

  static ElevatedButtonThemeData _elevatedButtonTheme(ColorScheme colors) =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          elevation: 0,
          textStyle: AppTextStyles.labelLarge,
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
        ),
      );

  static OutlinedButtonThemeData _outlinedButtonTheme(ColorScheme colors) =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.primary,
          side: BorderSide(color: colors.outline.withOpacity(0.15)),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
        ),
      );

  static TextButtonThemeData _textButtonTheme(ColorScheme colors) =>
      TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colors.primary,
          textStyle: AppTextStyles.labelLarge,
        ),
      );

  static InputDecorationTheme _inputDecorationTheme(ColorScheme colors) =>
      InputDecorationTheme(
        filled: true,
        fillColor: colors.surfaceContainerHigh,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: colors.primary, width: 2.0),
        ),
        labelStyle: AppTextStyles.titleSmall,
      );

  static ChipThemeData _chipTheme(ColorScheme colors) => ChipThemeData(
    backgroundColor: colors.surfaceContainerHighest,
    disabledColor: colors.surfaceContainerLow,
    selectedColor: colors.primaryContainer,
    secondarySelectedColor: colors.secondaryContainer,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    shape: const StadiumBorder(),
    labelStyle: AppTextStyles.labelMedium,
  );

  static DividerThemeData get _dividerTheme => const DividerThemeData(
    color: Colors.transparent, // "No-Line" Rule
    thickness: 0,
    space: 1,
  );
}

@immutable
class AppSurfaceColors extends ThemeExtension<AppSurfaceColors> {
  final Color lowest;
  final Color low;
  final Color medium;
  final Color high;
  final Color highest;

  const AppSurfaceColors({
    required this.lowest,
    required this.low,
    required this.medium,
    required this.high,
    required this.highest,
  });

  @override
  AppSurfaceColors copyWith({
    Color? lowest,
    Color? low,
    Color? medium,
    Color? high,
    Color? highest,
  }) {
    return AppSurfaceColors(
      lowest: lowest ?? this.lowest,
      low: low ?? this.low,
      medium: medium ?? this.medium,
      high: high ?? this.high,
      highest: highest ?? this.highest,
    );
  }

  @override
  AppSurfaceColors lerp(ThemeExtension<AppSurfaceColors>? other, double t) {
    if (other is! AppSurfaceColors) return this;
    return AppSurfaceColors(
      lowest: Color.lerp(lowest, other.lowest, t)!,
      low: Color.lerp(low, other.low, t)!,
      medium: Color.lerp(medium, other.medium, t)!,
      high: Color.lerp(high, other.high, t)!,
      highest: Color.lerp(highest, other.highest, t)!,
    );
  }
}
