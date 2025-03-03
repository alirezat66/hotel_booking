import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:hotel_booking/features/favorite/data/datasource/local_data_source.dart';
import 'package:hotel_booking/features/favorite/data/model/hotel_favorite.dart';
import 'package:hotel_booking/features/favorite/data/repository/favorite_repository_impl.dart';
import 'package:hotel_booking/features/hotels/data/models/hotel_model.dart';

import 'favorite_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<LocalDataSource>(as: #MockLocalDataSource)])
void main() {
  late FavoriteRepositoryImpl repository;
  late MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    repository = FavoriteRepositoryImpl(mockLocalDataSource);
  });

  final hotelModel = HotelModel(
    name: 'Test Hotel',
    destination: 'Test Destination',
    hotelId: '1',
    ratingInfo: HotelRatingInfo(
        score: 4.5, reviewCount: 100, scoreDescription: 'Excellent'),
    bestOffer: HotelBestOffer(
      isFlightIncluded: true,
      travelPrice: 1000.0,
      pricePerPerson: 500.0,
      hasMoreOneOffer: true,
      travelDate: TravelDate(
          days: 5,
          nights: 4,
          departureDate: '2023-01-01',
          returnDate: '2023-01-05'),
      roomsOverall: RoomsOverall(
          name: 'Deluxe',
          boarding: 'Full Board',
          childrenCount: 2,
          adultCount: 2),
    ),
    images: ['image1.jpg', 'image2.jpg'],
  );

  final hotelFavorite = HotelFavorite.fromHotel(hotelModel);

  test('should add a favorite hotel', () async {
    await repository.addFavorite(hotelModel);
    verify(mockLocalDataSource.addFavorite(hotelModel)).called(1);
  });

  test('should get all favorite hotels', () {
    when(mockLocalDataSource.getFavorites()).thenReturn([hotelFavorite]);

    final result = repository.getFavorites();

    expect(result, [hotelFavorite]);
  });

  test('should remove a favorite hotel', () async {
    await repository.removeFavorite(hotelModel.hotelId);
    verify(mockLocalDataSource.removeFavorite(hotelModel.hotelId)).called(1);
  });

  test('should watch favorite hotels', () {
    when(mockLocalDataSource.watchFavorites()).thenAnswer(
      (_) => Stream.fromIterable([
        [hotelFavorite],
      ]),
    );

    final stream = repository.watchFavorites();

    expectLater(stream, emits([hotelFavorite]));
  });
}
