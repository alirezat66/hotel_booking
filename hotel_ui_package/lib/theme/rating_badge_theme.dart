import 'package:flutter/material.dart';

@immutable
class RatingBadgeTheme extends ThemeExtension<RatingBadgeTheme> {
  final Color verySatisfiedColor;
  final Color satisfiedColor;
  final Color neutralColor;
  final Color dissatisfiedColor;
  final Color veryDissatisfiedColor;

  const RatingBadgeTheme({
    required this.verySatisfiedColor,
    required this.satisfiedColor,
    required this.neutralColor,
    required this.dissatisfiedColor,
    required this.veryDissatisfiedColor,
  });

  @override
  RatingBadgeTheme copyWith({
    Color? verySatisfiedColor,
    Color? satisfiedColor,
    Color? neutralColor,
    Color? dissatisfiedColor,
    Color? veryDissatisfiedColor,
  }) {
    return RatingBadgeTheme(
      verySatisfiedColor: verySatisfiedColor ?? this.verySatisfiedColor,
      satisfiedColor: satisfiedColor ?? this.satisfiedColor,
      neutralColor: neutralColor ?? this.neutralColor,
      dissatisfiedColor: dissatisfiedColor ?? this.dissatisfiedColor,
      veryDissatisfiedColor:
          veryDissatisfiedColor ?? this.veryDissatisfiedColor,
    );
  }

  @override
  RatingBadgeTheme lerp(ThemeExtension<RatingBadgeTheme>? other, double t) {
    if (other is! RatingBadgeTheme) return this;
    return RatingBadgeTheme(
      verySatisfiedColor:
          Color.lerp(verySatisfiedColor, other.verySatisfiedColor, t)!,
      satisfiedColor: Color.lerp(satisfiedColor, other.satisfiedColor, t)!,
      neutralColor: Color.lerp(neutralColor, other.neutralColor, t)!,
      dissatisfiedColor:
          Color.lerp(dissatisfiedColor, other.dissatisfiedColor, t)!,
      veryDissatisfiedColor:
          Color.lerp(veryDissatisfiedColor, other.veryDissatisfiedColor, t)!,
    );
  }
}
