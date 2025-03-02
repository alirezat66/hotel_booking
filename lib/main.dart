import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hotel_booking/core/bloc/bloc_observer.dart';
import 'package:hotel_booking/core/di/service_locator.dart';
import 'package:hotel_booking/core/route/app_router.dart';
import 'package:hotel_ui_package/hotel_ui_package.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = HotelBlocObserver();
  ServiceLocator.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: HotelBookingTheme.lightTheme,
      locale: const Locale('de', 'DE'),
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('de', 'DE'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: AppRouter().config(),
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
      routes: const [
        OverviewRoute(),
        HotelRoute(), // Pass your hotel list here later
        FavoriteRoute(),
        AccountRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              _tabTitles[tabsRouter.activeIndex],
            ),
          ),
          body: child,
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
