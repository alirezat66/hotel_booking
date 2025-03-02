import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_booking/core/data/favorite_repository.dart';
import 'package:hotel_booking/features/favorite/cubit/favorite_cubit.dart';
import 'package:hotel_booking/features/favorite/data/hotel_favorite.dart';
import 'package:hotel_booking/features/hotels/data/models/hotel.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'favorite_cubit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FavoriteRepository>()])
void main() {
  late MockFavoriteRepository mockFavoriteRepository;
  late StreamController<List<HotelFavorite>> streamController;

  setUp(() {
    mockFavoriteRepository = MockFavoriteRepository();
    streamController = StreamController<List<HotelFavorite>>.broadcast();
    when(mockFavoriteRepository.watchFavorites())
        .thenAnswer((_) => streamController.stream);
  });

  tearDown(() {
    streamController.close();
  });

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

  group('FavoriteCubit', () {
    test('initial state is empty list', () {
      final cubit = FavoriteCubit(mockFavoriteRepository);
      expect(cubit.state, []);
      cubit.close();
    });

    blocTest<FavoriteCubit, List<HotelFavorite>>(
      'emits favorites when watchFavorites stream emits',
      build: () => FavoriteCubit(mockFavoriteRepository),
      act: (cubit) async {
        streamController.add([testFavoriteHotel]);
        await Future.delayed(Duration.zero); // Allow stream to propagate
      },
      expect: () => [
        [testFavoriteHotel]
      ],
      verify: (_) {
        verify(mockFavoriteRepository.watchFavorites())
            .called(greaterThanOrEqualTo(1));
      },
    );

    blocTest<FavoriteCubit, List<HotelFavorite>>(
      'addFavorite calls repository and updates state via stream',
      build: () {
        when(mockFavoriteRepository.addFavorite(testHotel))
            .thenAnswer((_) async => {});
        return FavoriteCubit(mockFavoriteRepository);
      },
      act: (cubit) async {
        cubit.addFavorite(testHotel);
        streamController.add([testFavoriteHotel]);
        await Future.delayed(Duration.zero);
      },
      expect: () => [
        [testFavoriteHotel]
      ],
      verify: (_) {
        verify(mockFavoriteRepository.addFavorite(testHotel)).called(1);
      },
    );

    blocTest<FavoriteCubit, List<HotelFavorite>>(
      'removeFavorite calls repository and updates state via stream',
      build: () {
        when(mockFavoriteRepository.removeFavorite(testHotel.hotelId))
            .thenAnswer((_) async => {});
        return FavoriteCubit(mockFavoriteRepository);
      },
      act: (cubit) async {
        cubit.removeFavorite(testHotel.hotelId);
        streamController.add([]);
        await Future.delayed(Duration.zero);
      },
      expect: () => [[]],
      verify: (_) {
        verify(mockFavoriteRepository.removeFavorite(testHotel.hotelId))
            .called(1);
      },
    );
  });
}
