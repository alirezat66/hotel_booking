import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_ui_package/view/hotel_cart/widgets/info/detail/price_widget.dart';
import 'package:hotel_ui_package/theme/theme.dart';

void main() {
  testWidgets('PriceWidget displays total and per person prices correctly',
      (WidgetTester tester) async {
    // Define the test data
    final totalPrice = 500.0;
    final perPersonPrice = 250.0;
    final currency = 'USD';
    final fromText = 'From';

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        theme: HotelBookingTheme.lightTheme,
        locale: const Locale('en', 'US'),
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('de', 'DE'),
        ],
        home: Scaffold(
          body: PriceWidget(
            totalPrice: totalPrice,
            perPersonPrice: perPersonPrice,
            currency: currency,
            fromText: fromText,
          ),
        ),
      ),
    );

    // Verify that the total price and per person price are displayed correctly
    expect(find.text('From \$500.00'), findsOneWidget);
    expect(find.text('\$250.00 p.P.'), findsOneWidget);
  });

  testWidgets(
      'PriceWidget displays total price without fromText when hasMoreOneOffer is false',
      (WidgetTester tester) async {
    // Define the test data
    final totalPrice = 500.0;
    final perPersonPrice = 250.0;
    final currency = 'EUR';

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        theme: HotelBookingTheme.lightTheme,
        locale: const Locale('de', 'DE'),
        supportedLocales: const [
          Locale('de', 'DE'),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: Scaffold(
          body: PriceWidget(
            totalPrice: totalPrice,
            perPersonPrice: perPersonPrice,
            currency: currency,
          ),
        ),
      ),
    );
    // Show all texts that can be found on the screen
    final textWidgets = find.byType(Text);
    final textList = <String>[];
    textWidgets.evaluate().forEach((element) {
      final textWidget = element.widget as Text;
      textList.add(textWidget.data ?? '');
    });
    print(textList);
    // Verify that the total price and per person price are displayed correctly
    expect(find.text('250,00 € p.P.'), findsOneWidget);
    expect(find.text('500,00 €'), findsOneWidget);
  });
}
