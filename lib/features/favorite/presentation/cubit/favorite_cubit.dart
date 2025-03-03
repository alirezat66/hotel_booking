import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/favorite/data/model/hotel_favorite.dart';
import 'package:hotel_booking/features/favorite/domain/usecase/add_favorite_use_case.dart';
import 'package:hotel_booking/features/favorite/domain/usecase/get_favorites_use_case.dart';
import 'package:hotel_booking/features/favorite/domain/usecase/remove_favorite_use_case.dart';
import 'package:hotel_booking/features/favorite/domain/usecase/watch_use_case.dart';
import 'package:hotel_booking/features/hotels/data/models/hotel_model.dart';

class FavoriteCubit extends Cubit<List<HotelFavorite>> {
  final AddFavoriteUseCase addFavoriteUseCase;
  final RemoveFavoriteUseCase removeFavoriteUseCase;
  final GetFavoriteUseCase getFavoriteUseCase;
  final WatchFavoriteUseCase watchFavoriteUseCase;
  StreamSubscription<List<HotelFavorite>>? _favoriteSubscription;
  FavoriteCubit(
      {required this.addFavoriteUseCase,
      required this.removeFavoriteUseCase,
      required this.getFavoriteUseCase,
      required this.watchFavoriteUseCase})
      : super(getFavoriteUseCase.call()) {
    _subscribeToFavorite();
  }

  void _subscribeToFavorite() {
    _favoriteSubscription = watchFavoriteUseCase.call().listen((list) {
      list.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      emit(list);
    });
  }

  void addFavorite(HotelModel hotel) async {
    await addFavoriteUseCase.call(hotel);
  }

  void removeFavorite(String hotelId) async {
    await removeFavoriteUseCase.call(hotelId);
  }

  @override
  Future<void> close() {
    _favoriteSubscription?.cancel();
    return super.close();
  }
}
