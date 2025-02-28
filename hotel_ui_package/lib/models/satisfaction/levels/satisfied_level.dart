import 'package:flutter/material.dart';
import 'package:hotel_ui_package/extensions/score_range_based_mixin.dart';
import 'package:hotel_ui_package/theme/rating_badge_theme.dart';
import '../satisfaction_level.dart';

class SatisfiedLevel extends SatisfactionLevel with ScoreRangeBasedLevel {
  SatisfiedLevel()
      : super(
          icon: Icons.sentiment_satisfied,
        );

  @override
  Color getColor(RatingBadgeTheme theme) => theme.satisfiedColor;
}
