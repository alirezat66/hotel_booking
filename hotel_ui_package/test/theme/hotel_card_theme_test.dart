import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_ui_package/theme/hotel_card_theme.dart';

void main() {
  test('HotelCardTheme copyWith method', () {
    const theme = HotelCardTheme(
      titleTextColor: Colors.black,
      subtitleTextColor: Colors.grey,
      favoriteIconDeselectedColor: Colors.white,
      favoriteIconSelectedColor: Colors.red,
      cardDecoration: BoxDecoration(color: Colors.blue),
    );
    final copiedText = theme.copyWith();
    expect(copiedText.titleTextColor, Colors.black);

    final newTheme = theme.copyWith(
      titleTextColor: Colors.green,
    );

    expect(newTheme.titleTextColor, Colors.green);
    expect(newTheme.subtitleTextColor, theme.subtitleTextColor);
    expect(newTheme.favoriteIconDeselectedColor,
        theme.favoriteIconDeselectedColor);
    expect(newTheme.favoriteIconSelectedColor, theme.favoriteIconSelectedColor);
    expect(newTheme.cardDecoration, theme.cardDecoration);
  });

  test('HotelCardTheme lerp method', () {
    const theme1 = HotelCardTheme(
      titleTextColor: Colors.black,
      subtitleTextColor: Colors.grey,
      favoriteIconDeselectedColor: Colors.white,
      favoriteIconSelectedColor: Colors.red,
      cardDecoration: BoxDecoration(color: Colors.blue),
    );

    const theme2 = HotelCardTheme(
      titleTextColor: Colors.green,
      subtitleTextColor: Colors.yellow,
      favoriteIconDeselectedColor: Colors.brown,
      favoriteIconSelectedColor: Colors.purple,
      cardDecoration: BoxDecoration(color: Colors.orange),
    );

    final lerpedTheme = theme1.lerp(theme2, 0.5);

    expect(lerpedTheme.titleTextColor,
        Color.lerp(Colors.black, Colors.green, 0.5));
    expect(lerpedTheme.subtitleTextColor,
        Color.lerp(Colors.grey, Colors.yellow, 0.5));
    expect(lerpedTheme.favoriteIconDeselectedColor,
        Color.lerp(Colors.white, Colors.brown, 0.5));
    expect(lerpedTheme.favoriteIconSelectedColor,
        Color.lerp(Colors.red, Colors.purple, 0.5));
    expect(
        lerpedTheme.cardDecoration,
        BoxDecoration.lerp(const BoxDecoration(color: Colors.blue),
            const BoxDecoration(color: Colors.orange), 0.5));
  });
}
