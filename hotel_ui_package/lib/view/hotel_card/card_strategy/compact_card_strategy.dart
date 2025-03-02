import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hotel_ui_package/hotel_ui_package.dart';
import 'package:hotel_ui_package/models/hotel_data.dart';
import 'package:hotel_ui_package/view/hotel_card/card_strategy/card_strategy.dart';

class CompactCardStrategy implements CardStrategy {
  @override
  Widget build(HotelData hotel,
      {Function(bool)? onFavoriteChanged,
      VoidCallback? onActionPressed,
      VoidCallback? onMoreInfoTab}) {
    return Column(
      children: [
        HotelImageView(
          url: hotel.imageUrl,
          favoriteWidget: FavoriteWidget(
            initialState: hotel.isLiked,
            onLikeChanged: onFavoriteChanged,
          ),
          rateWidget: RateWidget(
            score: hotel.score,
            reviewCount: hotel.reviewCount,
            scoreDescription: hotel.scoreDescription,
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
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: onActionPressed, child: const Text('Zum Hotel')),
              ),
            ],
          ),
        )
      ],
    );
  }
}
