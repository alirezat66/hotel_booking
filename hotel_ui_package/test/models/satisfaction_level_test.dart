import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_ui_package/extensions/score_ext.dart';
import 'package:hotel_ui_package/extensions/score_range_based_mixin.dart';
import 'package:hotel_ui_package/models/satisfaction/satisfaction_level.dart';
import 'package:hotel_ui_package/models/satisfaction/levels/very_satisfied_level.dart';
import 'package:hotel_ui_package/models/satisfaction/levels/satisfied_level.dart';
import 'package:hotel_ui_package/models/satisfaction/levels/neutral_level.dart';
import 'package:hotel_ui_package/models/satisfaction/levels/dissatisfied_level.dart';
import 'package:hotel_ui_package/models/satisfaction/levels/very_dissatisfied_level.dart';
import 'package:hotel_ui_package/theme/rating_badge_theme.dart';

// Custom level for testing purposes
class CustomLevel extends SatisfactionLevel with ScoreRangeBasedLevel {
  CustomLevel() : super(icon: Icons.star, text: 'Custom');

  @override
  Color getColor(RatingBadgeTheme theme) => Colors.purple;
}

void main() {
  final ratingBadgeTheme = const RatingBadgeTheme(
    verySatisfiedColor: Colors.blue,
    satisfiedColor: Colors.green,
    neutralColor: Colors.yellow,
    dissatisfiedColor: Colors.orange,
    veryDissatisfiedColor: Colors.red,
  );

  group('SatisfactionLevel', () {
    // Your existing tests here...

    // Reset predefined levels between tests to avoid test interdependencies
    setUp(() {
      // Reset to default levels before each test
      SatisfactionLevel.setLevels([
        VeryDissatisfiedLevel(),
        DissatisfiedLevel(),
        NeutralLevel(),
        SatisfiedLevel(),
        VerySatisfiedLevel(),
      ]);
    });

    // Additional tests for recalculations and edge cases
    test('Score ranges are correctly calculated for default levels', () {
      // Force recalculation
      SatisfactionLevel.fromScore(2.5);

      final levels = SatisfactionLevel.levels;
      expect(levels.length, 5);

      // Check that levels are in correct order
      expect(levels[0], isA<VeryDissatisfiedLevel>());
      expect(levels[1], isA<DissatisfiedLevel>());
      expect(levels[2], isA<NeutralLevel>());
      expect(levels[3], isA<SatisfiedLevel>());
      expect(levels[4], isA<VerySatisfiedLevel>());

      // Test that the ranges are properly distributed (0-5 range with 5 levels = 1.0 per level)
      if (levels[0] is ScoreRangeBasedLevel) {
        final level = levels[0] as ScoreRangeBasedLevel;
        expect(level.minScore, 0.0);
        expect(level.maxScore, 1.0);
      }

      if (levels[4] is ScoreRangeBasedLevel) {
        final level = levels[4] as ScoreRangeBasedLevel;
        expect(level.minScore, 4.0);
        expect(level.maxScore, 5.0);
      }
    });

    test('Score ranges are recalculated when levels are added or changed', () {
      // Add a custom level
      final customLevel = CustomLevel();
      SatisfactionLevel.addLevel(customLevel);

      final levels = SatisfactionLevel.levels;
      expect(levels.length, 6);

      // Check that ranges are distributed across 6 levels now (step = 5.0/6 ≈ 0.83)
      final step = 5.0 / 6;

      for (int i = 0; i < levels.length; i++) {
        if (levels[i] is ScoreRangeBasedLevel) {
          final level = levels[i] as ScoreRangeBasedLevel;
          expect(level.minScore, closeTo(i * step, 0.001));

          if (i == levels.length - 1) {
            expect(level.maxScore, 5.0);
          } else {
            expect(level.maxScore, closeTo((i + 1) * step, 0.001));
          }
        }
      }
    });

    test('Level ordering is consistent after modifications', () {
      // Mix up the order when setting levels
      SatisfactionLevel.setLevels([
        SatisfiedLevel(),
        VeryDissatisfiedLevel(),
        VerySatisfiedLevel(),
        NeutralLevel(),
        DissatisfiedLevel(),
      ]);

      // Force recalculation
      SatisfactionLevel.fromScore(2.5);

      final levels = SatisfactionLevel.levels;

      // Check that levels are reordered correctly
      expect(levels[0], isA<VeryDissatisfiedLevel>());
      expect(levels[1], isA<DissatisfiedLevel>());
      expect(levels[2], isA<NeutralLevel>());
      expect(levels[3], isA<SatisfiedLevel>());
      expect(levels[4], isA<VerySatisfiedLevel>());
    });

    test('fromScore handles boundary cases correctly', () {
      // Test exact boundaries
      expect(SatisfactionLevel.fromScore(0.0), isA<VeryDissatisfiedLevel>());
      expect(SatisfactionLevel.fromScore(1.0), isA<DissatisfiedLevel>());
      expect(SatisfactionLevel.fromScore(2.0), isA<NeutralLevel>());
      expect(SatisfactionLevel.fromScore(3.0), isA<SatisfiedLevel>());
      expect(SatisfactionLevel.fromScore(4.0), isA<VerySatisfiedLevel>());
      expect(SatisfactionLevel.fromScore(5.0), isA<VerySatisfiedLevel>());

      // Test out of range values
      expect(SatisfactionLevel.fromScore(-1.0), isA<VeryDissatisfiedLevel>());
      expect(SatisfactionLevel.fromScore(6.0), isA<VerySatisfiedLevel>());
    });

    test('fromScore works with fewer levels', () {
      // Set only 3 levels
      SatisfactionLevel.setLevels([
        VeryDissatisfiedLevel(),
        NeutralLevel(),
        VerySatisfiedLevel(),
      ]);

      // Check that ranges are distributed across 3 levels (step = 5.0/3 ≈ 1.67)
      expect(SatisfactionLevel.fromScore(0.0), isA<VeryDissatisfiedLevel>());
      expect(SatisfactionLevel.fromScore(1.0), isA<VeryDissatisfiedLevel>());
      expect(SatisfactionLevel.fromScore(1.7), isA<NeutralLevel>());
      expect(SatisfactionLevel.fromScore(3.4), isA<VerySatisfiedLevel>());
      expect(SatisfactionLevel.fromScore(5.0), isA<VerySatisfiedLevel>());
    });
  });

  group('ScoreRangeBasedMixin', () {
    test('updateScoreRange correctly updates min and max values', () {
      final level = CustomLevel();

      level.updateScoreRange(1.5, 3.5);

      expect(level.minScore, 1.5);
      expect(level.maxScore, 3.5);
    });

    test('isInRange correctly evaluates scores', () {
      final level = CustomLevel();
      level.updateScoreRange(1.5, 3.5);

      expect(level.isInRange(1.0), false);
      expect(level.isInRange(1.5), true); // Min boundary
      expect(level.isInRange(2.5), true);
      expect(level.isInRange(3.4999), true);
      expect(level.isInRange(3.5), false); // Max boundary
      expect(level.isInRange(4.0), false);
    });
  });

  group('ScoreExtension', () {
    test('satisfactionLevel returns correct level', () {
      final score = 3.5;
      expect(score.satisfactionLevel, isA<SatisfiedLevel>());
    });

    test('face returns correct icon', () {
      expect(4.5.face, Icons.sentiment_very_satisfied);
      expect(3.5.face, Icons.sentiment_satisfied);
      expect(2.5.face, Icons.sentiment_neutral);
      expect(1.5.face, Icons.sentiment_dissatisfied);
      expect(0.5.face, Icons.sentiment_very_dissatisfied);
    });

    test('satisfactionColor returns correct color', () {
      expect(4.5.satisfactionColor(ratingBadgeTheme), Colors.blue);
      expect(3.5.satisfactionColor(ratingBadgeTheme), Colors.green);
      expect(2.5.satisfactionColor(ratingBadgeTheme), Colors.yellow);
      expect(1.5.satisfactionColor(ratingBadgeTheme), Colors.orange);
      expect(0.5.satisfactionColor(ratingBadgeTheme), Colors.red);
    });

    test('scoreText returns correct text', () {
      expect(4.5.scoreText, 'Sehr gut');
      expect(3.5.scoreText, 'Gut');
      expect(2.5.scoreText, 'Befriedigend');
      expect(1.5.scoreText, 'Ausreichend');
      expect(0.5.scoreText, 'Mangelhaft');
    });
  });
}
