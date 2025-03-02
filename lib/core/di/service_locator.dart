import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hotel_booking/core/network/api_client.dart';
import 'package:hotel_booking/core/network/config/client_config.dart';
import 'package:hotel_booking/core/network/dio_client.dart';
import 'package:hotel_booking/features/hotels/cubit/hotel_cubit.dart';
import 'package:hotel_booking/features/hotels/data/repository/hotel_repository.dart';
import 'package:hotel_booking/features/hotels/data/repository/remote_hotel_repository_impl.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final locator = GetIt.instance;

class ServiceLocator {
  static void setup() {
    _registerNetwork();
    _registerHotel();
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
}
