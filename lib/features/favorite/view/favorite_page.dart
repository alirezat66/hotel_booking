import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/di/service_locator.dart';
import 'package:hotel_booking/features/favorite/cubit/favorite_cubit.dart';
import 'package:hotel_booking/features/favorite/data/hotel_favorite.dart';
import 'package:hotel_booking/features/favorite/view/favorite_list_view.dart';
import 'package:hotel_booking/features/favorite/view/widgets/favorite_empty_view.dart';

@RoutePage()
class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<FavoriteCubit>(),
      child: BlocBuilder<FavoriteCubit, List<HotelFavorite>>(
        builder: (context, state) {
          return state.isEmpty
              ? const FavoriteEmptyView()
              : FavoriteListView(favorites: state);
        },
      ),
    );
  }
}
