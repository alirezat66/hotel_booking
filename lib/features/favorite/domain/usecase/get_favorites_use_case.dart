import 'package:hotel_booking/features/favorite/data/model/hotel_favorite.dart';
import 'package:hotel_booking/features/favorite/domain/repository/favorite_repository.dart';

class GetFavoriteUseCase {
  final FavoriteRepository repository;
  GetFavoriteUseCase(this.repository);
  List<HotelFavorite> call() => repository.getFavorites();
}
