import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/di/service_locator.dart';
import 'package:hotel_booking/core/extension/hotel_favorite_ext.dart';
import 'package:hotel_booking/features/favorite/cubit/favorite_cubit.dart';
import 'package:hotel_booking/features/favorite/data/hotel_favorite.dart';
import 'package:hotel_ui_package/view/hotel_card/hotel_card.dart';
import 'package:hotel_ui_package/view/hotel_card/hotel_card_type.dart';

@RoutePage()
class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<FavoriteCubit>(),
      child: BlocBuilder<FavoriteCubit, List<HotelFavorite>>(
        builder: (context, state) {
          return ListView.builder(
              itemCount: state.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: HotelCard(
                    cardType: HotelCardType.compact,
                    hotel: state[index].toHotelData(),
                    onActionPressed: () {},
                    onMoreInfoTab: () {},
                    onFavoriteChanged: (isFavorite) {
                      context
                          .read<FavoriteCubit>()
                          .removeFavorite(state[index].hotelId);
                    },
                  ),
                );
              });
        },
      ),
    );
  }
}
