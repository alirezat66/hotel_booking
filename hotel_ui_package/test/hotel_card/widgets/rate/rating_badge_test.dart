import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_ui_package/hotel_card/widgets/rate/rating_badge.dart';
import 'package:hotel_ui_package/theme/rating_badge_theme.dart';
import 'package:hotel_ui_package/theme/theme.dart';

void main() {
  testWidgets('RatingBadge displays correct score and icon',
      (WidgetTester tester) async {
    const double score = 4.5;

    await tester.pumpWidget(
      MaterialApp(
        theme: HotelBookingTheme.lightTheme,
        home: const Scaffold(
          body: RatingBadge(score: score),
        ),
      ),
    );

    expect(find.text('4.5 / 5.0'), findsOneWidget);
    expect(find.byIcon(Icons.sentiment_very_satisfied), findsOneWidget);
  });

  testWidgets('RatingBadge uses correct color from theme',
      (WidgetTester tester) async {
    const double score = 4.5;

    await tester.pumpWidget(
      MaterialApp(
        theme: HotelBookingTheme.lightTheme,
        home: const Scaffold(
          body: RatingBadge(score: score),
        ),
      ),
    );

    final Container container =
        tester.widget<Container>(find.byType(Container));
    final BoxDecoration decoration = container.decoration as BoxDecoration;

    expect(
        decoration.color,
        HotelBookingTheme.lightTheme
            .extension<RatingBadgeTheme>()!
            .verySatisfiedColor);
  });

  testWidgets('RatingBadge uses correct text style',
      (WidgetTester tester) async {
    const double score = 4.5;

    await tester.pumpWidget(
      MaterialApp(
        theme: HotelBookingTheme.lightTheme,
        home: const Scaffold(
          body: RatingBadge(score: score),
        ),
      ),
    );

    final Text textWidget = tester.widget<Text>(find.text('4.5 / 5.0'));
    final TextStyle textStyle = textWidget.style!;

    expect(textStyle.color, HotelBookingTheme.lightTheme.colorScheme.onSurface);
    expect(textStyle.fontWeight, FontWeight.w700);
  });
}
