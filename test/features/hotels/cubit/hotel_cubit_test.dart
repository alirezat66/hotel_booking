/* import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_booking/features/favorite/data/model/hotel_favorite.dart';
import 'package:hotel_booking/features/hotels/presentation/cubit/hotel_cubit.dart';
import 'package:hotel_booking/features/hotels/data/models/hotel_model.dart';
import 'package:hotel_booking/features/hotels/data/models/hotel_response.dart';
import 'package:hotel_booking/features/hotels/data/repository/hotel_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Generate mocks for HotelRepository
@GenerateMocks([HotelRepository])
import 'hotel_cubit_test.mocks.dart';

void main() {
  late HotelCubit hotelCubit;
  late MockHotelRepository mockHotelRepository;

  // Sample hotel data for testing
  final testHotel = HotelModel(
    name: 'Test Hotel',
    destination: 'Test Destination',
    hotelId: '123',
    ratingInfo: HotelRatingInfo(
      score: 4.5,
      reviewCount: 100,
      scoreDescription: 'Excellent',
    ),
    bestOffer: HotelBestOffer(
      isFlightIncluded: true,
      travelPrice: 500.0,
      pricePerPerson: 250.0,
      hasMoreOneOffer: false,
      travelDate: TravelDate(
        days: 7,
        nights: 6,
        departureDate: '2025-03-10',
        returnDate: '2025-03-16',
      ),
      roomsOverall: RoomsOverall(
        name: 'Standard Room',
        boarding: 'All Inclusive',
        childrenCount: 0,
        adultCount: 2,
      ),
    ),
    images: ['https://example.com/image.jpg'],
  );

  final testHotelResponse = HotelResponse(
    hotels: [testHotel],
    hotelCount: 1,
  );

  setUp(() {
    mockHotelRepository = MockHotelRepository();
    hotelCubit = HotelCubit(mockHotelRepository);
  });

  tearDown(() {
    hotelCubit.close();
  });

  group('HotelCubit', () {
    // Test the initial state
    test('initial state is HotelLoading', () {
      expect(hotelCubit.state, isA<HotelLoading>());
    });

    // Success scenario
    blocTest<HotelCubit, HotelState>(
      'emits [HotelLoading, HotelSuccess] when getHotels succeeds',
      build: () {
        when(mockHotelRepository.getHotels())
            .thenAnswer((_) async => testHotelResponse);
        return hotelCubit;
      },
      act: (cubit) => cubit.getHotels(),
      expect: () => [
        isA<HotelLoading>(),
        isA<HotelSuccess>()
            .having((state) => state.hotels, 'hotels', testHotelResponse.hotels)
            .having((state) => state.numberOfHotels, 'numberOfHotels', 1),
      ],
      verify: (_) {
        verify(mockHotelRepository.getHotels()).called(1);
      },
    );

    // Failure scenario
    blocTest<HotelCubit, HotelState>(
      'emits [HotelLoading, HotelFailure] when getHotels fails',
      build: () {
        when(mockHotelRepository.getHotels())
            .thenThrow(Exception('Failed to fetch hotels'));
        return hotelCubit;
      },
      act: (cubit) => cubit.getHotels(),
      expect: () => [
        isA<HotelLoading>(),
        isA<HotelFailure>().having(
          (state) => state.errorMessage,
          'errorMessage',
          'Exception: Failed to fetch hotels',
        ),
      ],
      verify: (_) {
        verify(mockHotelRepository.getHotels()).called(1);
      },
    );

    // Invalid response format scenario (optional, depends on repository behavior)
    blocTest<HotelCubit, HotelState>(
      'emits [HotelLoading, HotelFailure] when repository throws invalid format exception',
      build: () {
        when(mockHotelRepository.getHotels())
            .thenThrow(Exception('Invalid response format'));
        return hotelCubit;
      },
      act: (cubit) => cubit.getHotels(),
      expect: () => [
        isA<HotelLoading>(),
        isA<HotelFailure>().having(
          (state) => state.errorMessage,
          'errorMessage',
          'Exception: Invalid response format',
        ),
      ],
      verify: (_) {
        verify(mockHotelRepository.getHotels()).called(1);
      },
    );
  });
}
 */