import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_ui_package/view/hotel_card/widgets/info_row_widget.dart';
import 'package:hotel_ui_package/hotel_ui_package.dart';

void main() {
  testWidgets('InfoRowWidget displays items correctly',
      (WidgetTester tester) async {
    // Define the test items
    final items = ['Item 1', 'Item 2', 'Item 3'];

    // Build the InfoRowWidget
    await tester.pumpWidget(
      MaterialApp(
        theme: HotelBookingTheme.lightTheme,
        home: Scaffold(
          body: InfoRowWidget(items: items),
        ),
      ),
    );

    // Verify if the items are displayed correctly
    expect(find.text('Item 1 | Item 2 | Item 3'), findsOneWidget);
  });
}
