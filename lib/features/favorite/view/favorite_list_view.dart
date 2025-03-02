import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hotel_booking/core/extension/hotel_favorite_ext.dart';
import 'package:hotel_booking/features/favorite/cubit/favorite_cubit.dart';
import 'package:hotel_booking/features/favorite/data/hotel_favorite.dart';
import 'package:hotel_ui_package/view/hotel_card/hotel_card.dart';
import 'package:hotel_ui_package/view/hotel_card/hotel_card_type.dart';

class FavoriteListView extends StatefulWidget {
  final List<HotelFavorite> favorites;

  const FavoriteListView({super.key, required this.favorites});

  @override
  State<FavoriteListView> createState() => _FavoriteListViewState();
}

class _FavoriteListViewState extends State<FavoriteListView> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late List<HotelFavorite> _favorites;

  @override
  void initState() {
    super.initState();
    _favorites = List.from(widget.favorites); // Initial copy of favorites
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteCubit, List<HotelFavorite>>(
      listener: (context, state) {
        _handleStateChanges(state);
      },
      builder: (context, state) {
        return AnimatedList(
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
    );
  }

  // Build each list item with animation
  Widget _buildItem(HotelFavorite favorite, Animation<double> animation,
      BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      axisAlignment: 0.0, // Adjusted for smoother animation
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
        child: HotelCard(
          cardType: HotelCardType.compact,
          hotel: favorite.toHotelData(),
          onActionPressed: () {},
          onMoreInfoTab: () {},
          onFavoriteChanged: (isFavorite) {
            context.read<FavoriteCubit>().removeFavorite(favorite.hotelId);
          },
        ),
      ),
    );
  }

  // Handle state changes for insertions/removals
  void _handleStateChanges(List<HotelFavorite> newState) {
    final oldFavorites = _favorites;
    final newFavorites = newState;

    // Handle removals
    for (int i = 0; i < oldFavorites.length; i++) {
      if (!newFavorites.contains(oldFavorites[i])) {
        _listKey.currentState?.removeItem(
          i,
          (context, animation) =>
              _buildItem(oldFavorites[i], animation, context),
          duration: const Duration(milliseconds: 300),
        );
        break; // Single removal at a time
      }
    }

    // Handle insertions
    for (int i = 0; i < newFavorites.length; i++) {
      if (!oldFavorites.contains(newFavorites[i])) {
        _listKey.currentState?.insertItem(
          i,
          duration: const Duration(milliseconds: 300),
        );
        break; // Single insertion at a time
      }
    }

    // Update local state
    _favorites = List.from(newFavorites);
  }
}
