import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hotel_ui_package/view/hotel_card/widgets/rate/rating_badge.dart';
import 'package:hotel_ui_package/view/hotel_card/widgets/rate/rating_description.dart';

class RateWidget extends StatelessWidget {
  final double score;
  final int reviewCount;
  final String scoreDescription;
  const RateWidget({
    super.key,
    required this.score,
    required this.reviewCount,
    required this.scoreDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingBadge(score: score),
        const Gap(8),
        RatingDescription(scoreText: scoreDescription, reviewCount: reviewCount)
      ],
    );
  }
}
