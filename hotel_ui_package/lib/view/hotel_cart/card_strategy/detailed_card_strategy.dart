import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hotel_ui_package/hotel_ui_package.dart';
import 'package:hotel_ui_package/models/translate_strings.dart';
import 'package:hotel_ui_package/view/hotel_cart/card_strategy/card_strategy.dart';

class DetailedCardStrategy implements CardStrategy {
  @override
  Widget build(HotelData hotel,
      {Function(bool)? onFavoriteChanged,
      VoidCallback? onActionPressed,
      VoidCallback? onMoreInfoTab}) {
    final translateString = hotel.translateStrings ?? TranslateStrings();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HotelImageView(
          url: hotel.imageUrl,
          favoriteWidget: FavoriteWidget(
            initialState: hotel.isLiked,
            onLikeChanged: onFavoriteChanged,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HotelGeneralInfoWidget(
                hotelName: hotel.name,
                destination: hotel.destination,
                score: hotel.score,
                onMoreInfoTab: onMoreInfoTab,
              ),
              const Gap(16),
              const Divider(),
              const Gap(16),
              HotelDetailWidget(
                days: hotel.days,
                nights: hotel.nights,
                overallName: hotel.overallName,
                overallBoarding: hotel.overallBoarding,
                kids: hotel.days,
                adults: hotel.adults,
                isFlightIncluded: hotel.isFlightIncluded,
                totalPrice: hotel.travelPrice,
                perPersonPrice: hotel.pricePerPerson,
                hasMoreOneOffer: hotel.hasMoreOneOffer,
                currency: translateString.currency,
                dayText: translateString.dayText,
                nightText: translateString.nightText,
                fromText: translateString.fromText,
                includeFlightText: translateString.flightText,
              ),
              const Gap(16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: onActionPressed,
                    child: const Text('Zu den Angeboten')),
              ),
            ],
          ),
        )
      ],
    );
  }
}
