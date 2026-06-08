import 'package:flutter/material.dart';

import '../constants/app_dimensions.dart';
import 'avatar_palette.dart';

/// Circular avatar showing a single initial letter, used in list tiles and
/// the customer detail hero band.
class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    required this.initial,
    required this.radius,
    required this.fontSize,
  });

  final String initial;
  final double radius;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return CircleAvatar(
      radius: radius,
      backgroundColor: avatarColorFor(initial),
      child: Text(
        initial,
        style: tt.titleSmall?.copyWith(
          fontSize: fontSize,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

/// Standard medium avatar sized for list tiles.
class ListTileAvatar extends StatelessWidget {
  const ListTileAvatar({super.key, required this.initial});

  final String initial;

  @override
  Widget build(BuildContext context) => AppAvatar(
        initial: initial,
        radius: AppDimensions.avatarRadiusMedium,
        fontSize: AppDimensions.avatarFontMedium,
      );
}

/// Large avatar sized for the customer detail hero band.
class HeroAvatar extends StatelessWidget {
  const HeroAvatar({super.key, required this.initial});

  final String initial;

  @override
  Widget build(BuildContext context) => AppAvatar(
        initial: initial,
        radius: AppDimensions.avatarRadiusLarge,
        fontSize: AppDimensions.avatarFontLarge,
      );
}
