import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_ui_package/hotel_ui_package.dart';
import 'package:hotel_ui_package/models/translate_strings.dart';

void main() {
  testWidgets('HotelCard displays detailed card correctly',
      (WidgetTester tester) async {
    final hotelData = HotelData(
      score: 4.5,
      reviewCount: 120,
      scoreDescription: 'Excellent',
      name: 'Hotel Test',
      destination: 'Test City',
      days: 5,
      nights: 4,
      kids: 2,
      adults: 2,
      overallName: 'Test Overall',
      overallBoarding: 'Full Board',
      isFlightIncluded: true,
      travelPrice: 1000.0,
      pricePerPerson: 250.0,
      imageUrl: 'https://example.com/image.jpg',
      translateStrings: TranslateStrings(),
      isLiked: false,
    );

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ListView(
          children: [
            HotelCard(
              cardType: HotelCardType.detailed,
              hotel: hotelData,
              onFavoriteChanged: (bool isFavorite) {},
              onActionPressed: () {},
              onMoreInfoTab: () {},
            ),
          ],
        ),
      ),
    ));

    expect(find.text('Hotel Test'), findsOneWidget);
    expect(find.text('Test City'), findsOneWidget);
    expect(find.text('Zu den Angeboten'), findsOneWidget);
  });

  testWidgets('HotelCard displays compact card correctly',
      (WidgetTester tester) async {
    final hotelData = HotelData(
      score: 4.5,
      reviewCount: 120,
      scoreDescription: 'Excellent',
      name: 'Hotel Test',
      destination: 'Test City',
      days: 5,
      nights: 4,
      kids: 2,
      adults: 2,
      overallName: 'Test Overall',
      overallBoarding: 'Full Board',
      isFlightIncluded: true,
      travelPrice: 1000.0,
      pricePerPerson: 250.0,
      imageUrl: 'https://example.com/image.jpg',
      translateStrings: TranslateStrings(),
      isLiked: false,
    );

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ListView(
          children: [
            HotelCard(
              cardType: HotelCardType.compact,
              hotel: hotelData,
              onFavoriteChanged: (bool isFavorite) {},
              onActionPressed: () {},
              onMoreInfoTab: () {},
            ),
          ],
        ),
      ),
    ));

    expect(find.text('Hotel Test'), findsOneWidget);
    expect(find.text('Test City'), findsOneWidget);
    expect(find.text('Zum Hotel'), findsOneWidget);
  });
}
