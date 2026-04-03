/// Shared dimension tokens for KhataMitra.
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

  /// Badges, chips, pill-shaped elements.
  static const double radiusPill = 999;

  // ── Elevation ─────────────────────────────────────────────────────
  /// Flat / no shadow — used for cards, buttons, and the app bar.
  static const double elevationFlat = 0;

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

  // ── Divider ───────────────────────────────────────────────────────
  static const double dividerThickness = 1;
  static const double dividerSpace = 1;

  // ── App bar ───────────────────────────────────────────────────────
  /// Background colour alpha for the frosted-glass app bar effect.
  static const double appBarOpacity = 0.8;

  // ── List tile ────────────────────────────────────────────────────
  /// Vertical padding inside [AppListTile].
  static const double listTileVerticalPadding = 12;

  // ── Empty state ──────────────────────────────────────────────────
  /// Outer padding wrapping the [AppEmptyState] column.
  static const double emptyStatePadding = 32;

  /// Illustration size in [AppEmptyState] on mobile.
  static const double emptyStateIllustrationSize = 160;

  /// Illustration size in [AppEmptyState] on tablet.
  static const double emptyStateIllustrationSizeTablet = 184;

  // ── Bottom sheet ─────────────────────────────────────────────────
  /// Top padding inside the default sheet content padding.
  static const double sheetTopPadding = 8;

  /// Bottom padding inside the default sheet content padding.
  static const double sheetBottomPadding = 24;

  /// Vertical padding around the sheet title row.
  static const double sheetTitleVerticalPadding = 8;

  // ── Section header ────────────────────────────────────────────────
  /// Top padding inside [AppSectionHeader].
  static const double sectionHeaderTopPadding = 8;

  /// Bottom padding inside [AppSectionHeader].
  static const double sectionHeaderBottomPadding = 4;

  // ── Icon / label gap ─────────────────────────────────────────────
  /// Horizontal gap between a leading/trailing icon and its label text.
  static const double iconLabelGap = 8;
}
