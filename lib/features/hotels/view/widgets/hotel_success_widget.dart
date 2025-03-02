import 'package:flutter/material.dart';
import 'package:hotel_booking/core/widgets/hotel_list_view.dart';
import 'package:hotel_booking/features/hotels/data/models/hotel.dart';
import 'package:hotel_booking/features/hotels/view/widgets/hotel_list_header.dart';
import 'package:hotel_ui_package/view/hotel_card/hotel_card_type.dart';

class HotelSuccessWidget extends StatelessWidget {
  final List<Hotel> hotels;
  final int numberOfHotels;
  const HotelSuccessWidget(
      {super.key, required this.hotels, required this.numberOfHotels});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 24,
              left: 16,
              right: 16,
              bottom: 12,
            ),
            child: HotelListHeader(
              totalCount: numberOfHotels,
              destination: hotels.isNotEmpty ? hotels.first.destination : '',
            ),
          ),
        ),
        HotelListView(
          hotels: hotels,
          cardType: HotelCardType.detailed,
          onActionPressed: () {},
          onFavoriteChange: (isFavorite){},
        ),
      ],
    );
  }
}
