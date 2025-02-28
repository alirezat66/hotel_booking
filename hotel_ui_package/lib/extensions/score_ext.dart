import 'package:flutter/material.dart';
import 'package:hotel_ui_package/models/satisfaction/satisfaction_level.dart';
import 'package:hotel_ui_package/theme/rating_badge_theme.dart';

extension ScoreExtension on double {
  SatisfactionLevel get satisfactionLevel => SatisfactionLevel.fromScore(this);
  IconData get face => satisfactionLevel.icon;
  Color satisfactionColor(RatingBadgeTheme theme) =>
      satisfactionLevel.getColor(theme);
}
