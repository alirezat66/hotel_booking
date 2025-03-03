import 'package:hotel_booking/features/favorite/data/model/hotel_favorite.dart';
import 'package:hotel_booking/features/hotels/data/models/hotel_model.dart';

abstract class FavoriteRepository {
  Future<void> addFavorite(HotelModel hotel);
  Future<void> removeFavorite(String id);
  List<HotelFavorite> getFavorites();
  Stream<List<HotelFavorite>> watchFavorites();
}
