import 'package:hive/hive.dart';
import 'package:hotel_booking/features/favorite/data/model/hotel_favorite.dart';
import 'package:hotel_booking/features/hotels/data/models/hotel_model.dart';

class LocalDataSource {
  final Box<HotelFavorite> favoriteBox;
  LocalDataSource(this.favoriteBox);

  Future<void> addFavorite(HotelModel hotel) async {
    await favoriteBox.put(hotel.hotelId, HotelFavorite.fromHotel(hotel));
  }

  List<HotelFavorite> getFavorites() {
    final list = favoriteBox.values.toList();
    list.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    return list;
  }

  Future<void> removeFavorite(String hotelId) {
    return favoriteBox.delete(hotelId);
  }

  Stream<List<HotelFavorite>> watchFavorites() {
    return favoriteBox.watch().map((event) {
      return favoriteBox.values.toList();
    });
  }
}
