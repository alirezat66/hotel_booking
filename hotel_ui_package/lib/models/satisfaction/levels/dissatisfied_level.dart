import 'package:flutter/material.dart';
import 'package:hotel_ui_package/extensions/score_range_based_mixin.dart';
import 'package:hotel_ui_package/theme/rating_badge_theme.dart';
import '../satisfaction_level.dart';

class DissatisfiedLevel extends SatisfactionLevel with ScoreRangeBasedLevel {
  DissatisfiedLevel()
      : super(icon: Icons.sentiment_dissatisfied, text: 'Ausreichend');

  @override
  Color getColor(RatingBadgeTheme theme) => theme.dissatisfiedColor;
}
