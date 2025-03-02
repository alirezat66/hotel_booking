import 'package:flutter/material.dart';
import 'package:hotel_ui_package/hotel_ui_package.dart';
import 'package:hotel_ui_package/models/translate_strings.dart';
import 'package:widgetbook/widgetbook.dart';

WidgetbookComponent getCards() {
  return WidgetbookComponent(
    name: 'Cards',
    useCases: [
      WidgetbookUseCase(
        name: 'Detailed Card',
        builder: (context) => Material(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _DetailedCardWithState(
                  // Pass initial values from knobs if needed, but we'll manage most via state
                  ),
            ),
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'Composed Card',
        builder: (context) => Material(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _ComposedCardWithState(
                  // Pass initial values from knobs if needed, but we'll manage most via state
                  ),
            ),
          ),
        ),
      ),
    ],
  );
}

class _DetailedCardWithState extends StatefulWidget {
  @override
  _DetailedCardWithStateState createState() => _DetailedCardWithStateState();
}

class _DetailedCardWithStateState extends State<_DetailedCardWithState> {
  late bool isLiked = false; // Will be set via knob in build

  @override
  Widget build(BuildContext context) {
    // Configure all HotelData properties with knobs

    final score = context.knobs.double.slider(
      label: 'Score',
      initialValue: 4.1,
      min: 0.0,
      max: 5.0,
      divisions: 50,
      description: 'Hotel rating score',
    );

    final reviewCount = context.knobs.int.input(
      label: 'Review Count',
      initialValue: 253,
      description: 'Number of reviews',
    );

    final scoreDescription = context.knobs.string(
      label: 'Score Description',
      initialValue: 'Sehr Gut',
      description: 'Description of the score (e.g., Very Good)',
    );

    final name = context.knobs.string(
      label: 'Hotel Name',
      initialValue: 'Las Palmas',
      description: 'Name of the hotel',
    );

    final destination = context.knobs.string(
      label: 'Destination',
      initialValue: 'Colombian, Las Palmas',
      description: 'Hotel location',
    );

    final days = context.knobs.int.input(
      label: 'Days',
      initialValue: 12,
      description: 'Number of days for the stay',
    );

    final nights = context.knobs.int.input(
      label: 'Nights',
      initialValue: 11,
      description: 'Number of nights for the stay',
    );

    final kids = context.knobs.int.input(
      label: 'Kids',
      initialValue: 1,
      description: 'Number of kids',
    );

    final adults = context.knobs.int.input(
      label: 'Adults',
      initialValue: 2,
      description: 'Number of adults',
    );

    final isFlightIncluded = context.knobs.boolean(
      label: 'Flight Included',
      initialValue: true,
      description: 'Whether flight is included in the package',
    );

    final overallName = context.knobs.string(
      label: 'Overall Name',
      initialValue: 'Doppelzimmer',
      description: 'Type of room or package',
    );

    final overallBoarding = context.knobs.string(
      label: 'Overall Boarding',
      initialValue: 'Frühstück',
      description: 'Boarding type (e.g., Breakfast)',
    );

    final travelPrice = context.knobs.double.input(
      label: 'Travel Price',
      initialValue: 1279,
      description: 'Total price of the travel package',
    );

    final pricePerPerson = context.knobs.double.input(
      label: 'Price Per Person',
      initialValue: 319.75,
      description: 'Price per person',
    );

    final imageUrl = context.knobs.string(
      label: 'Image URL',
      initialValue:
          'https://images.unsplash.com/photo-1506744038136-46273834b3fb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8&w=1000&q=80',
      description: 'URL of the hotel image',
    );

    bool hasMoreOneOffer = context.knobs.boolean(
      label: 'More than one offer',
      initialValue: false,
      description: 'Whether there are more than one offer',
    );

    final currency = context.knobs.string(
      label: 'Currency',
      initialValue: 'EUR',
      description: 'Currency (e.g., EUR, USD)',
    );
    final dayText = context.knobs.string(
      label: 'Day Text',
      initialValue: 'Tage',
      description: 'Day Text (e.g., Days, Tage)',
    );

    final nightText = context.knobs.string(
      label: 'Night Text',
      initialValue: 'Nächte',
      description: 'Night Text (e.g., Nights, Nächte)',
    );

    final fromText = context.knobs.string(
      label: 'From Text',
      initialValue: 'ab',
      description: 'From Text (e.g., from, ab)',
    );

    final flightText = context.knobs.string(
      label: 'Flight Text',
      initialValue: 'inkl. Flug',
      description: 'Flight Text (e.g., incl. Flight, inkl. Flug)',
    );

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        HotelCard(
          cardType: HotelCardType.detailed,
          onActionPressed: () {
            // Optional: Add a knob to toggle this action
            print('Action pressed');
          },
          onFavoriteChanged: (bool newValue) {
            setState(() {
              isLiked = newValue; // Update state and trigger rebuild
            });
          },
          hotel: HotelData(
              score: score,
              reviewCount: reviewCount,
              scoreDescription: scoreDescription,
              name: name,
              destination: destination,
              days: days,
              nights: nights,
              kids: kids,
              adults: adults,
              isFlightIncluded: isFlightIncluded,
              isLiked: isLiked, // Dynamically updated via setState
              overallName: overallName,
              overallBoarding: overallBoarding,
              travelPrice: travelPrice,
              pricePerPerson: pricePerPerson,
              imageUrl: imageUrl,
              hasMoreOneOffer: hasMoreOneOffer,
              translateStrings: TranslateStrings(
                currency: currency,
                dayText: dayText,
                nightText: nightText,
                fromText: fromText,
                flightText: flightText,
              )),
        ),
      ],
    );
  }
}

class _ComposedCardWithState extends StatefulWidget {
  @override
  _ComposedCardWithStateState createState() => _ComposedCardWithStateState();
}

class _ComposedCardWithStateState extends State<_ComposedCardWithState> {
  late bool isLiked = false; // Will be set via knob in build

  @override
  Widget build(BuildContext context) {
    // Configure all HotelData properties with knobs

    final score = context.knobs.double.slider(
      label: 'Score',
      initialValue: 4.1,
      min: 0.0,
      max: 5.0,
      divisions: 50,
      description: 'Hotel rating score',
    );

    final reviewCount = context.knobs.int.input(
      label: 'Review Count',
      initialValue: 253,
      description: 'Number of reviews',
    );

    final scoreDescription = context.knobs.string(
      label: 'Score Description',
      initialValue: 'Sehr Gut',
      description: 'Description of the score (e.g., Very Good)',
    );

    final name = context.knobs.string(
      label: 'Hotel Name',
      initialValue: 'Las Palmas',
      description: 'Name of the hotel',
    );

    final destination = context.knobs.string(
      label: 'Destination',
      initialValue: 'Colombian, Las Palmas',
      description: 'Hotel location',
    );

    final days = context.knobs.int.input(
      label: 'Days',
      initialValue: 12,
      description: 'Number of days for the stay',
    );

    final nights = context.knobs.int.input(
      label: 'Nights',
      initialValue: 11,
      description: 'Number of nights for the stay',
    );

    final kids = context.knobs.int.input(
      label: 'Kids',
      initialValue: 1,
      description: 'Number of kids',
    );

    final adults = context.knobs.int.input(
      label: 'Adults',
      initialValue: 2,
      description: 'Number of adults',
    );

    final isFlightIncluded = context.knobs.boolean(
      label: 'Flight Included',
      initialValue: true,
      description: 'Whether flight is included in the package',
    );

    final overallName = context.knobs.string(
      label: 'Overall Name',
      initialValue: 'Doppelzimmer',
      description: 'Type of room or package',
    );

    final overallBoarding = context.knobs.string(
      label: 'Overall Boarding',
      initialValue: 'Frühstück',
      description: 'Boarding type (e.g., Breakfast)',
    );

    final travelPrice = context.knobs.double.input(
      label: 'Travel Price',
      initialValue: 1279,
      description: 'Total price of the travel package',
    );

    final pricePerPerson = context.knobs.double.input(
      label: 'Price Per Person',
      initialValue: 319.75,
      description: 'Price per person',
    );

    final imageUrl = context.knobs.string(
      label: 'Image URL',
      initialValue:
          'https://images.unsplash.com/photo-1506744038136-46273834b3fb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8&w=1000&q=80',
      description: 'URL of the hotel image',
    );

    bool hasMoreOneOffer = context.knobs.boolean(
      label: 'More than one offer',
      initialValue: false,
      description: 'Whether there are more than one offer',
    );

    final currency = context.knobs.string(
      label: 'Currency',
      initialValue: 'EUR',
      description: 'Currency (e.g., EUR, USD)',
    );
    final dayText = context.knobs.string(
      label: 'Day Text',
      initialValue: 'Tage',
      description: 'Day Text (e.g., Days, Tage)',
    );

    final nightText = context.knobs.string(
      label: 'Night Text',
      initialValue: 'Nächte',
      description: 'Night Text (e.g., Nights, Nächte)',
    );

    final fromText = context.knobs.string(
      label: 'From Text',
      initialValue: 'ab',
      description: 'From Text (e.g., from, ab)',
    );

    final flightText = context.knobs.string(
      label: 'Flight Text',
      initialValue: 'inkl. Flug',
      description: 'Flight Text (e.g., incl. Flight, inkl. Flug)',
    );

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        HotelCard(
          cardType: HotelCardType.compact,
          onActionPressed: () {
            // Optional: Add a knob to toggle this action
            print('Action pressed');
          },
          onFavoriteChanged: (bool newValue) {
            setState(() {
              isLiked = newValue; // Update state and trigger rebuild
            });
          },
          hotel: HotelData(
              score: score,
              reviewCount: reviewCount,
              scoreDescription: scoreDescription,
              name: name,
              destination: destination,
              days: days,
              nights: nights,
              kids: kids,
              adults: adults,
              isFlightIncluded: isFlightIncluded,
              isLiked: isLiked, // Dynamically updated via setState
              overallName: overallName,
              overallBoarding: overallBoarding,
              travelPrice: travelPrice,
              pricePerPerson: pricePerPerson,
              imageUrl: imageUrl,
              hasMoreOneOffer: hasMoreOneOffer,
              translateStrings: TranslateStrings(
                currency: currency,
                dayText: dayText,
                nightText: nightText,
                fromText: fromText,
                flightText: flightText,
              )),
        ),
      ],
    );
  }
}
