import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_ui_package/view/hotel_card/widgets/info/detail/hotel_detail_widget.dart';
import 'package:hotel_ui_package/theme/theme.dart';
import 'package:intl/intl.dart';

void main() {
  testWidgets('HotelDetailWidget displays correct information',
      (WidgetTester tester) async {
    // Define the test data
    final days = 5;
    final nights = 4;
    final overallName = 'Hotel Paradise';
    final overallBoarding = 'All Inclusive';
    final kids = 2;
    final adults = 2;
    final isIncludeFlight = true;
    final totalPrice = 2000.0;
    final perPersonPrice = 500.0;
    final hasMoreOneOffer = true;
    final currency = 'USD';
    final fromText = 'From';
    final nightText = 'Nights';
    final dayText = 'Days';
    final includeFlightText = 'incl. Flight';

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        theme: HotelBookingTheme.lightTheme,
        locale: const Locale('en', 'US'),
        home: Scaffold(
          body: HotelDetailWidget(
            days: days,
            nights: nights,
            overallName: overallName,
            overallBoarding: overallBoarding,
            kids: kids,
            adults: adults,
            isFlightIncluded: isIncludeFlight,
            totalPrice: totalPrice,
            perPersonPrice: perPersonPrice,
            hasMoreOneOffer: hasMoreOneOffer,
            currency: currency,
            fromText: fromText,
            nightText: nightText,
            dayText: dayText,
            includeFlightText: includeFlightText,
          ),
        ),
      ),
    );

    // Format the prices according to the locale and currency
    final formattedTotalPrice = NumberFormat.currency(
      locale: 'en_US',
      symbol: '\$',
      decimalDigits: 2,
    ).format(totalPrice);

    final formattedPerPersonPrice = NumberFormat.currency(
      locale: 'en_US',
      symbol: '\$',
      decimalDigits: 2,
    ).format(perPersonPrice);

    // Verify that the information is displayed correctly
    expect(find.text('$days $dayText | $nights $nightText'), findsOneWidget);
    expect(find.text('$overallName | $overallBoarding'), findsOneWidget);
    expect(find.text('$adults Erw., $kids Kinder | $includeFlightText'),
        findsOneWidget);
    expect(find.text('From $formattedTotalPrice'), findsOneWidget);
    expect(find.text('$formattedPerPersonPrice p.P.'), findsOneWidget);
  });
}
