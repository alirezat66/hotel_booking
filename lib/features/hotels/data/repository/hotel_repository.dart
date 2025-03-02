import 'package:hotel_booking/features/hotels/data/models/hotel_response.dart';

abstract class HotelRepository {
  Future<HotelResponse> getHotels();
}
