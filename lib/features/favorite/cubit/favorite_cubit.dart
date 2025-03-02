import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/data/favorite_repository.dart';
import 'package:hotel_booking/features/favorite/data/hotel_favorite.dart';
import 'package:hotel_booking/features/hotels/data/models/hotel.dart';

class FavoriteCubit extends Cubit<List<HotelFavorite>> {
  final FavoriteRepository favoriteRepository;
  StreamSubscription<List<HotelFavorite>>? _favoriteSubscription;
  FavoriteCubit(FavoriteRepository repository)
      : favoriteRepository = repository,
        super(repository.getFavorites()) {
    _subscribeToFavorite();
  }

  void _subscribeToFavorite() {
    _favoriteSubscription =
        favoriteRepository.watchFavorites().listen((list) => emit(list));
  }

  void addFavorite(Hotel hotel) async {
    await favoriteRepository.addFavorite(hotel);
  }

  void removeFavorite(String hotelId) async {
    await favoriteRepository.removeFavorite(hotelId);
  }

  @override
  Future<void> close() {
    _favoriteSubscription?.cancel();
    return super.close();
  }
}
