import 'package:flutter/material.dart';

import '../../core/constants/app_dimensions.dart';
import '../../core/widgets/avatar_palette.dart';

/// Size variants for [KpAvatar].
enum KpAvatarSize {
  /// 24dp radius — compact contexts (inline chips, small tiles).
  small,

  /// 22dp radius — standard list tile size.
  medium,

  /// 32dp radius — hero band / customer detail header.
  large,
}

/// Circular avatar displaying a single initial letter on a deterministic
/// palette background.  Color is stable across rebuilds — same label always
/// maps to the same color via [avatarColorFor].
class KpAvatar extends StatelessWidget {
  const KpAvatar({
    super.key,
    required this.label,
    this.size = KpAvatarSize.medium,
  });

  /// Named constructor matching the standard list tile size.
  const KpAvatar.listTile({super.key, required this.label})
      : size = KpAvatarSize.medium;

  /// Named constructor for hero band / large displays.
  const KpAvatar.hero({super.key, required this.label})
      : size = KpAvatarSize.large;

  /// Named constructor for compact contexts.
  const KpAvatar.small({super.key, required this.label})
      : size = KpAvatarSize.small;

  final String label;
  final KpAvatarSize size;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final initial   = label.isNotEmpty ? label[0].toUpperCase() : '?';

    final double radius;
    final double fontSize;

    switch (size) {
      case KpAvatarSize.small:
        radius   = AppDimensions.avatarRadiusMedium - 6.0;
        fontSize = AppDimensions.avatarFontMedium   - 4.0;
      case KpAvatarSize.medium:
        radius   = AppDimensions.avatarRadiusMedium;
        fontSize = AppDimensions.avatarFontMedium;
      case KpAvatarSize.large:
        radius   = AppDimensions.avatarRadiusLarge;
        fontSize = AppDimensions.avatarFontLarge;
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: avatarColorFor(initial),
      child: Text(
        initial,
        style: textTheme.titleSmall?.copyWith(
          fontSize: fontSize,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
