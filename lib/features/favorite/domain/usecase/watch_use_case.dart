import 'package:hotel_booking/features/favorite/data/model/hotel_favorite.dart';
import 'package:hotel_booking/features/favorite/domain/repository/favorite_repository.dart';

class WatchFavoriteUseCase {
  final FavoriteRepository repository;
  WatchFavoriteUseCase(this.repository);
  Stream<List<HotelFavorite>> call() => repository.watchFavorites();
}
