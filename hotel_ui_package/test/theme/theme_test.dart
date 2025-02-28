import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_ui_package/theme/theme.dart';
import 'package:hotel_ui_package/theme/rating_badge_theme.dart';
import 'package:hotel_ui_package/theme/hotel_cart_theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() => GoogleFonts.config.allowRuntimeFetching = false);


  group('HotelBookingTheme', () {
    test('lightTheme has correct color scheme', () {
      final theme = HotelBookingTheme.lightTheme;
      final colorScheme = theme.colorScheme;

      expect(colorScheme.brightness, Brightness.light);
      expect(colorScheme.primary, HotelBookingTheme.lightPrimary);
      expect(colorScheme.onPrimary, HotelBookingTheme.foregroundColor);
      expect(colorScheme.secondary, HotelBookingTheme.lightSecondary);
      expect(colorScheme.onSecondary, HotelBookingTheme.foregroundColor);
      expect(colorScheme.error, Colors.redAccent);
      expect(colorScheme.onError, HotelBookingTheme.foregroundColor);
      expect(colorScheme.surface, HotelBookingTheme.lightSurface);
      expect(colorScheme.onSurface, HotelBookingTheme.foregroundColor);
    });

    test('lightTheme has correct text theme', () {
      final textTheme = HotelBookingTheme.lightTheme.textTheme;

      expect(textTheme.displayLarge?.fontSize, 57);
      expect(textTheme.displayMedium?.fontSize, 45);
      expect(textTheme.displaySmall?.fontSize, 36);
      expect(textTheme.headlineLarge?.fontSize, 32);
      expect(textTheme.headlineMedium?.fontSize, 28);
      expect(textTheme.headlineSmall?.fontSize, 24);
      expect(textTheme.titleLarge?.fontSize, 22);
      expect(textTheme.titleMedium?.fontSize, 16);
      expect(textTheme.titleSmall?.fontSize, 14);
      expect(textTheme.bodyLarge?.fontSize, 16);
      expect(textTheme.bodyMedium?.fontSize, 14);
      expect(textTheme.bodySmall?.fontSize, 12);
      expect(textTheme.labelLarge?.fontSize, 14);
      expect(textTheme.labelMedium?.fontSize, 12);
      expect(textTheme.labelSmall?.fontSize, 11);
    });

    test('lightTheme has correct elevated button theme', () {
      final elevatedButtonTheme =
          HotelBookingTheme.lightTheme.elevatedButtonTheme.style;

      expect(elevatedButtonTheme?.backgroundColor?.resolve({}),
          HotelBookingTheme.lightPrimary);
      expect(elevatedButtonTheme?.foregroundColor?.resolve({}),
          HotelBookingTheme.foregroundColor);
      expect(elevatedButtonTheme?.padding?.resolve({}),
          const EdgeInsets.symmetric(horizontal: 10, vertical: 20));
      expect(elevatedButtonTheme?.textStyle?.resolve({})?.fontSize, 14);
      expect(elevatedButtonTheme?.textStyle?.resolve({})?.fontWeight,
          FontWeight.w700);
    });

    test('lightTheme has correct divider theme', () {
      final dividerTheme = HotelBookingTheme.lightTheme.dividerTheme;

      expect(dividerTheme.color, HotelBookingTheme.dividerColor);
      expect(dividerTheme.space, 0);
      expect(dividerTheme.thickness, 1);
    });

    test('lightTheme has correct rating badge theme', () {
      final theme = HotelBookingTheme.lightTheme;
      final ratingBadgeTheme = theme.extension<RatingBadgeTheme>()!;

      expect(ratingBadgeTheme.verySatisfiedColor, Colors.green);
      expect(ratingBadgeTheme.satisfiedColor, const Color(0xFF85BC39));
      expect(ratingBadgeTheme.neutralColor, Colors.yellow);
      expect(ratingBadgeTheme.dissatisfiedColor, Colors.orange);
      expect(ratingBadgeTheme.veryDissatisfiedColor, Colors.red);
    });
  });

  test('HotelCartTheme properties are correct', () {
    final ThemeData theme = HotelBookingTheme.lightTheme;
    final HotelCartTheme hotelCartTheme = theme.extension<HotelCartTheme>()!;

    expect(hotelCartTheme.titleTextColor, const Color(0xFF222222));
    expect(hotelCartTheme.subtitleTextColor, const Color(0xFF595959));
  });
}
