import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/bloc/bloc_observer.dart';
import 'package:hotel_booking/core/di/service_locator.dart';
import 'package:hotel_booking/core/navigation/app_router.dart';
import 'package:hotel_booking/features/account/bloc/locale_bloc.dart';
import 'package:hotel_booking/features/account/bloc/theme_bloc.dart';
import 'package:hotel_booking/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:hotel_booking/features/hotels/presentation/cubit/hotel_cubit.dart';
import 'package:hotel_ui_package/hotel_ui_package.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  Bloc.observer = HotelBlocObserver();
  await ServiceLocator.setup();
  runApp(EasyLocalization(
      supportedLocales: const [
        Locale(
          'en',
        ),
        Locale(
          'de',
        ),
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => locator<LocaleBloc>(),
        ),
        BlocProvider(
          create: (context) => locator<ThemeBloc>(),
        ),
      ],
      child: BlocBuilder<LocaleBloc, Locale>(
        builder: (context, locale) {
          context.setLocale(locale);
          return BlocBuilder<ThemeBloc, Brightness>(
            builder: (context, brightness) {
              return MaterialApp.router(
                title: 'Flutter Demo',
                theme: HotelBookingTheme.getTheme(brightness: Brightness.light),
                darkTheme:
                    HotelBookingTheme.getTheme(brightness: Brightness.dark),
                themeMode: brightness == Brightness.light
                    ? ThemeMode.light
                    : ThemeMode.dark,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: locale,
                routerConfig: AppRouter()
                    .config(navigatorObservers: () => [AutoRouteObserver()]),
              );
            },
          );
        },
      ),
    );
  }
}

@RoutePage()
class MainTabsScreen extends StatefulWidget {
  const MainTabsScreen({super.key});

  @override
  State<MainTabsScreen> createState() => _MainTabsScreenState();
}

class _MainTabsScreenState extends State<MainTabsScreen> {
  final List<String> _tabTitles = [
    'overview',
    'hotels',
    'favorites',
    'account',
  ];

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: [
        const OverviewRoute(),
        const HotelRoute(),
        FavoriteRoute(),
        const AccountRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              _tabTitles[tabsRouter.activeIndex],
            ).tr(),
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
            type: BottomNavigationBarType.fixed,
            currentIndex: tabsRouter.activeIndex,
            onTap: (index) => tabsRouter.setActiveIndex(index),
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: 'overview'.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.hotel),
                label: 'hotels'.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.favorite),
                label: 'favorites'.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.account_circle),
                label: 'account'.tr(),
              ),
            ],
          ),
        );
      },
    );
  }
}
