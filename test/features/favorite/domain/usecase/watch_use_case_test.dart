import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:hotel_booking/features/favorite/domain/usecase/watch_use_case.dart';
import 'package:hotel_booking/features/favorite/domain/repository/favorite_repository.dart';
import 'package:hotel_booking/features/favorite/data/model/hotel_favorite.dart';
import 'package:mockito/annotations.dart';
import 'watch_use_case_test.mocks.dart';

@GenerateMocks([FavoriteRepository])
void main() {
  late WatchFavoriteUseCase useCase;
  late MockFavoriteRepository mockRepository;

  setUp(() {
    mockRepository = MockFavoriteRepository();
    useCase = WatchFavoriteUseCase(mockRepository);
  });

  test('should return a stream of favorite hotels from the repository', () {
    // Arrange
    final favoriteHotels = [
      HotelFavorite(
        name: 'Hotel 1',
        destination: 'Destination 1',
        hotelId: '1',
        ratingInfo: HotelRatingInfo(score: 4.5, reviewCount: 100, scoreDescription: 'Excellent'),
        image: 'image1.jpg',
      ),
      HotelFavorite(
        name: 'Hotel 2',
        destination: 'Destination 2',
        hotelId: '2',
        ratingInfo: HotelRatingInfo(score: 4.0, reviewCount: 80, scoreDescription: 'Very Good'),
        image: 'image2.jpg',
      ),
    ];
    when(mockRepository.watchFavorites()).thenAnswer((_) => Stream.value(favoriteHotels));

    // Act
    final result = useCase();

    // Assert
    expectLater(result, emitsInOrder([favoriteHotels]));
    verify(mockRepository.watchFavorites()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
