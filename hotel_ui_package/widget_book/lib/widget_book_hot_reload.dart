import 'package:flutter/material.dart';
import 'package:hotel_ui_package/theme/theme.dart';
import 'package:widget_book_hotel_ui/components/detail_info_cases.dart';
import 'package:widget_book_hotel_ui/components/rate_cases.dart';
import 'package:widgetbook/widgetbook.dart';

class WidgetbookHotReload extends StatelessWidget {
  const WidgetbookHotReload({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      lightTheme: HotelBookingTheme.lightTheme,
      addons: [
        DeviceFrameAddon(
          devices: [
            Devices.ios.iPhone13,
            Devices.android.samsungGalaxyS20,
          ],
          initialDevice: Devices.ios.iPhone13,
        ),
        InspectorAddon(enabled: false),
      ],
      directories: [
        WidgetbookFolder(
          name: 'RateStar Widget',
          children: [
            getRateStarWidget(),
          ],
        ),
        WidgetbookFolder(
          name: 'Info Widget',
          children: [
            getInfo(),
          ],
        ),
      ],
      appBuilder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: HotelBookingTheme.lightTheme,
          locale: const Locale('de', 'DE'),
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('de', 'DE'),
          ],
          home: child,
        );
      },
    );
  }
}
