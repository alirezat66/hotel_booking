import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_booking/features/favorite/data/model/hotel_favorite.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:hotel_booking/features/favorite/domain/repository/favorite_repository.dart';
import 'package:hotel_booking/features/favorite/domain/usecase/add_favorite_use_case.dart';
import 'package:hotel_booking/features/hotels/data/models/hotel_model.dart';

import 'add_favorite_use_case_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FavoriteRepository>(as: #MockFavoriteRepository)])
void main() {
  late AddFavoriteUseCase useCase;
  late MockFavoriteRepository mockFavoriteRepository;

  setUp(() {
    mockFavoriteRepository = MockFavoriteRepository();
    useCase = AddFavoriteUseCase(mockFavoriteRepository);
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
    await useCase(hotelModel);
    verify(mockFavoriteRepository.addFavorite(hotelModel)).called(1);
  });
}
