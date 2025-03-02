import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_ui_package/theme/rating_badge_theme.dart';

void main() {
  test('RatingBadgeTheme copyWith method', () {
    const theme = RatingBadgeTheme(
      verySatisfiedColor: Colors.green,
      satisfiedColor: Colors.lightGreen,
      neutralColor: Colors.yellow,
      dissatisfiedColor: Colors.orange,
      veryDissatisfiedColor: Colors.red,
    );
    final copiedText = theme.copyWith();
    expect(copiedText.verySatisfiedColor, Colors.green);
    final newTheme = theme.copyWith(
      verySatisfiedColor: Colors.blue,
    );

    expect(newTheme.verySatisfiedColor, Colors.blue);
    expect(newTheme.satisfiedColor, theme.satisfiedColor);
    expect(newTheme.neutralColor, theme.neutralColor);
    expect(newTheme.dissatisfiedColor, theme.dissatisfiedColor);
    expect(newTheme.veryDissatisfiedColor, theme.veryDissatisfiedColor);
  });

  test('RatingBadgeTheme lerp method', () {
    const theme1 = RatingBadgeTheme(
      verySatisfiedColor: Colors.green,
      satisfiedColor: Colors.lightGreen,
      neutralColor: Colors.yellow,
      dissatisfiedColor: Colors.orange,
      veryDissatisfiedColor: Colors.red,
    );

    const theme2 = RatingBadgeTheme(
      verySatisfiedColor: Colors.blue,
      satisfiedColor: Colors.cyan,
      neutralColor: Colors.amber,
      dissatisfiedColor: Colors.brown,
      veryDissatisfiedColor: Colors.purple,
    );

    final lerpedTheme = theme1.lerp(theme2, 0.5);

    expect(lerpedTheme.verySatisfiedColor,
        Color.lerp(Colors.green, Colors.blue, 0.5));
    expect(lerpedTheme.satisfiedColor,
        Color.lerp(Colors.lightGreen, Colors.cyan, 0.5));
    expect(
        lerpedTheme.neutralColor, Color.lerp(Colors.yellow, Colors.amber, 0.5));
    expect(lerpedTheme.dissatisfiedColor,
        Color.lerp(Colors.orange, Colors.brown, 0.5));
    expect(lerpedTheme.veryDissatisfiedColor,
        Color.lerp(Colors.red, Colors.purple, 0.5));
  });
}
