// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AccountPage]
class AccountRoute extends PageRouteInfo<void> {
  const AccountRoute({List<PageRouteInfo>? children})
      : super(
          AccountRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AccountPage();
    },
  );
}

/// generated route for
/// [FavoritePage]
class FavoriteRoute extends PageRouteInfo<FavoriteRouteArgs> {
  FavoriteRoute({
    Key? key,
    Widget? emptyImage,
    List<PageRouteInfo>? children,
  }) : super(
          FavoriteRoute.name,
          args: FavoriteRouteArgs(
            key: key,
            emptyImage: emptyImage,
          ),
          initialChildren: children,
        );

  static const String name = 'FavoriteRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FavoriteRouteArgs>(
          orElse: () => const FavoriteRouteArgs());
      return FavoritePage(
        key: args.key,
        emptyImage: args.emptyImage,
      );
    },
  );
}

class FavoriteRouteArgs {
  const FavoriteRouteArgs({
    this.key,
    this.emptyImage,
  });

  final Key? key;

  final Widget? emptyImage;

  @override
  String toString() {
    return 'FavoriteRouteArgs{key: $key, emptyImage: $emptyImage}';
  }
}

/// generated route for
/// [HotelPage]
class HotelRoute extends PageRouteInfo<void> {
  const HotelRoute({List<PageRouteInfo>? children})
      : super(
          HotelRoute.name,
          initialChildren: children,
        );

  static const String name = 'HotelRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HotelPage();
    },
  );
}

/// generated route for
/// [MainTabsScreen]
class MainTabsRoute extends PageRouteInfo<void> {
  const MainTabsRoute({List<PageRouteInfo>? children})
      : super(
          MainTabsRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainTabsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainTabsScreen();
    },
  );
}

/// generated route for
/// [OverviewPage]
class OverviewRoute extends PageRouteInfo<void> {
  const OverviewRoute({List<PageRouteInfo>? children})
      : super(
          OverviewRoute.name,
          initialChildren: children,
        );

  static const String name = 'OverviewRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OverviewPage();
    },
  );
}
