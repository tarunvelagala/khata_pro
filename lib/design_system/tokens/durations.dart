import '../../core/constants/app_dimensions.dart';

/// Named duration aliases over AppDimensions tokens.
abstract final class KpDurations {
  /// State-change animations: selection, border, background transitions.
  static const Duration short  = AppDimensions.animShort;  // 150ms

  /// Page-level and component-entry animations.
  static const Duration medium = AppDimensions.animMedium; // 300ms

  /// Emphasis animations: counters, chart draws, splash reveals.
  static const Duration long   = AppDimensions.animLong;   // 500ms
}
