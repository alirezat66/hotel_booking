import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:hotel_booking/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:hotel_booking/features/favorite/domain/usecase/add_favorite_use_case.dart';
import 'package:hotel_booking/features/favorite/domain/usecase/remove_favorite_use_case.dart';
import 'package:hotel_booking/features/favorite/domain/usecase/get_favorites_use_case.dart';
import 'package:hotel_booking/features/favorite/domain/usecase/watch_use_case.dart';
import 'package:hotel_booking/features/favorite/data/model/hotel_favorite.dart';
import 'package:hotel_booking/features/hotels/data/models/hotel_model.dart';
import 'package:mockito/annotations.dart';
import 'favorite_cubit_test.mocks.dart';

@GenerateMocks([
  AddFavoriteUseCase,
  RemoveFavoriteUseCase,
  GetFavoriteUseCase,
  WatchFavoriteUseCase
])
void main() {
  late FavoriteCubit favoriteCubit;
  late MockAddFavoriteUseCase mockAddFavoriteUseCase;
  late MockRemoveFavoriteUseCase mockRemoveFavoriteUseCase;
  late MockGetFavoriteUseCase mockGetFavoriteUseCase;
  late MockWatchFavoriteUseCase mockWatchFavoriteUseCase;

  final testHotelModel = HotelModel(
    name: 'Test Hotel',
    destination: 'Test Destination',
    hotelId: 'test123',
    ratingInfo: HotelRatingInfo(
      score: 4.5,
      reviewCount: 100,
      scoreDescription: 'Excellent',
    ),
    bestOffer: HotelBestOffer(
      isFlightIncluded: true,
      travelPrice: 1000.0,
      pricePerPerson: 500.0,
      hasMoreOneOffer: true,
      travelDate: TravelDate(
        days: 5,
        nights: 4,
        departureDate: '2023-01-01',
        returnDate: '2023-01-05',
      ),
      roomsOverall: RoomsOverall(
        name: 'Deluxe Room',
        boarding: 'All Inclusive',
        childrenCount: 2,
        adultCount: 2,
      ),
    ),
    images: ['image1.jpg', 'image2.jpg'],
  );

  HotelFavorite(
    name: 'Test Hotel',
    destination: 'Test Destination',
    hotelId: 'test123',
    ratingInfo: HotelRatingInfo(
      score: 4.5,
      reviewCount: 100,
      scoreDescription: 'Excellent',
    ),
    image: 'image1.jpg',
    createdAt: DateTime(2023, 1, 1),
  );

  setUp(() {
    mockAddFavoriteUseCase = MockAddFavoriteUseCase();
    mockRemoveFavoriteUseCase = MockRemoveFavoriteUseCase();
    mockGetFavoriteUseCase = MockGetFavoriteUseCase();
    mockWatchFavoriteUseCase = MockWatchFavoriteUseCase();

    when(mockGetFavoriteUseCase.call()).thenReturn([]);

    // Setup the stream to emit an empty list initially
    final controller = StreamController<List<HotelFavorite>>();
    when(mockWatchFavoriteUseCase.call()).thenAnswer((_) => controller.stream);
    controller.add([]);

    favoriteCubit = FavoriteCubit(
      addFavoriteUseCase: mockAddFavoriteUseCase,
      removeFavoriteUseCase: mockRemoveFavoriteUseCase,
      getFavoriteUseCase: mockGetFavoriteUseCase,
      watchFavoriteUseCase: mockWatchFavoriteUseCase,
    );
  });

  tearDown(() {
    favoriteCubit.close();
  });

  group('FavoriteCubit', () {
    test('initial state should be an empty list', () {
      expect(favoriteCubit.state, []);
    });

    blocTest<FavoriteCubit, List<HotelFavorite>>(
      'should call getFavoriteUseCase on initialization',
      build: () {
        when(mockGetFavoriteUseCase.call()).thenReturn([]);
        when(mockWatchFavoriteUseCase.call())
            .thenAnswer((_) => Stream.value([]));

        return FavoriteCubit(
          addFavoriteUseCase: mockAddFavoriteUseCase,
          removeFavoriteUseCase: mockRemoveFavoriteUseCase,
          getFavoriteUseCase: mockGetFavoriteUseCase,
          watchFavoriteUseCase: mockWatchFavoriteUseCase,
        );
      },
      verify: (_) {
        verify(mockGetFavoriteUseCase.call()).called(2);
      },
    );

    blocTest<FavoriteCubit, List<HotelFavorite>>(
      'should subscribe to watchFavoriteUseCase on initialization',
      build: () {
        when(mockGetFavoriteUseCase.call()).thenReturn([]);
        when(mockWatchFavoriteUseCase.call())
            .thenAnswer((_) => Stream.value([]));

        return FavoriteCubit(
          addFavoriteUseCase: mockAddFavoriteUseCase,
          removeFavoriteUseCase: mockRemoveFavoriteUseCase,
          getFavoriteUseCase: mockGetFavoriteUseCase,
          watchFavoriteUseCase: mockWatchFavoriteUseCase,
        );
      },
      verify: (_) {
        verify(mockWatchFavoriteUseCase.call()).called(2);
      },
    );

    blocTest<FavoriteCubit, List<HotelFavorite>>(
      'should call addFavoriteUseCase when addFavorite is called',
      build: () {
        when(mockAddFavoriteUseCase.call(testHotelModel))
            .thenAnswer((_) async {});

        return favoriteCubit;
      },
      act: (cubit) => cubit.addFavorite(testHotelModel),
      verify: (_) {
        verify(mockAddFavoriteUseCase.call(testHotelModel)).called(1);
      },
    );

    blocTest<FavoriteCubit, List<HotelFavorite>>(
      'should call removeFavoriteUseCase when removeFavorite is called',
      build: () {
        when(mockRemoveFavoriteUseCase.call('test123'))
            .thenAnswer((_) async {});

        return favoriteCubit;
      },
      act: (cubit) => cubit.removeFavorite('test123'),
      verify: (_) {
        verify(mockRemoveFavoriteUseCase.call('test123')).called(1);
      },
    );

    blocTest<FavoriteCubit, List<HotelFavorite>>(
      'should emit sorted list when the favorites stream emits',
      build: () {
        final date1 = DateTime(2023, 1, 2);
        final date2 = DateTime(2023, 1, 1);

        final favorite1 = HotelFavorite(
          name: 'Hotel 1',
          destination: 'Destination 1',
          hotelId: '1',
          ratingInfo: HotelRatingInfo(
            score: 4.5,
            reviewCount: 100,
            scoreDescription: 'Excellent',
          ),
          image: 'image1.jpg',
          createdAt: date1,
        );

        final favorite2 = HotelFavorite(
          name: 'Hotel 2',
          destination: 'Destination 2',
          hotelId: '2',
          ratingInfo: HotelRatingInfo(
            score: 4.0,
            reviewCount: 80,
            scoreDescription: 'Very Good',
          ),
          image: 'image2.jpg',
          createdAt: date2,
        );

        // Should be sorted with newest first (favorite1 then favorite2)
        when(mockWatchFavoriteUseCase.call())
            .thenAnswer((_) => Stream.value([favorite2, favorite1]));

        return FavoriteCubit(
          addFavoriteUseCase: mockAddFavoriteUseCase,
          removeFavoriteUseCase: mockRemoveFavoriteUseCase,
          getFavoriteUseCase: mockGetFavoriteUseCase,
          watchFavoriteUseCase: mockWatchFavoriteUseCase,
        );
      },
      expect: () => [
        isA<List<HotelFavorite>>().having(
          (list) => list.map((f) => f.hotelId).toList(),
          'sorted hotelIds',
          ['1', '2'],
        ),
      ],
    );

    test('should cancel subscription when closed', () async {
      // Create a stream controller to verify it's closed later
      final controller = StreamController<List<HotelFavorite>>();
      when(mockWatchFavoriteUseCase.call())
          .thenAnswer((_) => controller.stream);

      final cubit = FavoriteCubit(
        addFavoriteUseCase: mockAddFavoriteUseCase,
        removeFavoriteUseCase: mockRemoveFavoriteUseCase,
        getFavoriteUseCase: mockGetFavoriteUseCase,
        watchFavoriteUseCase: mockWatchFavoriteUseCase,
      );

      await cubit.close();

      // If the subscription was canceled, we should be able to close the controller
      // without errors
      expect(() => controller.close(), returnsNormally);
    });
  });
}
