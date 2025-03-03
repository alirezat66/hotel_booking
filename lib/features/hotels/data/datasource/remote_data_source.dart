import 'package:easy_localization/easy_localization.dart';
import 'package:hotel_booking/core/network/api_client.dart';
import 'package:hotel_booking/features/hotels/data/models/hotel_response.dart';

class RemoteDataSource {
  final ApiClient client;

  RemoteDataSource({required this.client});

  Future<HotelResponse> getHotels() async {
    final response = await client.get('/hotels.json');

    if (response.statusCode == 200) {
      if (response.data is Map<String, dynamic>) {
        final hotelResponse = HotelResponse.fromJson(response.data);
        return hotelResponse;
      } else {
        throw Exception('invalidResponseFormat'.tr());
      }
    } else {
      throw Exception(response.errorMessage ?? 'failedToFetch'.tr());
    }
  }
}
