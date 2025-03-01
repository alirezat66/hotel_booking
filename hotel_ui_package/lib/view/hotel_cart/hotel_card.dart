import 'package:flutter/material.dart';
import 'package:hotel_ui_package/hotel_ui_package.dart';
import 'package:hotel_ui_package/view/hotel_cart/card_strategy/hotel_card_factory.dart';

class HotelCard extends StatelessWidget {
  final HotelCardType cardType;
  final HotelData hotel;
  final Function(bool)? onFavoriteChanged;
  final VoidCallback? onActionPressed;
  final VoidCallback? onMoreInfoTab;
  const HotelCard(
      {super.key,
      required this.cardType,
      required this.hotel,
      this.onFavoriteChanged,
      this.onActionPressed,
      this.onMoreInfoTab});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: context.hotelCartTheme.cardDecoration,
      child: Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: HotelCardFactory.getStrategy(cardType).build(hotel,
              onFavoriteChanged: onFavoriteChanged,
              onActionPressed: onActionPressed,
              onMoreInfoTab: onMoreInfoTab)),
    );
  }
}
