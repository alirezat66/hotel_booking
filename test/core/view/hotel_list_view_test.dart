import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_booking/core/widgets/hotel_list_view.dart';
import 'package:hotel_booking/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:hotel_booking/features/favorite/data/model/hotel_favorite.dart';
import 'package:hotel_booking/features/hotels/data/models/hotel_model.dart';
import 'package:hotel_ui_package/hotel_ui_package.dart';
import 'package:mockito/mockito.dart';

import '../../features/favorite/view/favorite_page_test.mocks.dart';

void main() {
  late MockFavoriteCubit mockFavoriteCubit;
  late List<HotelModel> testHotels;

  setUp(() {
    mockFavoriteCubit = MockFavoriteCubit();
    when(mockFavoriteCubit.state).thenReturn([]);
    when(mockFavoriteCubit.stream).thenAnswer((_) => Stream.value([]));

    testHotels = [
      HotelModel(
        name: 'Hotel A',
        destination: 'City A',
        hotelId: '1',
        ratingInfo: HotelRatingInfo(
          score: 4.0,
          reviewCount: 50,
          scoreDescription: 'Good',
        ),
        bestOffer: HotelBestOffer(
          isFlightIncluded: false,
          travelPrice: 100.0,
          pricePerPerson: 50.0,
          hasMoreOneOffer: false,
          travelDate: TravelDate(
            days: 2,
            nights: 1,
            departureDate: '2025-03-10',
            returnDate: '2025-03-11',
          ),
          roomsOverall: RoomsOverall(
            name: 'Basic Room',
            boarding: 'None',
            childrenCount: 0,
            adultCount: 1,
          ),
        ),
        images: ['image_a.jpg'],
      ),
    ];
  });

  // Helper to wrap widget with necessary providers
  Widget buildTestableWidget(Widget child) {
    return MaterialApp(
      theme: HotelBookingTheme.lightTheme,
      home: BlocProvider<FavoriteCubit>.value(
        value: mockFavoriteCubit,
        child: CustomScrollView(slivers: [child]),
      ),
    );
  }

  testWidgets('HotelListView renders hotels correctly',
      (WidgetTester tester) async {
    // Arrange & Act
    await tester.pumpWidget(
      buildTestableWidget(
        HotelListView(
          hotels: testHotels,
          cardType: HotelCardType.compact,
        ),
      ),
    );
    await tester.pump();

    // Assert
    expect(find.text('Hotel A'), findsOneWidget);
    expect(find.text('City A'), findsOneWidget);
  });

  testWidgets('HotelListView adds favorite when toggled',
      (WidgetTester tester) async {
    // Arrange
    when(mockFavoriteCubit.addFavorite(any)).thenReturn(null);
    await tester.pumpWidget(
      buildTestableWidget(
        HotelListView(
          hotels: testHotels,
          cardType: HotelCardType.compact,
        ),
      ),
    );
    await tester.pump();

    // Act - Tap favorite button on first hotel
    await tester.tap(find.byIcon(Icons.favorite_border).first);
    await tester.pump();

    // Assert
    verify(mockFavoriteCubit.addFavorite(testHotels[0])).called(1);
  });

  testWidgets('HotelListView add favorite when toggled on',
      (WidgetTester tester) async {
    // Arrange
    when(mockFavoriteCubit.state).thenReturn([
      HotelFavorite(
        name: 'Hotel A',
        destination: 'City A',
        hotelId: '1',
        ratingInfo: testHotels[0].ratingInfo,
        image: 'image_a.jpg',
        createdAt: DateTime.now(),
      ),
    ]);
    when(mockFavoriteCubit.removeFavorite(any)).thenReturn(null);
    when(mockFavoriteCubit.addFavorite(any)).thenReturn(null);

    await tester.pumpWidget(
      buildTestableWidget(
        HotelListView(
          hotels: testHotels,
          cardType: HotelCardType.compact,
          onFavoriteChange: (isFavorite) {
            if (!isFavorite) {
              mockFavoriteCubit.removeFavorite('1');
            } else {
              mockFavoriteCubit.addFavorite(testHotels[0]);
            }
          },
        ),
      ),
    );
    mockFavoriteCubit.emit(mockFavoriteCubit.state);
    await tester.pump();
    final widget = find.byIcon(Icons.favorite_border).first;
    await tester.tap(widget);
    await tester.pump(const Duration(milliseconds: 300));
    // Assert
    verifyNever(mockFavoriteCubit.removeFavorite('1'));
    verify(mockFavoriteCubit.addFavorite(any)).called(1);
  });
}
