/* import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_booking/core/network/network_response.dart';
import 'package:mockito/mockito.dart';
import 'package:hotel_booking/features/hotels/data/datasource/remote_data_source.dart';
import 'package:hotel_booking/features/hotels/data/models/hotel_response.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  late RemoteDataSource remoteDataSource;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    remoteDataSource = RemoteDataSource(client: mockApiClient);
  });

  group('getHotels', () {
    final stringResponse = fixture('hotel_response.json');
    final responseJson = json.decode(stringResponse);
    test('should return HotelResponse when the call to the API is successful',
        () async {
      when(mockApiClient.get(any)).thenAnswer((_) async => NetworkResponse(
            statusCode: 200,
            data: responseJson,
          ));

      final result = await remoteDataSource.getHotels();

      expect(result, isA<HotelResponse>());
      verify(mockApiClient.get('/hotels.json'));
    });

    test('should throw an exception when the response format is invalid',
        () async {
      when(mockApiClient.get(any)).thenAnswer((_) async => NetworkResponse(
            statusCode: 200,
            data: [],
          ));

      expect(() => remoteDataSource.getHotels(), throwsException);
      verify(mockApiClient.get('/hotels.json'));
    });

    test('should throw an exception when the call to the API fails', () async {
      when(mockApiClient.get(any)).thenAnswer((_) async => NetworkResponse(
            statusCode: 404,
            errorMessage: 'Not Found',
          ));

      expect(() => remoteDataSource.getHotels(), throwsException);
      verify(mockApiClient.get('/hotels.json'));
    });
  });
}
 */