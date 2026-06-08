import '../../core/constants/app_dimensions.dart';

/// Named spacing scale on the 4dp baseline grid.
///
/// Prefer semantic aliases over raw scale values in widget code —
/// they communicate intent rather than just magnitude.
abstract final class KpSpacing {
  // ── Raw scale ─────────────────────────────────────────────────────────────
  static const double s2  =  2.0;
  static const double s4  =  4.0;
  static const double s6  =  6.0;
  static const double s8  =  8.0;
  static const double s12 = 12.0;
  static const double s16 = 16.0;
  static const double s20 = 20.0;
  static const double s24 = 24.0;
  static const double s28 = 28.0;
  static const double s32 = 32.0;
  static const double s40 = 40.0;
  static const double s48 = 48.0;
  static const double s56 = 56.0;
  static const double s64 = 64.0;

  // ── Semantic aliases ──────────────────────────────────────────────────────
  static const double inputPaddingH  = AppDimensions.inputPaddingH;   // 16
  static const double inputPaddingV  = AppDimensions.inputPaddingV;   // 20
  static const double buttonPaddingH = AppDimensions.buttonPaddingH;  // 24
  static const double buttonPaddingV = AppDimensions.buttonPaddingV;  // 20
  static const double labelFieldGap  = AppDimensions.labelFieldGap;   //  6
  static const double buttonStackGap = AppDimensions.buttonStackGap;  //  8
  static const double cardPaddingH   = s16;
  static const double cardPaddingV   = s16;
  static const double sectionGap     = s28;
  static const double itemGap        = s12;
  static const double tileGap        = s8;
  static const double fabClearance   = AppDimensions.fabClearance;    // 96
}
