import 'package:hotel_booking/features/favorite/data/hotel_favorite.dart';
import 'package:hotel_booking/features/hotels/data/models/hotel.dart';

abstract class FavoriteRepository {
  Future<void> addFavorite(Hotel hotel);
  Future<void> removeFavorite(String hotelId);
  List<HotelFavorite> getFavorites();
  Stream<List<HotelFavorite>> watchFavorites();

}