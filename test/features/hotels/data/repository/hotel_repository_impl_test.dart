import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_booking/features/hotels/data/datasource/remote_data_source.dart';
import 'package:hotel_booking/features/hotels/data/models/hotel_response.dart';
import 'package:hotel_booking/features/hotels/data/repository/hotel_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'hotel_repository_impl_test.mocks.dart';

@GenerateMocks([RemoteDataSource])
void main() {
  late HotelRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    repository = HotelRepositoryImpl(mockRemoteDataSource);
  });

  group('getHotels', () {
    final stringResponse = fixture('hotel_response.json');
    final responseJson = json.decode(stringResponse);
    final hotelResponse = HotelResponse.fromJson(responseJson);

    test(
        'should return HotelResponse when the call to remote data source is successful',
        () async {
      when(mockRemoteDataSource.getHotels())
          .thenAnswer((_) async => hotelResponse);

      final result = await repository.getHotels();

      expect(result, isA<HotelResponse>());
      verify(mockRemoteDataSource.getHotels());
    });

    test('should throw an exception when the call to remote data source fails',
        () async {
      when(mockRemoteDataSource.getHotels())
          .thenThrow(Exception('Failed to fetch'));

      expect(() => repository.getHotels(), throwsException);
      verify(mockRemoteDataSource.getHotels());
    });
  });
}
