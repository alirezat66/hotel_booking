import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/extension/hotel_ext.dart';
import 'package:hotel_booking/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:hotel_booking/features/favorite/data/model/hotel_favorite.dart';
import 'package:hotel_booking/features/hotels/data/models/hotel_model.dart';
import 'package:hotel_ui_package/hotel_ui_package.dart';

class HotelListView extends StatelessWidget {
  final List<HotelModel> hotels;
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
            child: BlocBuilder<FavoriteCubit, List<HotelFavorite>>(
              buildWhen: (previous, current) {
                return current
                        .any((element) => element.hotelId == hotel.hotelId) ||
                    previous.any((element) => element.hotelId == hotel.hotelId);
              },
              builder: (context, state) {
                return HotelCard(
                  cardType: cardType,
                  hotel: hotel.toHotelData(
                      state.any((element) => element.hotelId == hotel.hotelId)),
                  onFavoriteChanged: (isFavorite) {
                    if (isFavorite) {
                      context.read<FavoriteCubit>().addFavorite(hotel);
                    } else {
                      context
                          .read<FavoriteCubit>()
                          .removeFavorite(hotel.hotelId);
                    }
                  },
                  onActionPressed: onActionPressed,
                  onMoreInfoTab: onMoreInfoTab,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
