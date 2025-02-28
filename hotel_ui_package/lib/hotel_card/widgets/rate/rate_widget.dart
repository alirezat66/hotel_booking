import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hotel_ui_package/extensions/score_ext.dart';
import 'package:hotel_ui_package/hotel_card/widgets/rate/rating_badge.dart';
import 'package:hotel_ui_package/hotel_card/widgets/rate/rating_description.dart';

class RateWidget extends StatelessWidget {
  final double score;
  final int reviewCount;
  const RateWidget(
      {super.key,
      required this.score,
      required this.reviewCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingBadge(score: score),
        const Gap(8),
        RatingDescription(scoreText: score.scoreText, reviewCount: reviewCount)
      ],
    );
  }
}
