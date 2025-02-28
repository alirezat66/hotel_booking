import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_ui_package/hotel_card/widgets/info/general/hotel_general_info_widget.dart';
import 'package:hotel_ui_package/hotel_card/widgets/rate/rate_star_widget.dart';
import 'package:hotel_ui_package/theme/theme.dart';

void main() {
  testWidgets('HotelGeneralInfoWidget displays correct information', (WidgetTester tester) async {
    // Define the test data
    final score = 4.5;
    final hotelName = 'Hotel Paradise';
    final hotelAddress = '123 Paradise Road, Heaven City';
    final onMoreInfoTab = () {};

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        theme: HotelBookingTheme.lightTheme,
        home: Scaffold(
          body: HotelGeneralInfoWidget(
            score: score,
            hotelName: hotelName,
            hotelAddress: hotelAddress,
            onMoreInfoTab: onMoreInfoTab,
          ),
        ),
      ),
    );

    // Verify that the information is displayed correctly
    expect(find.text(hotelName), findsOneWidget);
    expect(find.text(hotelAddress), findsOneWidget);
    expect(find.byType(RateStarWidget), findsOneWidget);
  });
}
