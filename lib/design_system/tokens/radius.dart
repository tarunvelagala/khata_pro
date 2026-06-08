import '../../core/constants/app_dimensions.dart';

/// Named radius aliases over AppDimensions tokens.
///
/// Use semantic names in widget code — they communicate the surface role
/// rather than just the pixel size.
abstract final class KpRadius {
  /// Text input fields — minimal GPay-style corners.
  static const double input   = AppDimensions.radiusInput;   //  6

  /// Cards, buttons, standard containers.
  static const double small   = AppDimensions.radiusSmall;   // 12

  /// Icon containers, larger surface elements.
  static const double medium  = AppDimensions.radiusMedium;  // 16

  /// Nav bar top corners and bottom sheet handles.
  static const double large   = AppDimensions.radiusLarge;   // 24

  /// Prominent float-over cards (dashboard balance card).
  static const double xLarge  = AppDimensions.radiusXLarge;  // 20

  /// Badges, chips, pill-shaped elements.
  static const double pill    = AppDimensions.radiusPill;    // 999
}
