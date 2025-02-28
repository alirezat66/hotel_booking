import 'package:flutter/material.dart';
import 'package:hotel_ui_package/extensions/score_range_based_mixin.dart';
import 'package:hotel_ui_package/theme/rating_badge_theme.dart';
import '../satisfaction_level.dart';

class NeutralLevel extends SatisfactionLevel with ScoreRangeBasedLevel {
  NeutralLevel() : super(icon: Icons.sentiment_neutral, text: 'Befriedigend');

  @override
  Color getColor(RatingBadgeTheme theme) => theme.neutralColor;
}
