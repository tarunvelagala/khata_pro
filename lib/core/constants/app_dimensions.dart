/// Shared dimension tokens for KhataPro.
///
/// Use these instead of inline numbers anywhere a layout measurement,
/// border radius, elevation, padding, or stroke width appears.
/// Screen-specific values that have no cross-feature meaning belong in
/// a file-private `_Dims` class inside the relevant screen file.
abstract final class AppDimensions {
  // ── Border radii ──────────────────────────────────────────────────
  /// Cards, buttons, text inputs.
  static const double radiusSmall = 12;

  /// Icon containers, larger surface elements.
  static const double radiusMedium = 16;

  /// Prominent cards that float on a contrasting surface (e.g. white card on
  /// the dark hero band). Larger radius communicates visual separation.
  static const double radiusXLarge = 20;

  /// Nav bar top corners and tour footer — ties the shell together.
  static const double radiusLarge = 24;

  /// Badges, chips, pill-shaped elements.
  static const double radiusPill = 999;

  // ── Elevation ─────────────────────────────────────────────────────
  /// Flat / no shadow — used for cards, buttons, and the app bar.
  static const double elevationFlat = 0;

  /// Lifted surface — nav bar and bottom sheets that sit above page content.
  static const double elevationLifted = 4;

  // ── Button padding ────────────────────────────────────────────────
  /// Vertical padding for ElevatedButton and OutlinedButton.
  static const double buttonPaddingV = 20;

  /// Horizontal padding for ElevatedButton and OutlinedButton.
  static const double buttonPaddingH = 24;

  // ── Input padding ─────────────────────────────────────────────────
  /// Vertical content padding inside InputDecoration.
  static const double inputPaddingV = 20;

  /// Horizontal content padding inside InputDecoration.
  static const double inputPaddingH = 16;

  // ── Border widths ─────────────────────────────────────────────────
  /// Focused input border and selected card border.
  static const double borderFocused = 2;

  /// Default / unfocused border width.
  static const double borderDefault = 1;

  // ── Button stack ─────────────────────────────────────────────────
  /// Gap between a primary FilledButton and a secondary TextButton when stacked.
  static const double buttonStackGap = 8;

  // ── Divider ───────────────────────────────────────────────────────
  static const double dividerThickness = 1;
  static const double dividerSpace = 1;

  // ── Animation durations ───────────────────────────────────────────
  /// State-change animations: selection, border, background transitions.
  static const Duration animShort  = Duration(milliseconds: 150);

  /// Page-level and component-entry animations.
  static const Duration animMedium = Duration(milliseconds: 300);

  /// Emphasis animations: counters, chart draws, splash reveals.
  static const Duration animLong   = Duration(milliseconds: 500);

  // ── Avatar / badge ────────────────────────────────────────────────
  /// Diameter of circular avatars and badge containers in list tiles
  /// and selection cards.
  static const double avatarSize = 40.0;

  // ── App bar ───────────────────────────────────────────────────────
  /// Background colour alpha for the frosted-glass app bar effect.
  static const double appBarOpacity = 0.8;

  // ── Badge ─────────────────────────────────────────────────────────
  /// Alpha for the glass-effect badge background on selection cards.
  static const double badgeGlassAlpha = 0.08;

  // ── Opacity ───────────────────────────────────────────────────────
  /// Alpha for secondary labels inside tonal containers (balance card label, etc.)
  static const double subtleLabelAlpha = 0.72;

  // ── Card shadow ───────────────────────────────────────────────────
  /// Blur radius for the ambient shadow beneath elevated cards.
  static const double shadowBlurCard   = 12;

  /// Y-offset for card shadows — positive pushes shadow downward.
  static const double shadowOffsetCard = 4;

  /// Y-offset for footer shadows — negative pushes shadow upward,
  /// making the footer appear to float above the scroll content.
  static const double shadowOffsetFooter = -4;

  // ── Hero header ───────────────────────────────────────────────────
  /// Vertical padding at the top of the full-bleed hero band, measured
  /// from the status-bar bottom edge to the first visible content.
  static const double heroContentPaddingTop    = 12;

  /// Extra bottom padding on the hero band so that the overlapping
  /// summary card reads as floating on top, not flush against the edge.
  static const double heroContentPaddingBottom = 36;

  /// How far the card immediately below the hero overlaps upward into it.
  /// Must be subtracted from the following section's top padding to keep
  /// total vertical spacing consistent.
  static const double heroCardOverlap = 24;

  // ── FAB clearance ─────────────────────────────────────────────────
  /// Bottom scroll padding that keeps list content clear of the FAB.
  /// FAB diameter (56) + bottom safe area allowance + breathing room.
  static const double fabClearance = 96;
}
