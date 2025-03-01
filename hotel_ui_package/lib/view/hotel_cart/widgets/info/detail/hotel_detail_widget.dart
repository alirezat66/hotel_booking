import 'package:flutter/material.dart';
import 'package:hotel_ui_package/view/hotel_cart/widgets/info/detail/price_widget.dart';
import 'package:hotel_ui_package/view/hotel_cart/widgets/info/detail/travel_info_widget.dart';

class HotelDetailWidget extends StatelessWidget {
  final int days;
  final int nights;

  final String overallName;
  final String overallBoarding;

  final int kids;
  final int adults;
  final bool isFlightIncluded;

  final double totalPrice;
  final double perPersonPrice;
  final bool hasMoreOneOffer;
  final String currency;

  final String fromText;
  final String nightText;
  final String dayText;
  final String includeFlightText;
  const HotelDetailWidget({
    super.key,
    required this.days,
    required this.nights,
    required this.overallName,
    required this.overallBoarding,
    required this.kids,
    required this.adults,
    required this.isFlightIncluded,
    required this.totalPrice,
    required this.perPersonPrice,
    required this.hasMoreOneOffer,
    required this.currency,
    this.fromText = 'ab',
    this.nightText = 'Nächte',
    this.dayText = 'Tage',
    this.includeFlightText = 'inkl. Flug',
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TravelInfoWidget(dateInfo: [
              '$days $dayText',
              '$nights $nightText',
            ], roomInfo: [
              overallName,
              overallBoarding
            ], overallInfo: [
              '$adults Erw., $kids Kinder',
              if (isFlightIncluded) includeFlightText
            ],),
          ),
          PriceWidget(
            perPersonPrice: perPersonPrice,
            totalPrice: totalPrice,
            currency: currency,
            fromText: hasMoreOneOffer ? fromText : null,
          )
        ],
      ),
    );
  }
}
