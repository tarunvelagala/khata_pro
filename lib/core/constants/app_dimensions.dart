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
  /// Gap between a static field label (Text above) and its input widget.
  static const double labelFieldGap = 6;

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

  /// Extra bottom padding on the hero band so the content below doesn't
  /// feel flush against the edge.
  static const double heroContentPaddingBottom = 20;

  // ── Transaction two-column layout ────────────────────────────────
  /// Fixed width of each debit/credit column in transaction list rows.
  static const double txnColWidth = 88.0;

  // ── FAB clearance ─────────────────────────────────────────────────
  /// Bottom scroll padding that keeps list content clear of the FAB.
  /// FAB diameter (56) + bottom safe area allowance + breathing room.
  static const double fabClearance = 96;

  // ── Empty / error states ──────────────────────────────────────────
  /// Large icon in full-screen empty states (e.g. no customers, no entries).
  static const double emptyIconSize = 64.0;

  /// Medium icon in inline empty/error states (search-no-results, error view).
  static const double errorIconSize = 48.0;

  /// Vertical gap between icon and error/retry button in error views.
  static const double errorIconGap = 16.0;

  // ── Segmented button ──────────────────────────────────────────────
  /// Horizontal padding inside each segment — keeps label text away from edges
  /// and matches the overall input padding rhythm.
  static const double segmentPaddingH = 16.0;

  /// Vertical padding inside each segment.
  static const double segmentPaddingV = 10.0;

  // ── Pill toggle ───────────────────────────────────────────────────
  /// Fixed height of the binary PillToggle widget. Matches standard
  /// input / button height so it sits flush in a form column.
  static const double pillToggleHeight = 48.0;

  // ── Ink feedback ─────────────────────────────────────────────────
  /// Alpha for ripple splash on tonal surfaces (e.g. selection cards).
  static const double splashAlpha = 0.08;

  /// Alpha for pressed highlight on tonal surfaces.
  static const double highlightAlpha = 0.04;

  // ── Typography detail ─────────────────────────────────────────────
  /// Letter spacing for ALL-CAPS badge / pill labels.
  static const double letterSpacingCaps = 1.0;

  /// Letter spacing for small property labels beneath icons.
  static const double letterSpacingLabel = 0.8;

  // ── Icon sizes ────────────────────────────────────────────────────
  /// Small contextual icons: trailing more-vert, search prefix, clear button.
  static const double iconSizeSmall  = 20.0;

  /// Standard action icons inside icon buttons and list tiles.
  static const double iconSizeMedium = 24.0;

  // ── Button loading indicator ──────────────────────────────────────
  /// Square dimension of the CircularProgressIndicator inside a FilledButton.
  static const double buttonSpinnerSize   = 20.0;

  /// Stroke width of the in-button spinner.
  static const double buttonSpinnerStroke = 2.0;

  // ── Avatar ────────────────────────────────────────────────────────
  /// Radius of large avatars (customer detail hero band).
  static const double avatarRadiusLarge  = 32.0;

  /// Radius of medium avatars (customer list tiles).
  static const double avatarRadiusMedium = 22.0;

  /// Font size for the initial letter inside a large avatar.
  static const double avatarFontLarge  = 22.0;

  /// Font size for the initial letter inside a medium avatar.
  static const double avatarFontMedium = 16.0;

  // ── Bottom sheet drag handle ──────────────────────────────────────
  static const double dragHandleWidth     = 32.0;
  static const double dragHandleThickness = 4.0;

  // ── Catalog image strip (profile + attach-image sheet) ───────────
  /// Height of catalog image thumbnails in the horizontal strip.
  static const double catalogThumbHeight = 80.0;

  /// Width of each catalog image thumbnail.
  static const double catalogThumbWidth = 116.0;

  /// Corner radius on catalog image thumbnails and the add-photo tile.
  static const double catalogThumbRadius = 12.0;

  /// Width of the "+" add-photo placeholder tile in the strip.
  static const double catalogAddTileWidth = 64.0;

  /// Gap between items in the catalog horizontal strip.
  static const double catalogTileGap = 8.0;

  // ── Attach-image sheet ────────────────────────────────────────────
  /// Height of the image strip row inside the attach-image sheet.
  static const double attachSheetStripHeight = 88.0;

  /// Width of each selectable thumbnail inside the attach-image sheet.
  static const double attachSheetThumbWidth = 120.0;

  /// Gap between thumbnails in the attach-image sheet strip.
  static const double attachSheetThumbGap = 8.0;

  /// Border radius on unselected thumbnails in the attach-image sheet.
  static const double attachSheetThumbRadius = 12.0;

  /// Inner clip radius (= thumbRadius − selectedBorderWidth) so the image
  /// corners align with the selection border on selected tiles.
  static const double attachSheetThumbInnerRadius = 10.0;

  /// Width of the selection highlight border.
  static const double attachSheetSelectedBorder = 2.5;
}
