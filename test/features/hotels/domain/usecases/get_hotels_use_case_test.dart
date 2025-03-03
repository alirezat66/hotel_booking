import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_booking/features/favorite/data/model/hotel_favorite.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:hotel_booking/features/hotels/domain/usecases/get_hotels_use_case.dart';
import 'package:hotel_booking/features/hotels/domain/repository/hotel_repository.dart';
import 'package:hotel_booking/features/hotels/data/models/hotel_response.dart';
import 'package:hotel_booking/features/hotels/data/models/hotel_model.dart';

import 'get_hotels_use_case_test.mocks.dart';

// Mock class for HotelRepository
@GenerateMocks([HotelRepository])
void main() {
  late GetHotelsUseCase useCase;
  late MockHotelRepository mockRepository;

  setUp(() {
    mockRepository = MockHotelRepository();
    useCase = GetHotelsUseCase(mockRepository);
  });

  final hotelList = [
    HotelModel(
      name: 'Hotel 1',
      destination: 'Destination 1',
      hotelId: '1',
      ratingInfo: HotelRatingInfo(
          score: 4.5, reviewCount: 100, scoreDescription: 'Zehr Gut'),
      bestOffer: HotelBestOffer(
        isFlightIncluded: true,
        travelPrice: 1000.0,
        pricePerPerson: 500.0,
        hasMoreOneOffer: false,
        travelDate: TravelDate(
          days: 5,
          nights: 4,
          departureDate: '2023-12-01',
          returnDate: '2023-12-05',
        ),
        roomsOverall: RoomsOverall(
          name: 'Room 1',
          boarding: 'Full Board',
          childrenCount: 2,
          adultCount: 2,
        ),
      ),
      images: ['image1.jpg', 'image2.jpg'],
    ),
    HotelModel(
      name: 'Hotel 2',
      destination: 'Destination 2',
      hotelId: '2',
      ratingInfo: HotelRatingInfo(
          score: 4.5, reviewCount: 100, scoreDescription: 'Zehr Gut'),
      bestOffer: HotelBestOffer(
        isFlightIncluded: false,
        travelPrice: 800.0,
        pricePerPerson: 400.0,
        hasMoreOneOffer: true,
        travelDate: TravelDate(
          days: 7,
          nights: 6,
          departureDate: '2023-12-10',
          returnDate: '2023-12-17',
        ),
        roomsOverall: RoomsOverall(
          name: 'Room 2',
          boarding: 'Half Board',
          childrenCount: 1,
          adultCount: 2,
        ),
      ),
      images: ['image3.jpg', 'image4.jpg'],
    ),
  ];

  final hotelResponse = HotelResponse(hotels: hotelList, hotelCount: 2);

  test('should get hotels from the repository', () async {
    // Arrange
    when(mockRepository.getHotels()).thenAnswer((_) async => hotelResponse);

    // Act
    final result = await useCase.call();

    // Assert
    expect(result, hotelResponse);
    verify(mockRepository.getHotels());
    verifyNoMoreInteractions(mockRepository);
  });
}
