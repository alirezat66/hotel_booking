import 'package:flutter/widgets.dart';
import 'package:hotel_booking/core/extension/hotel_ext.dart';
import 'package:hotel_booking/features/hotels/data/models/hotel.dart';
import 'package:hotel_ui_package/hotel_ui_package.dart';

class HotelListView extends StatelessWidget {
  final List<Hotel> hotels;
  final HotelCardType cardType;
  final Function(bool)? onFavoriteChange;
  final VoidCallback? onActionPressed;
  final VoidCallback? onMoreInfoTab;
  const HotelListView(
      {super.key,
      required this.hotels,
      required this.cardType,
      this.onFavoriteChange,
      this.onActionPressed,
      this.onMoreInfoTab});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: hotels.length,
        (context, index) {
          final hotel = hotels[index];
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 24,
              right: 16,
              left: 16,
            ),
            child: HotelCard(
              cardType: cardType,
              hotel: hotel.toHotelData(),
              onFavoriteChanged: onFavoriteChange,
              onActionPressed: onActionPressed,
              onMoreInfoTab: onMoreInfoTab,
            ),
          );
        },
      ),
    );
  }
}
