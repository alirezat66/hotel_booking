import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hotel_booking/core/di/service_locator.dart';
import 'package:hotel_booking/core/extension/hotel_favorite_ext.dart';
import 'package:hotel_booking/features/favorite/cubit/favorite_cubit.dart';
import 'package:hotel_booking/features/favorite/data/hotel_favorite.dart';
import 'package:hotel_booking/features/favorite/view/favorite_empty_page.dart';
import 'package:hotel_ui_package/view/hotel_card/hotel_card.dart';
import 'package:hotel_ui_package/view/hotel_card/hotel_card_type.dart';

@RoutePage()
class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritePage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late List<HotelFavorite> _favorites;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<FavoriteCubit>(),
      child: BlocConsumer<FavoriteCubit, List<HotelFavorite>>(
        listener: (context, state) {
          _handleStateChanges(state);
        },
        builder: (context, state) {
          _favorites = state; // Store current state for animation
          return state.isEmpty
              ? const FavoriteEmptyPage()
              : AnimatedList(
                  key: _listKey,
                  initialItemCount: state.length,
                  itemBuilder: (context, index, animation) {
                    final favorite = state[index];
                    return Column(
                      children: [
                        if (index == 0) const Gap(24),
                        _buildItem(favorite, animation, context),
                      ],
                    );
                  },
                );
        },
      ),
    );
  }

  // Build each list item with animation
  Widget _buildItem(HotelFavorite favorite, Animation<double> animation,
      BuildContext context) {
    return SizeTransition(
        sizeFactor: animation,
        axisAlignment: 24.0,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
          child: HotelCard(
              cardType: HotelCardType.compact,
              hotel: favorite.toHotelData(),
              onActionPressed: () {},
              onMoreInfoTab: () {},
              onFavoriteChanged: (isFavorite) {
                context.read<FavoriteCubit>().removeFavorite(favorite.hotelId);
              }),
        ));
  }

  // Handle state changes for insertions/removals
  void _handleStateChanges(List<HotelFavorite> newState) {
    final oldFavorites = _favorites;
    final newFavorites = newState;

    // Find removed items
    for (int i = 0; i < oldFavorites.length; i++) {
      if (!newFavorites.contains(oldFavorites[i])) {
        _listKey.currentState?.removeItem(
          i,
          (context, animation) =>
              _buildItem(oldFavorites[i], animation, context),
          duration: const Duration(milliseconds: 300),
        );
        return; // Assuming single removal at a time
      }
    }

    // Find added items (optional, if you want insertion animation)
    for (int i = 0; i < newFavorites.length; i++) {
      if (!oldFavorites.contains(newFavorites[i])) {
        _listKey.currentState
            ?.insertItem(i, duration: const Duration(milliseconds: 300));
        return;
      }
    }
  }
}
