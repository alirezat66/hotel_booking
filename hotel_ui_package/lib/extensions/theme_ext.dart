import 'package:flutter/material.dart';
import 'package:hotel_ui_package/theme/hotel_card_theme.dart';
import 'package:hotel_ui_package/theme/rating_badge_theme.dart';

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => theme.colorScheme;

  Color get primaryColor => theme.colorScheme.primary;
  Color get surface => theme.colorScheme.surface;
  Color get onSurface => theme.colorScheme.onSurface;
  TextTheme get textTheme => theme.textTheme;

  TextStyle get displayLarge => theme.textTheme.displayLarge!;
  TextStyle get displayMedium => theme.textTheme.displayMedium!;
  TextStyle get displaySmall => theme.textTheme.displaySmall!;

  TextStyle get headlineLarge => theme.textTheme.headlineLarge!;
  TextStyle get headlineMedium => theme.textTheme.headlineMedium!;
  TextStyle get headlineSmall => theme.textTheme.headlineSmall!;

  TextStyle get bodyLarge => theme.textTheme.bodyLarge!;
  TextStyle get bodyMedium => theme.textTheme.bodyMedium!;
  TextStyle get bodySmall => theme.textTheme.bodySmall!;

  TextStyle get titleLarge => theme.textTheme.titleLarge!;
  TextStyle get titleMedium => theme.textTheme.titleMedium!;
  TextStyle get titleSmall => theme.textTheme.titleSmall!;

  TextStyle get labelLarge => theme.textTheme.labelLarge!;
  TextStyle get labelMedium => theme.textTheme.labelMedium!;
  TextStyle get labelSmall => theme.textTheme.labelSmall!;

  RatingBadgeTheme get ratingBadgeTheme =>
      theme.extension<RatingBadgeTheme>() ??
      const RatingBadgeTheme(
        verySatisfiedColor: Colors.green,
        satisfiedColor: Color(0xFF85BC39),
        neutralColor: Colors.yellow,
        dissatisfiedColor: Colors.orange,
        veryDissatisfiedColor: Colors.red,
      );
  HotelCardTheme get hotelCardTheme =>
      theme.extension<HotelCardTheme>() ??
      HotelCardTheme(
          titleTextColor: const Color(0xFF222222),
          subtitleTextColor: const Color(0xFF595959),
          favoriteIconDeselectedColor: Colors.white,
          favoriteIconSelectedColor: Colors.redAccent,
          cardDecoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // #000000 opacity 10%
                offset: const Offset(0, 8), // X: 0, Y: 8
                blurRadius: 24,
                spreadRadius: 0,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.08), // #000000 opacity 8%
                offset: const Offset(0, 0), // X: 0, Y: 0
                blurRadius: 24,
                spreadRadius: 0,
              ),
            ],
          ));
}
