import 'package:flutter/material.dart';

/// AppTextStyles defines the typography hierarchy for KhataMitra.
/// 
/// Uses system font throughout for maximum performance and compatibility,
/// while maintaining the relative font weights and sizes from the design system.
abstract class AppTextStyles {
  // Display - For large marketing/intro text
  static const TextStyle displayLarge = TextStyle(
    fontSize: 56.0,
    fontWeight: FontWeight.bold,
    letterSpacing: -1.0,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 45.0,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 36.0,
    fontWeight: FontWeight.bold,
  );

  // Headlines - For section headers
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w600,
  );

  // Titles - For subsection headers and navigation
  static const TextStyle titleLarge = TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
  );

  // Body - For regular content
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
  );

  // Labels - For small UI hints and captions
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );
}
