import '../../core/constants/app_dimensions.dart';

/// Named elevation aliases over AppDimensions tokens.
abstract final class KpElevation {
  /// Flat — cards, buttons, app bar.
  static const double flat   = AppDimensions.elevationFlat;   // 0

  /// Lifted — nav bar and bottom sheets that sit above page content.
  static const double lifted = AppDimensions.elevationLifted; // 4
}
