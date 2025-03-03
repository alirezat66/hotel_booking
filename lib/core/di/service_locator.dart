import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hotel_booking/features/favorite/data/datasource/local_data_source.dart';
import 'package:hotel_booking/core/network/api_client.dart';
import 'package:hotel_booking/core/network/config/client_config.dart';
import 'package:hotel_booking/core/network/dio_client.dart';
import 'package:hotel_booking/features/account/bloc/locale_bloc.dart';
import 'package:hotel_booking/features/account/bloc/theme_bloc.dart';
import 'package:hotel_booking/features/favorite/data/repository/favorite_repository_impl.dart';
import 'package:hotel_booking/features/favorite/domain/repository/favorite_repository.dart';
import 'package:hotel_booking/features/favorite/domain/usecase/add_favorite_use_case.dart';
import 'package:hotel_booking/features/favorite/domain/usecase/get_favorites_use_case.dart';
import 'package:hotel_booking/features/favorite/domain/usecase/remove_favorite_use_case.dart';
import 'package:hotel_booking/features/favorite/domain/usecase/watch_use_case.dart';
import 'package:hotel_booking/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:hotel_booking/features/favorite/data/model/hotel_favorite.dart';
import 'package:hotel_booking/features/hotels/domain/repository/hotel_repository.dart';
import 'package:hotel_booking/features/hotels/domain/usecases/get_hotels_use_case.dart';
import 'package:hotel_booking/features/hotels/presentation/cubit/hotel_cubit.dart';
import 'package:hotel_booking/features/hotels/data/repository/hotel_repository_impl.dart';
import 'package:hotel_booking/features/hotels/data/datasource/remote_data_source.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:path_provider/path_provider.dart';

final locator = GetIt.instance;

class ServiceLocator {
  static Future<void> setup() async {
    _registerNetwork();
    _registerHotel();
    await _registerLocalStorage();
    await _registerHydratedBloc();
  }

  static void _registerHotel() {
    locator.registerLazySingleton<RemoteDataSource>(
        () => RemoteDataSource(client: locator<ApiClient>()));
    locator.registerLazySingleton<HotelRepository>(
      () => HotelRepositoryImpl(
        locator<RemoteDataSource>(),
      ),
    );
    locator.registerLazySingleton<GetHotelsUseCase>(
        () => GetHotelsUseCase(locator<HotelRepository>()));
    locator.registerFactory(() => HotelCubit(locator<GetHotelsUseCase>()));
  }

  static void _registerNetwork() {
    locator.registerLazySingleton(() => ClientConfig.baseOptions);
    locator.registerLazySingleton(() => ClientConfig.createDio());
    locator.registerLazySingleton(() => ClientConfig.logger);
    locator.registerLazySingleton<ApiClient>(
        () => DioApiClient(locator<Dio>(), locator<PrettyDioLogger>()));
  }

  static _registerLocalStorage() async {
    await Hive.initFlutter();
    Hive.registerAdapter(HotelFavoriteAdapter());
    Hive.registerAdapter(HotelRatingInfoAdapter());
    await Hive.openBox<HotelFavorite>('favorites');

    locator.registerLazySingleton<Box<HotelFavorite>>(
      () => Hive.box<HotelFavorite>('favorites'),
    );

    locator.registerLazySingleton<LocalDataSource>(
        () => LocalDataSource(locator<Box<HotelFavorite>>()));

    locator.registerLazySingleton<FavoriteRepository>(
        () => FavoriteRepositoryImpl(locator<LocalDataSource>()));

    locator.registerLazySingleton<AddFavoriteUseCase>(
        () => AddFavoriteUseCase(locator<FavoriteRepository>()));
    locator.registerLazySingleton<RemoveFavoriteUseCase>(
        () => RemoveFavoriteUseCase(locator<FavoriteRepository>()));
    locator.registerLazySingleton<GetFavoriteUseCase>(
        () => GetFavoriteUseCase(locator<FavoriteRepository>()));
    locator.registerLazySingleton<WatchFavoriteUseCase>(
        () => WatchFavoriteUseCase(locator<FavoriteRepository>()));

    locator.registerFactory<FavoriteCubit>(() => FavoriteCubit(
        addFavoriteUseCase: locator<AddFavoriteUseCase>(),
        removeFavoriteUseCase: locator<RemoveFavoriteUseCase>(),
        getFavoriteUseCase: locator<GetFavoriteUseCase>(),
        watchFavoriteUseCase: locator<WatchFavoriteUseCase>()));
  }

  static _registerHydratedBloc() async {
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorageDirectory.web
          : HydratedStorageDirectory((await getTemporaryDirectory()).path),
    );
    locator.registerFactory<LocaleBloc>(() => LocaleBloc());

    locator.registerFactory<ThemeBloc>(() => ThemeBloc());
  }
}
