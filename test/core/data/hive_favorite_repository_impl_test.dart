import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hotel_booking/core/data/hive_favorite_repository_impl.dart';
import 'package:hotel_booking/features/favorite/data/hotel_favorite.dart';
import 'package:hotel_booking/features/hotels/data/models/hotel.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'hive_favorite_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Box>()])
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

    // Define a fixed DateTime for consistency
    final fixedDateTime = DateTime(2023, 1, 1);
    final testFavoriteHotel = HotelFavorite(
        name: testHotel.name,
        destination: testHotel.destination,
        hotelId: testHotel.hotelId,
        ratingInfo: testHotel.ratingInfo,
        image: testHotel.images.first,
        createdAt: fixedDateTime); // Set manually for test consistency

    test('addFavorite adds hotel to box', () async {
      // Arrange
      when(mockBox.put(testFavoriteHotel.hotelId, testFavoriteHotel))
          .thenAnswer((_) async => {});
      repository.addFavorite(testHotel);
      // Assert
      verify(mockBox.put(
        testFavoriteHotel.hotelId,
        testFavoriteHotel,
      )).called(1);
    });

    test('getFavorites returns list of favorites', () {
      // Arrange
      when(mockBox.values).thenReturn([testFavoriteHotel]);

      // Act
      final result = repository.getFavorites();

      // Assert
      expect(result, [testFavoriteHotel]);
      verify(mockBox.values).called(1);
    });

    test('getFavorites returns empty list when box is empty', () {
      // Arrange
      when(mockBox.values).thenReturn([]);

      // Act
      final result = repository.getFavorites();

      // Assert
      expect(result, isEmpty);
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

  });
}
