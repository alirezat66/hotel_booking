import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:hotel_booking/features/favorite/domain/repository/favorite_repository.dart';
import 'package:hotel_booking/features/favorite/domain/usecase/get_favorites_use_case.dart';
import 'package:hotel_booking/features/favorite/data/model/hotel_favorite.dart';

import 'get_favorites_use_case_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FavoriteRepository>(as: #MockFavoriteRepository)])
void main() {
  late GetFavoriteUseCase useCase;
  late MockFavoriteRepository mockFavoriteRepository;

  setUp(() {
    mockFavoriteRepository = MockFavoriteRepository();
    useCase = GetFavoriteUseCase(mockFavoriteRepository);
  });

  final hotelFavorite = HotelFavorite(
    name: 'Test Hotel',
    destination: 'Test Destination',
    hotelId: '1',
    ratingInfo: HotelRatingInfo(
      score: 4.5,
      reviewCount: 100,
      scoreDescription: 'Excellent',
    ),
    image: 'image1.jpg',
  );

  test('should get all favorite hotels', () {
    when(mockFavoriteRepository.getFavorites()).thenReturn([hotelFavorite]);

    final result = useCase();

    expect(result, [hotelFavorite]);
  });
}
