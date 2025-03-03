import 'package:hotel_booking/features/favorite/domain/repository/favorite_repository.dart';
import 'package:hotel_booking/features/hotels/data/models/hotel_model.dart';

class AddFavoriteUseCase {
  final FavoriteRepository repository;
  AddFavoriteUseCase(this.repository);
  Future<void> call(HotelModel hotel) => repository.addFavorite(hotel);
}
