import 'package:hive/hive.dart';
import 'package:hotel_booking/core/data/favorite_repository.dart';
import 'package:hotel_booking/features/favorite/data/hotel_favorite.dart';
import 'package:hotel_booking/features/hotels/data/models/hotel.dart';

class HiveFavoriteRepositoryImpl implements FavoriteRepository {
  final Box<HotelFavorite> _favoriteBox;
  HiveFavoriteRepositoryImpl({required Box<HotelFavorite> box})
      : _favoriteBox = box;

  @override
  Future<void> addFavorite(Hotel hotel) async {
    await _favoriteBox.put(hotel.hotelId, HotelFavorite.fromHotel(hotel));
  }

  @override
  List<HotelFavorite> getFavorites() {
    return _favoriteBox.values.toList();
  }

  @override
  Future<void> removeFavorite(String hotelId) {
    return _favoriteBox.delete(hotelId);
  }

  @override
  Stream<List<HotelFavorite>> watchFavorites() {
    return _favoriteBox.watch().map((event) {
      return _favoriteBox.values.toList();
    });
  }
}
