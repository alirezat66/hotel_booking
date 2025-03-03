import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_ui_package/extensions/theme_ext.dart';
import 'package:hotel_ui_package/theme/theme.dart';

void main() {
  setUpAll(() {
    // Enable runtime fetching for tests
    GoogleFonts.config.allowRuntimeFetching = true;
  });
  TestWidgetsFlutterBinding.ensureInitialized();

  group('BuildContextExt', () {
    testWidgets('extension methods return correct values',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: HotelBookingTheme.getTheme(brightness: Brightness.light),
          home: Builder(
            builder: (context) {
              // Test color scheme
              expect(
                  context.colorScheme.primary, HotelBookingTheme.lightPrimary);
              expect(
                  context.colorScheme.surface, HotelBookingTheme.lightSurface);
              expect(context.colorScheme.onSurface,
                  HotelBookingTheme.foregroundColor);

              // Test primary color
              expect(context.primaryColor, HotelBookingTheme.lightPrimary);

              // Test surface color
              expect(context.surface, HotelBookingTheme.lightSurface);

              // Test individual text styles
              expect(context.displayLarge.fontSize, 57);
              expect(context.displayMedium.fontSize, 45);
              expect(context.displaySmall.fontSize, 36);
              expect(context.headlineLarge.fontSize, 32);
              expect(context.headlineMedium.fontSize, 28);
              expect(context.headlineSmall.fontSize, 24);
              expect(context.titleLarge.fontSize, 22);
              expect(context.titleMedium.fontSize, 16);
              expect(context.titleSmall.fontSize, 14);
              expect(context.bodyLarge.fontSize, 16);
              expect(context.bodyMedium.fontSize, 14);
              expect(context.bodySmall.fontSize, 12);
              expect(context.labelLarge.fontSize, 14);
              expect(context.labelMedium.fontSize, 12);
              expect(context.labelSmall.fontSize, 11);
              final textTheme = context.textTheme;
              // Test text theme object against the merged theme
              expect(textTheme.bodyLarge?.fontSize, 16);
              return Container();
            },
          ),
        ),
      );
    });

    testWidgets('extension methods return correct icon theme values',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: HotelBookingTheme.getTheme(brightness: Brightness.light),
          home: Builder(
            builder: (context) {
              // Test icon theme
              expect(
                  context.theme.iconTheme.color, HotelBookingTheme.iconColor);
              expect(context.theme.iconTheme.size, 24.0);

              return Container();
            },
          ),
        ),
      );
    });

    testWidgets('ratingBadgeTheme returns correct values',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: HotelBookingTheme.getTheme(brightness: Brightness.light),
          home: Builder(
            builder: (context) {
              final ratingBadgeTheme = context.ratingBadgeTheme;

              expect(ratingBadgeTheme.verySatisfiedColor, Colors.green);
              expect(ratingBadgeTheme.satisfiedColor, const Color(0xFF85BC39));
              expect(ratingBadgeTheme.neutralColor, Colors.yellow);
              expect(ratingBadgeTheme.dissatisfiedColor, Colors.orange);
              expect(ratingBadgeTheme.veryDissatisfiedColor, Colors.red);

              return Container();
            },
          ),
        ),
      );
    });

    testWidgets('hotelCardTheme returns correct values',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: HotelBookingTheme.getTheme(brightness: Brightness.light),
          home: Builder(
            builder: (context) {
              final hotelCardTheme = context.hotelCardTheme;

              expect(hotelCardTheme.titleTextColor, const Color(0xFF222222));
              expect(hotelCardTheme.subtitleTextColor, const Color(0xFF595959));

              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });
  });
}
