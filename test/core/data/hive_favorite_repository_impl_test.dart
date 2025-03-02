import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hotel_booking/core/data/hive_favorite_repository_impl.dart';
import 'package:hotel_booking/features/favorite/data/hotel_favorite.dart';
import 'package:hotel_booking/features/hotels/data/models/hotel.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'hive_favorite_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<Box>(),
])
void main() {
  late HiveFavoriteRepositoryImpl repository;
  late MockBox<HotelFavorite> mockBox;

  setUp(() {
    mockBox = MockBox<HotelFavorite>();
    repository = HiveFavoriteRepositoryImpl(box: mockBox);
  });

  group('HiveFavoriteRepositoryImpl', () {
    final testHotel = Hotel(
      name: 'Test Hotel',
      destination: 'Test City',
      hotelId: '123',
      ratingInfo: HotelRatingInfo(
        score: 4.5,
        reviewCount: 100,
        scoreDescription: 'Excellent',
      ),
      bestOffer: HotelBestOffer(
        isFlightIncluded: false,
        travelPrice: 200.0,
        pricePerPerson: 100.0,
        hasMoreOneOffer: false,
        travelDate: TravelDate(
          days: 3,
          nights: 2,
          departureDate: '2025-03-10',
          returnDate: '2025-03-12',
        ),
        roomsOverall: RoomsOverall(
          name: 'Standard Room',
          boarding: 'Breakfast',
          childrenCount: 0,
          adultCount: 2,
        ),
      ),
      images: ['image1.jpg'],
    );

    final testFavoriteHotel = HotelFavorite.fromHotel(testHotel);

    test('addFavorite adds hotel to box', () async {
      // Arrange
      when(mockBox.put(any, any)).thenAnswer((_) async => {});

      // Act
      await repository.addFavorite(testHotel);

      // Assert
      verify(mockBox.put(testHotel.hotelId, testFavoriteHotel)).called(1);
    });

    test('getFavorites returns list of favorites', () {
      // Arrange
      when(mockBox.values).thenReturn([testFavoriteHotel]);

      // Act
      final result = repository.getFavorites();
      print('Result: $result');
      // Assert
      expect(result, [testFavoriteHotel]);
      verify(mockBox.values).called(1);
    });

    test('removeFavorite deletes hotel from box', () async {
      // Arrange
      when(mockBox.delete(any)).thenAnswer((_) async => {});

      // Act
      await repository.removeFavorite(testHotel.hotelId);

      // Assert
      verify(mockBox.delete(testHotel.hotelId)).called(1);
    });

    test('watchFavorites emits initial and updated values', () async {
      // Arrange
      final streamController = StreamController<BoxEvent>.broadcast();
      when(mockBox.watch()).thenAnswer((_) => streamController.stream);
      when(mockBox.values).thenReturn([testFavoriteHotel]);

      // Act
      final stream = repository.watchFavorites();

      // Assert initial value
      expectLater(
        stream,
        emitsInOrder([
          [testFavoriteHotel], // Initial value
          // Add more emits if you simulate changes
        ]),
      );

      // Simulate a change (optional)
      streamController
          .add(BoxEvent(testHotel.hotelId, testFavoriteHotel, false));
    });
  });
}
