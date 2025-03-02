import 'package:hotel_booking/features/hotels/data/hotel.dart';

class HotelResponse {
  final List<Hotel> hotels;
  final int hotelCount;

  HotelResponse({
    required this.hotels,
    required this.hotelCount,
  });

  factory HotelResponse.fromJson(Map<String, dynamic> json) {
    return HotelResponse(
      hotels: (json['hotels'] as List<dynamic>)
          .map((hotel) => Hotel.fromJson(hotel))
          .toList(),
      hotelCount: json['hotel-count'],
    );
  }
}
