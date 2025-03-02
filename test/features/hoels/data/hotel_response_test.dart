import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_booking/features/hotels/data/hotel_response.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  test('HotelResponse fromJson', () {
    final jsonResponse = fixture('hotel_response.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonResponse);
    final hotelResponse = HotelResponse.fromJson(jsonMap);

    expect(hotelResponse.hotelCount, 998);
    expect(hotelResponse.hotels.length, 2);

    final hotel1 = hotelResponse.hotels[0];
    expect(hotel1.name, "Can Picafort Palace");
    expect(hotel1.images[0],
        "https://image-resizer.prod.invia-travel.io/images/multicode/35489/org/hotel35489-5ee7c256-dc48-4e95-8ad1-fdf77077a992.jpeg");

    final hotel2 = hotelResponse.hotels[1];
    expect(hotel2.name, "Blau Punta Reina");
    expect(hotel2.images[0],
        "https://image-resizer.prod.invia-travel.io/images/xmldata/3140/org/hotel3140-a9239eec-f4df-4860-8f84-c72f2ab55810.jpeg");
  });
}
