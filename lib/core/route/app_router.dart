import 'package:auto_route/auto_route.dart';
import 'package:hotel_booking/features/account/account_page.dart';
import 'package:hotel_booking/features/favorite/view/favorite_page.dart';
import 'package:hotel_booking/features/hotels/view/hotel_page.dart';
import 'package:hotel_booking/features/overview/overview_page.dart';
import 'package:hotel_booking/main.dart';
part 'app_router.gr.dart'; // Generated file

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: MainTabsRoute.page,
          children: [
            AutoRoute(path: 'overview', page: OverviewRoute.page),
            AutoRoute(path: 'hotels', page: HotelRoute.page),
            AutoRoute(path: 'favorites', page: FavoriteRoute.page),
            AutoRoute(path: 'account', page: AccountRoute.page),
          ],
        ),
      ];
}
