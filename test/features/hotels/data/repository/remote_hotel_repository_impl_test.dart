import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_booking/core/network/network_response.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:hotel_booking/core/network/api_client.dart';
import 'package:hotel_booking/features/hotels/data/models/hotel_response.dart';
import 'package:hotel_booking/features/hotels/data/repository/remote_hotel_repository_impl.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'remote_hotel_repository_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late RemoteHotelRepositoryImpl repository;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    repository = RemoteHotelRepositoryImpl(client: mockApiClient);
  });

  group('getHotels', () {
    test('should return HotelResponse when the call to the API is successful',
        () async {
      // Arrange
      final fixtureData = jsonFixture('hotel_response.json');
      when(mockApiClient.get(any)).thenAnswer(
          (_) async => NetworkResponse(data: fixtureData, statusCode: 200));

      // Act
      final result = await repository.getHotels();

      // Assert
      expect(result, isA<HotelResponse>());
      verify(mockApiClient.get('/hotels.json'));
    });

    test(
        'should throw an exception with error message when the API returns a non-200 status code',
        () async {
      // Arrange
      when(mockApiClient.get(any)).thenAnswer((_) async => NetworkResponse(
            data: 'Error', // This could be anything, as it won’t be parsed
            statusCode: 404,
            errorMessage: 'Not Found',
          ));

      // Act
      final call = repository.getHotels();

      // Assert
      expect(
        call,
        throwsA(isA<Exception>()
            .having((e) => e.toString(), 'message', 'Exception: Not Found')),
      );
      verify(mockApiClient.get('/hotels.json'));
    });
  });
}
