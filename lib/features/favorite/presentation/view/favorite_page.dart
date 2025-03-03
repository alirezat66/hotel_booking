import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:hotel_booking/features/favorite/data/model/hotel_favorite.dart';
import 'package:hotel_booking/features/favorite/presentation/view/favorite_list_view.dart';
import 'package:hotel_booking/features/favorite/presentation/view/widgets/favorite_empty_view.dart';

@RoutePage()
class FavoritePage extends StatelessWidget {
  final Widget? emptyImage;
  const FavoritePage({super.key, this.emptyImage});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, List<HotelFavorite>>(
      builder: (context, state) {
        return state.isEmpty
            ? FavoriteEmptyView(
                emptyImage: emptyImage,
              )
            : FavoriteListView(favorites: state);
      },
    );
  }
}
