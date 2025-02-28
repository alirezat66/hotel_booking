import 'package:hotel_ui_package/models/satisfaction/satisfaction_level.dart';

mixin ScoreRangeBasedLevel on SatisfactionLevel {
  double minScore = 0.0;
  double maxScore = 5.0;

  void updateScoreRange(double min, double max) {
    minScore = min;
    maxScore = max;
  }

  double getMidpoint() {
    return (minScore + maxScore) / 2;
  }

  @override
  bool isInRange(double score) => score >= minScore && score < maxScore;
}
