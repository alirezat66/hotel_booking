import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:hotel_booking/features/favorite/domain/repository/favorite_repository.dart';
import 'package:hotel_booking/features/favorite/domain/usecase/remove_favorite_use_case.dart';

import 'remove_favorite_use_case_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FavoriteRepository>(as: #MockFavoriteRepository)])
void main() {
  late RemoveFavoriteUseCase useCase;
  late MockFavoriteRepository mockFavoriteRepository;

  setUp(() {
    mockFavoriteRepository = MockFavoriteRepository();
    useCase = RemoveFavoriteUseCase(mockFavoriteRepository);
  });

  const String hotelId = '1';

  test('should remove a favorite hotel', () async {
    await useCase(hotelId);
    verify(mockFavoriteRepository.removeFavorite(hotelId)).called(1);
  });
}
