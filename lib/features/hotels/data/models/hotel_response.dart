import 'package:hotel_booking/features/hotels/data/models/hotel_model.dart';

class HotelResponse {
  final List<HotelModel> hotels;
  final int hotelCount;

  HotelResponse({
    required this.hotels,
    required this.hotelCount,
  });

  factory HotelResponse.fromJson(Map<String, dynamic> json) {
    return HotelResponse(
      hotels: (json['hotels'] as List<dynamic>)
          .map((hotel) => HotelModel.fromJson(hotel))
          .toList(),
      hotelCount: json['hotel-count'],
    );
  }
}
