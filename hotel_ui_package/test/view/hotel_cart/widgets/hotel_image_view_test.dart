import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_ui_package/view/hotel_cart/widgets/hotel_image_view.dart';
import 'package:hotel_ui_package/view/favorite_widget.dart';
import 'package:hotel_ui_package/view/hotel_cart/widgets/rate/rate_widget.dart';
import 'package:hotel_ui_package/view/app_image_view.dart';

void main() {
  testWidgets('HotelImageView displays image, rate widget, and favorite widget',
      (WidgetTester tester) async {
    const testUrl = 'https://example.com/image.jpg';
    const testAspectRatio = 343 / 186;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HotelImageView(
            url: testUrl,
            aspectRatio: testAspectRatio,
            rateWidget: const RateWidget(
                score: 4.5, reviewCount: 100, scoreDescription: 'Excellent'),
            favoriteWidget: FavoriteWidget(
              initialState: false,
              onLikeChanged: (bool isLiked) {},
            ),
          ),
        ),
      ),
    );

    // Verify the image is displayed
    expect(find.byType(AppImageView), findsOneWidget);

    // Verify the rate widget is displayed
    expect(find.byType(RateWidget), findsOneWidget);

    // Verify the favorite widget is displayed
    expect(find.byType(FavoriteWidget), findsOneWidget);
  });

  testWidgets(
      'HotelImageView displays default widgets when rateWidget and favoriteWidget are null',
      (WidgetTester tester) async {
    const testUrl = 'https://example.com/image.jpg';
    const testAspectRatio = 343 / 186;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: HotelImageView(
            url: testUrl,
            aspectRatio: testAspectRatio,
          ),
        ),
      ),
    );

    // Verify the image is displayed
    expect(find.byType(AppImageView), findsOneWidget);

    // Verify the default rate widget (SizedBox) is displayed
    expect(find.byType(SizedBox), findsNWidgets(4));
  });
}
