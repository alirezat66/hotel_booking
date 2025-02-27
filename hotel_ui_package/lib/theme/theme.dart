import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HotelBookingTheme {
  static const lightSurface = Color(0xFF002873);
  static const lightScaffold = Colors.white;
  static const foregroundColor = Colors.white;
  static const lightPrimary = Color(0xFFFF8f16);
  static const lightSecondary = Color(0xFF85BC39);
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
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
        ),
        textTheme: _getTextTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: lightPrimary,
            foregroundColor: foregroundColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            textStyle: GoogleFonts.openSans(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              letterSpacing: 0,
            ),
          ),
        ),
        visualDensity: VisualDensity.compact,
      );

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
}
