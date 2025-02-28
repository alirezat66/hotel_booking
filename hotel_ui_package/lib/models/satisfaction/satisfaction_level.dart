import 'package:flutter/material.dart';
import 'package:hotel_ui_package/extensions/score_range_based_mixin.dart';
import 'package:hotel_ui_package/models/satisfaction/levels/dissatisfied_level.dart';
import 'package:hotel_ui_package/models/satisfaction/levels/neutral_level.dart';
import 'package:hotel_ui_package/models/satisfaction/levels/satisfied_level.dart';
import 'package:hotel_ui_package/models/satisfaction/levels/very_dissatisfied_level.dart';
import 'package:hotel_ui_package/models/satisfaction/levels/very_satisfied_level.dart';
import 'package:hotel_ui_package/theme/rating_badge_theme.dart';

abstract class SatisfactionLevel {
  final IconData icon;
  final String text;

  const SatisfactionLevel({required this.icon, required this.text});

  /// Determines if the score falls within this level's range
  bool isInRange(double score);

  /// Get color from theme
  Color getColor(RatingBadgeTheme theme);

  /// Default predefined levels
  static final List<SatisfactionLevel> _defaultLevels = [
    VeryDissatisfiedLevel(),
    DissatisfiedLevel(),
    NeutralLevel(),
    SatisfiedLevel(),
    VerySatisfiedLevel(),
  ];

  /// The current active predefined levels
  static final List<SatisfactionLevel> _predefinedLevels = [..._defaultLevels];

  /// Flag to track if the class has been initialized
  static bool _initialized = false;

  /// Retrieves the current predefined levels, initializing if necessary
  static List<SatisfactionLevel> get levels {
    _ensureInitialized();
    return List.unmodifiable(_predefinedLevels);
  }

  /// Ensures the class is properly initialized
  static void _ensureInitialized() {
    if (!_initialized) {
      _recalculateScoreRanges();
      _initialized = true;
    }
  }

  /// Reset to default levels
  static void resetToDefaults() {
    _predefinedLevels.clear();
    _predefinedLevels.addAll(_defaultLevels);
    _recalculateScoreRanges();
    _initialized = true;
  }

  /// Dynamically calculated min/max scores
  static void _recalculateScoreRanges() {
    int levelCount = _predefinedLevels.length;
    if (levelCount == 0) return;

    // Sort levels in the intended order
    _predefinedLevels.sort((a, b) {
      final List<Type> orderTypes = [
        VeryDissatisfiedLevel,
        DissatisfiedLevel,
        NeutralLevel,
        SatisfiedLevel,
        VerySatisfiedLevel,
      ];

      int indexA = orderTypes.indexOf(a.runtimeType);
      int indexB = orderTypes.indexOf(b.runtimeType);

      if (indexA == -1) indexA = orderTypes.length;
      if (indexB == -1) indexB = orderTypes.length;

      return indexA.compareTo(indexB);
    });

    double step = 5.0 / levelCount;

    for (int i = 0; i < levelCount; i++) {
      if (_predefinedLevels[i] is ScoreRangeBasedLevel) {
        double minScore = i * step;
        double maxScore = (i == levelCount - 1) ? 5.0 : (i + 1) * step;

        (_predefinedLevels[i] as ScoreRangeBasedLevel)
            .updateScoreRange(minScore, maxScore);
      }
    }
  }

  /// Factory method to determine level from score
  static SatisfactionLevel fromScore(double score) {
    _ensureInitialized();

    for (var level in _predefinedLevels) {
      if (level.isInRange(score)) {
        return level;
      }
    }

    // Fallback to most appropriate level
    if (score <= 0) return _predefinedLevels.first;
    if (score >= 5) return _predefinedLevels.last;

    // Find closest level if none matches exactly
    return _predefinedLevels.reduce((current, next) {
      if (current is ScoreRangeBasedLevel && next is ScoreRangeBasedLevel) {
        double currentMid = (current).getMidpoint();
        double nextMid = (next).getMidpoint();
        return (score - currentMid).abs() < (score - nextMid).abs()
            ? current
            : next;
      }
      return current;
    });
  }

  /// Allows users to **override default levels** (replaces existing levels)
  static void setLevels(List<SatisfactionLevel> levels) {
    _predefinedLevels
      ..clear()
      ..addAll(levels);
    _recalculateScoreRanges();
    _initialized = true;
  }

  /// Allows users to **add additional levels** dynamically
  static void addLevel(SatisfactionLevel level) {
    _predefinedLevels.add(level);
    _recalculateScoreRanges();
    _initialized = true;
  }
}
