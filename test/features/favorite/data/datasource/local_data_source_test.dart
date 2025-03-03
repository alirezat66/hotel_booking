import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:hotel_booking/features/favorite/data/datasource/local_data_source.dart';
import 'package:hotel_booking/features/favorite/data/model/hotel_favorite.dart';
import 'package:hotel_booking/features/hotels/data/models/hotel_model.dart';

import 'local_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Box<HotelFavorite>>(as: #MockBox)])
void main() {
  late LocalDataSource localDataSource;
  late MockBox mockBox;

  setUp(() {
    mockBox = MockBox();
    localDataSource = LocalDataSource(mockBox);
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

  test('should add a favorite hotel', () async {
    await localDataSource.addFavorite(hotelModel);
    verify(mockBox.put(hotelModel.hotelId, any)).called(1);
  });

  test('should get all favorite hotels', () {
    final hotelFavorite = HotelFavorite.fromHotel(hotelModel);
    when(mockBox.values).thenReturn([hotelFavorite]);

    final result = localDataSource.getFavorites();

    expect(result, [hotelFavorite]);
  });

  test('should remove a favorite hotel', () async {
    await localDataSource.removeFavorite(hotelModel.hotelId);
    verify(mockBox.delete(hotelModel.hotelId)).called(1);
  });

  test('should watch favorite hotels', () {
    final hotelFavorite = HotelFavorite.fromHotel(hotelModel);
    when(mockBox.watch()).thenAnswer(
      (_) => Stream.fromIterable([
        BoxEvent(hotelModel.hotelId, hotelFavorite, false),
      ]),
    );
    when(mockBox.values).thenReturn([hotelFavorite]);

    final stream = localDataSource.watchFavorites();

    expectLater(stream, emits([hotelFavorite]));
  });
}
