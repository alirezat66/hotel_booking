import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_ui_package/hotel_card/widgets/rate/rate_widget.dart';
import 'package:hotel_ui_package/theme/rating_badge_theme.dart';
import 'package:hotel_ui_package/theme/theme.dart';

void main() {
  testWidgets('RateWidget displays correct score, text, and review count',
      (WidgetTester tester) async {
    const double score = 4.5;
    const String scoreText = '4.5';
    const int reviewCount = 100;

    await tester.pumpWidget(
      MaterialApp(
        theme: HotelBookingTheme.lightTheme,
        home: const Scaffold(
          body: RateWidget(
              score: score, scoreText: scoreText, reviewCount: reviewCount),
        ),
      ),
    );

    expect(find.text('4.5 / 5.0'), findsOneWidget);
    expect(find.text('4.5 (100 Bew)'), findsOneWidget);
    expect(find.byIcon(Icons.sentiment_very_satisfied), findsOneWidget);
  });

  testWidgets('RateWidget uses correct colors and styles',
      (WidgetTester tester) async {
    const double score = 4.5;
    const String scoreText = '4.5';
    const int reviewCount = 100;

    await tester.pumpWidget(
      MaterialApp(
        theme: HotelBookingTheme.lightTheme,
        home: const Scaffold(
          body: RateWidget(
              score: score, scoreText: scoreText, reviewCount: reviewCount),
        ),
      ),
    );

    final Container ratingBadgeContainer =
        tester.widget<Container>(find.byType(Container).first);
    final BoxDecoration decoration =
        ratingBadgeContainer.decoration as BoxDecoration;

    expect(
        decoration.color,
        HotelBookingTheme.lightTheme
            .extension<RatingBadgeTheme>()!
            .verySatisfiedColor);

    final Text ratingDescriptionText =
        tester.widget<Text>(find.text('4.5 (100 Bew)'));
    final TextStyle textStyle = ratingDescriptionText.style!;

    expect(textStyle.color, HotelBookingTheme.lightTheme.colorScheme.onSurface);
    expect(textStyle.fontWeight, FontWeight.w700);
  });
}
