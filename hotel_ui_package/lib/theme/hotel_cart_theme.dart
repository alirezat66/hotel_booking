import 'package:flutter/material.dart';

@immutable
class HotelCartTheme extends ThemeExtension<HotelCartTheme> {
  final Color titleTextColor;
  final Color subtitleTextColor;

  const HotelCartTheme({
    required this.titleTextColor,
    required this.subtitleTextColor,
  });

  @override
  HotelCartTheme copyWith({
    Color? titleTextColor,
    Color? subTitleTextColor,
  }) {
    return HotelCartTheme(
      titleTextColor: titleTextColor ?? this.titleTextColor,
      subtitleTextColor: subTitleTextColor ?? this.subtitleTextColor,
    );
  }

  @override
  HotelCartTheme lerp(ThemeExtension<HotelCartTheme>? other, double t) {
    if (other is! HotelCartTheme) return this;
    return HotelCartTheme(
      titleTextColor: Color.lerp(titleTextColor, other.titleTextColor, t)!,
      subtitleTextColor:
          Color.lerp(subtitleTextColor, other.subtitleTextColor, t)!,
    );
  }
}
