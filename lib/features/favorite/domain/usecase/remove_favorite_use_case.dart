import 'package:hotel_booking/features/favorite/domain/repository/favorite_repository.dart';

class RemoveFavoriteUseCase {
  final FavoriteRepository repository;
  RemoveFavoriteUseCase(this.repository);
  Future<void> call(String hotelId) => repository.removeFavorite(hotelId);
}
