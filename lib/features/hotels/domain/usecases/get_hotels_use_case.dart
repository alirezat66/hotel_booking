import 'package:hotel_booking/features/hotels/data/models/hotel_response.dart';
import 'package:hotel_booking/features/hotels/domain/repository/hotel_repository.dart';

class GetHotelsUseCase {
  final HotelRepository repository;
  GetHotelsUseCase(this.repository);
  Future<HotelResponse> call() => repository.getHotels();
}
