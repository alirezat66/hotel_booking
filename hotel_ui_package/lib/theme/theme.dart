import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_ui_package/theme/hotel_card_theme.dart';
import 'package:hotel_ui_package/theme/rating_badge_theme.dart';

class HotelBookingTheme {
  // Shared constants
  static const lightSurface = Color(0xFF002873);
  static const lightScaffold = Colors.white;
  static const foregroundColor = Colors.white;
  static const dividerColor = Color(0xFFE9E9E9);
  static const lightPrimary = Color(0xFFFF8f16);
  static const lightSecondary = Color(0xFF85BC39);
  static const lightTertiary = Colors.black;
  static const iconColor = Color(0xFF595959);

  // Dark mode constants
  static const darkScaffold = Color(0xFF1A1A1A);
  static const darkSurface = Color(0xFF003087);
  static const darkForeground = Color(0xFFE0E0E0);
  static const darkDividerColor = Color(0xFF424242);
  static const darkIconColor = Color(0xFFB0B0B0);

  static ThemeData get lightTheme => getTheme(brightness: Brightness.light);
  static ThemeData get darkTheme => getTheme(brightness: Brightness.dark);

  // Unified ThemeData getter
  static ThemeData getTheme({required Brightness brightness}) {
    final isDark = brightness == Brightness.dark;
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: isDark ? darkScaffold : lightScaffold,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: lightPrimary,
        onPrimary: foregroundColor,
        secondary: lightSecondary,
        onSecondary: foregroundColor,
        error: Colors.redAccent,
        onError: foregroundColor,
        surface: isDark ? darkSurface : lightSurface,
        onSurface: isDark ? darkForeground : foregroundColor,
        tertiary: isDark ? darkForeground : lightTertiary,
      ),
      textTheme: _getTextTheme(isDark: isDark),
      elevatedButtonTheme: _getElevatedButtonTheme(isDark: isDark),
      dividerTheme: _getDividerTheme(isDark: isDark),
      iconTheme: _getIconTheme(isDark: isDark),
      cardTheme: _getCardTheme(isDark: isDark),
      visualDensity: VisualDensity.compact,
      bottomNavigationBarTheme: _getBottomNavigationBarTheme(isDark: isDark),
      radioTheme: _getRadioTheme(isDark: isDark),
      extensions: [
        _getRatingBadgeTheme(), // Same for both modes
        _getHotelCardTheme(isDark: isDark),
      ],
    );
  }

  // ElevatedButtonTheme
  static ElevatedButtonThemeData _getElevatedButtonTheme(
      {required bool isDark}) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: lightPrimary,
        foregroundColor: Colors.white,
        disabledBackgroundColor: isDark ? Colors.grey[800] : Colors.grey,
        disabledForegroundColor: isDark ? Colors.grey : Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        textStyle: GoogleFonts.openSans(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
          color: isDark ? darkForeground : lightTertiary,
        ),
      ),
    );
  }

  // TextTheme
  static TextTheme _getTextTheme({required bool isDark}) {
    final textColor = isDark ? darkForeground : lightTertiary;
    return TextTheme(
      displayLarge: GoogleFonts.openSans(
          fontSize: 57,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.25,
          color: textColor),
      displayMedium: GoogleFonts.openSans(
          fontSize: 45, fontWeight: FontWeight.w600, color: textColor),
      displaySmall: GoogleFonts.openSans(
          fontSize: 36, fontWeight: FontWeight.w500, color: textColor),
      headlineLarge: GoogleFonts.openSans(
          fontSize: 32, fontWeight: FontWeight.w500, color: textColor),
      headlineMedium: GoogleFonts.openSans(
          fontSize: 28, fontWeight: FontWeight.w500, color: textColor),
      headlineSmall: GoogleFonts.openSans(
          fontSize: 24, fontWeight: FontWeight.w500, color: textColor),
      titleLarge: GoogleFonts.openSans(
          fontSize: 22, fontWeight: FontWeight.w600, color: textColor),
      titleMedium: GoogleFonts.openSans(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          color: textColor),
      titleSmall: GoogleFonts.openSans(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: textColor),
      bodyLarge: GoogleFonts.openSans(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          color: textColor),
      bodyMedium: GoogleFonts.openSans(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          color: textColor),
      bodySmall: GoogleFonts.openSans(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          color: textColor),
      labelLarge: GoogleFonts.openSans(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: textColor),
      labelMedium: GoogleFonts.openSans(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: textColor),
      labelSmall: GoogleFonts.openSans(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: textColor),
    );
  }

  // DividerTheme
  static DividerThemeData _getDividerTheme({required bool isDark}) {
    return DividerThemeData(
      color: isDark ? darkDividerColor : dividerColor,
      space: 0,
      thickness: 1,
    );
  }

  // IconTheme
  static IconThemeData _getIconTheme({required bool isDark}) {
    return IconThemeData(
      color: isDark ? darkIconColor : iconColor,
      size: 24,
    );
  }

  // RatingBadgeTheme (same for both modes)
  static RatingBadgeTheme _getRatingBadgeTheme() {
    return const RatingBadgeTheme(
      verySatisfiedColor: Colors.green,
      satisfiedColor: Color(0xFF85BC39),
      neutralColor: Colors.yellow,
      dissatisfiedColor: Colors.orange,
      veryDissatisfiedColor: Colors.red,
    );
  }

  // HotelCardTheme
  static HotelCardTheme _getHotelCardTheme({required bool isDark}) {
    return HotelCardTheme(
      titleTextColor: isDark ? darkForeground : const Color(0xFF222222),
      subtitleTextColor: isDark ? darkIconColor : const Color(0xFF595959),
      favoriteIconDeselectedColor: isDark ? darkIconColor : Colors.white,
      favoriteIconSelectedColor: Colors.redAccent,
      cardDecoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.1),
            offset: const Offset(0, 8),
            blurRadius: 24,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.15 : 0.08),
            offset: const Offset(0, 0),
            blurRadius: 24,
            spreadRadius: 0,
          ),
        ],
      ),
    );
  }

  // CardTheme
  static CardTheme _getCardTheme({required bool isDark}) {
    return CardTheme(
      color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    );
  }

  // BottomNavigationBarTheme
  static BottomNavigationBarThemeData _getBottomNavigationBarTheme(
      {required bool isDark}) {
    final textColor = isDark ? darkForeground : lightTertiary;
    return BottomNavigationBarThemeData(
      backgroundColor: isDark ? const Color(0xFF2A2A2A) : Colors.white,
      selectedItemColor: lightPrimary,
      unselectedItemColor: textColor,
      selectedLabelStyle: GoogleFonts.openSans(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          color: textColor),
      elevation: 2,
      unselectedLabelStyle: GoogleFonts.openSans(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          color: textColor),
    );
  }

  // RadioTheme
  static RadioThemeData _getRadioTheme({required bool isDark}) {
    return RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled))
          return isDark ? Colors.grey[800] : Colors.grey;
        if (states.contains(WidgetState.selected)) return lightPrimary;
        return isDark ? darkForeground : lightTertiary;
      }),
    );
  }
}
