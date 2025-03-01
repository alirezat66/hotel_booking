import 'package:flutter/material.dart';
import 'package:hotel_ui_package/extensions/theme_ext.dart';

class RatingDescription extends StatelessWidget {
  final String scoreText;
  final int reviewCount;
  const RatingDescription(
      {super.key, required this.scoreText, required this.reviewCount});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$scoreText ($reviewCount Bew)',
      style: context.bodySmall.copyWith(
        color: context.onSurface,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
