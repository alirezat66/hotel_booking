import 'package:flutter/material.dart';
import 'package:hotel_ui_package/extensions/score_ext.dart';
import 'package:hotel_ui_package/hotel_ui_package.dart';

class RatingBadge extends StatelessWidget {
  final double score;
  const RatingBadge({
    super.key,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: score.satisfactionColor(context.ratingBadgeTheme),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              score.face,
              color: context.onSurface,
              size: 14,
            ),
            Text(
              '${score.toStringAsFixed(1)} / 5.0',
              style: context.titleMedium.copyWith(
                fontWeight: FontWeight.w700,
                color: context.onSurface,
              ),
            )
          ],
        ),
      ),
    );
  }
}
