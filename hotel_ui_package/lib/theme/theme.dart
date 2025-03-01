import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_ui_package/theme/hotel_card_theme.dart';
import 'package:hotel_ui_package/theme/rating_badge_theme.dart';

class HotelBookingTheme {
  static const lightSurface = Color(0xFF002873);
  static const lightScaffold = Colors.white;
  static const foregroundColor = Colors.white;
  static const dividerColor = Color(0xFFE9E9E9);
  static const lightPrimary = Color(0xFFFF8f16);
  static const lightSecondary = Color(0xFF85BC39);
  static const lightTertiary = Colors.black;
  static const iconColor = Color(0xFF595959);

  static ThemeData get lightTheme => ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: lightScaffold,
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: lightPrimary,
            onPrimary: foregroundColor,
            secondary: lightSecondary,
            onSecondary: foregroundColor,
            error: Colors.redAccent,
            onError: foregroundColor,
            surface: lightSurface,
            onSurface: foregroundColor,
            tertiary: lightTertiary,
          ),
          textTheme: _getTextTheme(),
          elevatedButtonTheme: getElevatedButtonTheme(),
          dividerTheme: _getDividerTheme(),
          iconTheme: _getIconTheme(),
          cardTheme: _getCardTheme(),
          visualDensity: VisualDensity.compact,
          extensions: [
            _getRatingBadgeTheme(),
            _getHotelCartTheme(),
          ]);

  static ElevatedButtonThemeData getElevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: lightPrimary,
        foregroundColor: Colors.white,
        disabledBackgroundColor: Colors.grey,
        disabledForegroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        textStyle: GoogleFonts.openSans(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
        ),
      ),
    );
  }

  static TextTheme _getTextTheme() {
    return TextTheme(
      displayLarge: GoogleFonts.openSans(
        fontSize: 57, // H1
        fontWeight: FontWeight.bold,
        letterSpacing: -0.25,
      ),
      displayMedium: GoogleFonts.openSans(
        fontSize: 45, // H2
        fontWeight: FontWeight.w600,
      ),
      displaySmall: GoogleFonts.openSans(
        fontSize: 36, // H3
        fontWeight: FontWeight.w500,
      ),
      headlineLarge: GoogleFonts.openSans(
        fontSize: 32, // H4
        fontWeight: FontWeight.w500,
      ),
      headlineMedium: GoogleFonts.openSans(
        fontSize: 28, // H5
        fontWeight: FontWeight.w500,
      ),
      headlineSmall: GoogleFonts.openSans(
        fontSize: 24, // H6
        fontWeight: FontWeight.w500,
      ),
      titleLarge: GoogleFonts.openSans(
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ),
      titleSmall: GoogleFonts.openSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      bodyLarge: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),
      bodyMedium: GoogleFonts.openSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      bodySmall: GoogleFonts.openSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
      labelLarge: GoogleFonts.openSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      labelMedium: GoogleFonts.openSans(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
      labelSmall: GoogleFonts.openSans(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
    );
  }

  static _getDividerTheme() {
    return const DividerThemeData(
      color: dividerColor,
      space: 0,
      thickness: 1,
    );
  }

  static _getIconTheme() {
    return const IconThemeData(
      color: iconColor,
      size: 24,
    );
  }

  static RatingBadgeTheme _getRatingBadgeTheme() {
    return const RatingBadgeTheme(
      verySatisfiedColor: Colors.green,
      satisfiedColor: Color(0xFF85BC39),
      neutralColor: Colors.yellow,
      dissatisfiedColor: Colors.orange,
      veryDissatisfiedColor: Colors.red,
    );
  }

  static HotelCardTheme _getHotelCartTheme() {
    return HotelCardTheme(
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
      ),
    );
  }

  static CardTheme _getCardTheme() {
    return CardTheme(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
