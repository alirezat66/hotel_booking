import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/bloc/bloc_observer.dart';
import 'package:hotel_booking/core/di/service_locator.dart';
import 'package:hotel_booking/core/route/app_router.dart';
import 'package:hotel_booking/features/account/bloc/locale_bloc.dart';
import 'package:hotel_booking/features/favorite/cubit/favorite_cubit.dart';
import 'package:hotel_booking/features/hotels/cubit/hotel_cubit.dart';
import 'package:hotel_ui_package/hotel_ui_package.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  Bloc.observer = HotelBlocObserver();
  await ServiceLocator.setup();
  runApp(EasyLocalization(
      supportedLocales: const [
        Locale('en',),
        Locale('de',),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<LocaleBloc>(),
      child: BlocBuilder<LocaleBloc, Locale>(
        builder: (context, locale) {
          context.setLocale(locale);
          return MaterialApp.router(
            title: 'Flutter Demo',
            theme: HotelBookingTheme.lightTheme,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: locale,
            routerConfig: AppRouter().config(),
          );
        },
      ),
    );
  }
}

@RoutePage()
class MainTabsScreen extends StatelessWidget {
  const MainTabsScreen({super.key});
  static const List<String> _tabTitles = [
    'OverView',
    'Hotels',
    'Favorites',
    'Account',
  ];
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: [
        const OverviewRoute(),
        const HotelRoute(), // Pass your hotel list here later
        FavoriteRoute(),
        const AccountRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              _tabTitles[tabsRouter.activeIndex],
            ),
          ),
          body: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => locator<FavoriteCubit>(),
              ),
              BlocProvider(
                create: (context) => locator<HotelCubit>()..getHotels(),
              ),
            ],
            child: child,
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType
                .fixed, // Add this if not already present

            currentIndex: tabsRouter.activeIndex,
            onTap: (index) => tabsRouter.setActiveIndex(index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Overview',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.hotel),
                label: 'Hotels',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Account',
              ),
            ],
          ),
        );
      },
    );
  }
}
