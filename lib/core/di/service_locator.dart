import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hotel_booking/core/network/api_client.dart';
import 'package:hotel_booking/core/network/config/client_config.dart';
import 'package:hotel_booking/core/network/dio_client.dart';
import 'package:hotel_booking/features/favorite/data/hotel_favorite.dart';
import 'package:hotel_booking/features/hotels/cubit/hotel_cubit.dart';
import 'package:hotel_booking/features/hotels/data/repository/hotel_repository.dart';
import 'package:hotel_booking/features/hotels/data/repository/remote_hotel_repository_impl.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final locator = GetIt.instance;

class ServiceLocator {
  static Future<void> setup() async {
    _registerNetwork();
    _registerHotel();
    await _registerLocalStorage();
  }

  static void _registerHotel() {
    locator.registerLazySingleton<HotelRepository>(
      () => RemoteHotelRepositoryImpl(
        client: locator<ApiClient>(),
      ),
    );
    locator.registerFactory(() => HotelCubit(locator<HotelRepository>()));
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
  }
}
