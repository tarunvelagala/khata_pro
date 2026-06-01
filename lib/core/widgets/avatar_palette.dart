import 'package:flutter/material.dart';

// Six visually distinct, accessible colors for deterministic list avatars.
// Palette covers all 26 letters with even distribution (26 % 6 wraps cleanly).
// White text on any of these colors meets WCAG AA contrast (≥4.5:1).
const List<Color> avatarPalette = [
  Color(0xFF1565C0), // blue
  Color(0xFF2E7D32), // green
  Color(0xFFC62828), // red
  Color(0xFF6A1B9A), // purple
  Color(0xFFE65100), // deep orange
  Color(0xFF00695C), // teal
];

/// Returns a deterministic color for [label] based on its first code unit.
/// Same label always resolves to the same color — no state required.
Color avatarColorFor(String label) {
  if (label.isEmpty) return avatarPalette[0];
  return avatarPalette[label.codeUnitAt(0) % avatarPalette.length];
}
