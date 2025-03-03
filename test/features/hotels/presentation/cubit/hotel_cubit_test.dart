import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:hotel_booking/features/favorite/data/model/hotel_favorite.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:hotel_booking/features/hotels/presentation/cubit/hotel_cubit.dart';
import 'package:hotel_booking/features/hotels/domain/usecases/get_hotels_use_case.dart';
import 'package:hotel_booking/features/hotels/data/models/hotel_response.dart';
import 'package:hotel_booking/features/hotels/data/models/hotel_model.dart';

import 'hotel_cubit_test.mocks.dart';

@GenerateMocks([GetHotelsUseCase])
void main() {
  late HotelCubit cubit;
  late MockGetHotelsUseCase mockGetHotelsUseCase;

  setUp(() {
    mockGetHotelsUseCase = MockGetHotelsUseCase();
    cubit = HotelCubit(mockGetHotelsUseCase);
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

  blocTest<HotelCubit, HotelState>(
    'emits [HotelLoading, HotelSuccess] when getHotels is successful',
    build: () {
      when(mockGetHotelsUseCase.call()).thenAnswer((_) async => hotelResponse);
      return cubit;
    },
    act: (cubit) => cubit.getHotels(),
    expect: () => [
      isA<HotelLoading>(),
      isA<HotelSuccess>()
          .having((state) => state.hotels, 'hotels', hotelList)
          .having(
              (state) => state.numberOfHotels, 'hotelCount', hotelList.length),
    ],
    verify: (_) {
      verify(mockGetHotelsUseCase.call()).called(1);
    },
  );

  blocTest<HotelCubit, HotelState>(
    'emits [HotelLoading, HotelFailure] when getHotels fails',
    build: () {
      when(mockGetHotelsUseCase.call())
          .thenThrow(Exception('Failed to load hotels'));
      return cubit;
    },
    act: (cubit) => cubit.getHotels(),
    expect: () => [
      isA<HotelLoading>(),
      isA<HotelFailure>().having((state) => state.errorMessage, 'error',
          'Exception: Failed to load hotels'),
    ],
    verify: (_) {
      verify(mockGetHotelsUseCase.call()).called(1);
    },
  );
}
