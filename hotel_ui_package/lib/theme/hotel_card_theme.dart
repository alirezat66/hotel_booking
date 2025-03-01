import 'package:flutter/material.dart';

@immutable
class HotelCardTheme extends ThemeExtension<HotelCardTheme> {
  final Color titleTextColor;
  final Color subtitleTextColor;
  final Color favoriteIconSelectedColor;
  final Color favoriteIconDeselectedColor;
  const HotelCardTheme({
    required this.titleTextColor,
    required this.subtitleTextColor,
    required this.favoriteIconDeselectedColor,
    required this.favoriteIconSelectedColor,
  });

  @override
  HotelCardTheme copyWith({
    Color? titleTextColor,
    Color? subTitleTextColor,
  }) {
    return HotelCardTheme(
      titleTextColor: titleTextColor ?? this.titleTextColor,
      subtitleTextColor: subTitleTextColor ?? this.subtitleTextColor,
      favoriteIconDeselectedColor: favoriteIconDeselectedColor,
      favoriteIconSelectedColor: favoriteIconSelectedColor,
    );
  }

  @override
  HotelCardTheme lerp(ThemeExtension<HotelCardTheme>? other, double t) {
    if (other is! HotelCardTheme) return this;
    return HotelCardTheme(
      titleTextColor: Color.lerp(titleTextColor, other.titleTextColor, t)!,
      subtitleTextColor:
          Color.lerp(subtitleTextColor, other.subtitleTextColor, t)!,
      favoriteIconSelectedColor: Color.lerp(
          favoriteIconSelectedColor, other.favoriteIconSelectedColor, t)!,
      favoriteIconDeselectedColor: Color.lerp(
          favoriteIconDeselectedColor, other.favoriteIconDeselectedColor, t)!,
    );
  }
}
