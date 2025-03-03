import 'package:hotel_booking/features/hotels/data/datasource/remote_data_source.dart';
import 'package:hotel_booking/features/hotels/data/models/hotel_response.dart';
import 'package:hotel_booking/features/hotels/domain/repository/hotel_repository.dart';

class HotelRepositoryImpl implements HotelRepository {
  final RemoteDataSource remote;
  HotelRepositoryImpl(this.remote);
  @override
  Future<HotelResponse> getHotels() => remote.getHotels();
}
