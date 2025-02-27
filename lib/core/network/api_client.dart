import 'package:hotel_booking/core/network/network_response.dart';

abstract class ApiClient {
  Future<NetworkResponse> get(String path,
      {Map<String, dynamic>? queryParameters});
}
