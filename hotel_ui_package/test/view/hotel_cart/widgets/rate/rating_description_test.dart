import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_ui_package/view/hotel_cart/widgets/rate/rating_description.dart';
import 'package:hotel_ui_package/theme/theme.dart';

void main() {
  testWidgets('RatingDescription displays correct text',
      (WidgetTester tester) async {
    const String scoreText = '4.5';
    const int reviewCount = 100;

    await tester.pumpWidget(
      MaterialApp(
        theme: HotelBookingTheme.lightTheme,
        home: const Scaffold(
          body: RatingDescription(
            scoreText: scoreText,
            reviewCount: reviewCount,
          ),
        ),
      ),
    );

    expect(find.text('$scoreText ($reviewCount Bew)'), findsOneWidget);
  });

  testWidgets('RatingDescription uses correct text style',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: HotelBookingTheme.lightTheme,
        home: const Scaffold(
          body: RatingDescription(
            scoreText: '4.5',
            reviewCount: 100,
          ),
        ),
      ),
    );

    final Text textWidget = tester.widget<Text>(find.text('4.5 (100 Bew)'));
    final TextStyle textStyle = textWidget.style!;

    expect(textStyle.color, HotelBookingTheme.lightTheme.colorScheme.onSurface);
    expect(textStyle.fontWeight, FontWeight.w700);
  });
}
