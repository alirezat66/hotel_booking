import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_ui_package/hotel_card/widgets/info/detail/travel_info_widget.dart';
import 'package:hotel_ui_package/hotel_card/widgets/info_row_widget.dart';

void main() {
  testWidgets('TravelInfoWidget displays date, room, and overall info', (WidgetTester tester) async {
    // Define the test data
    final dateInfo = ['Check-in: Jan 1', 'Check-out: Jan 5'];
    final roomInfo = ['Room: Deluxe', 'Guests: 2'];
    final overallInfo = ['Total: \$500'];

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TravelInfoWidget(
            dateInfo: dateInfo,
            roomInfo: roomInfo,
            overallInfo: overallInfo,
          ),
        ),
      ),
    );

    // Verify that the InfoRowWidgets are displayed with the correct concatenated text
    expect(find.byType(InfoRowWidget), findsNWidgets(3));
    expect(find.text('Check-in: Jan 1 | Check-out: Jan 5'), findsOneWidget);
    expect(find.text('Room: Deluxe | Guests: 2'), findsOneWidget);
    expect(find.text('Total: \$500'), findsOneWidget);
  });
}
