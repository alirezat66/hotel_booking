import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hotel_booking/core/bloc/bloc_observer.dart';
import 'package:hotel_booking/core/di/service_locator.dart';
import 'package:hotel_booking/features/favorite/cubit/favorite_cubit.dart';
import 'package:hotel_booking/features/hotels/view/hotel_page.dart';
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
    return MaterialApp(
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
      home: const HotelPage(),
    );
  }
}
