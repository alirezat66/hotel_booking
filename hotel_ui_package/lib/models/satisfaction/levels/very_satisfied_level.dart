import 'package:flutter/material.dart';
import 'package:hotel_ui_package/extensions/score_range_based_mixin.dart';
import 'package:hotel_ui_package/theme/rating_badge_theme.dart';
import '../satisfaction_level.dart';

class VerySatisfiedLevel extends SatisfactionLevel with ScoreRangeBasedLevel {
  VerySatisfiedLevel()
      : super(
          icon: Icons.sentiment_very_satisfied,
        );

  @override
  Color getColor(RatingBadgeTheme theme) => theme.verySatisfiedColor;
}
