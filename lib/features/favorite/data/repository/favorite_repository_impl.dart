import 'package:hotel_booking/features/favorite/data/datasource/local_data_source.dart';
import 'package:hotel_booking/features/favorite/data/model/hotel_favorite.dart';
import 'package:hotel_booking/features/favorite/domain/repository/favorite_repository.dart';
import 'package:hotel_booking/features/hotels/data/models/hotel_model.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final LocalDataSource localDataSource;
  FavoriteRepositoryImpl(this.localDataSource);
  @override
  Future<void> addFavorite(HotelModel hotel) {
    return localDataSource.addFavorite(hotel);
  }

  @override
  List<HotelFavorite> getFavorites() {
    return localDataSource.getFavorites();
  }

  @override
  Future<void> removeFavorite(String hotelId) {
    return localDataSource.removeFavorite(hotelId);
  }

  @override
  Stream<List<HotelFavorite>> watchFavorites() {
    return localDataSource.watchFavorites();
  }
}
