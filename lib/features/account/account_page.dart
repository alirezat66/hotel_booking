import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/account/bloc/locale_bloc.dart';
import 'package:hotel_booking/features/account/bloc/theme_bloc.dart';

@RoutePage()
class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('language').tr(),
                BlocBuilder<LocaleBloc, Locale>(
                  builder: (context, locale) {
                    return Row(
                      children: [
                        Row(
                          children: [
                            Radio<String>(
                              value: 'en',
                              groupValue: locale.languageCode,
                              onChanged: (String? value) {
                                _setLanguage(context, value!);
                              },
                            ),
                            const Text('English'),
                          ],
                        ),
                        Row(
                          children: [
                            Radio<String>(
                              value: 'de',
                              groupValue: locale.languageCode,
                              onChanged: (String? value) {
                                _setLanguage(context, value!);
                              },
                            ),
                            const Text('German'),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('selectTheme').tr(),
                BlocBuilder<ThemeBloc, Brightness>(
                  builder: (context, Brightness brightness) {
                    return Row(
                      children: [
                        Row(
                          children: [
                            Radio<Brightness>(
                              value: brightness,
                              groupValue: Brightness.light,
                              onChanged: (Brightness? value) {
                                _setTheme(context, value!);
                              },
                            ),
                            const Text('lightTheme').tr(),
                          ],
                        ),
                        Row(
                          children: [
                            Radio<Brightness>(
                              value: brightness,
                              groupValue: Brightness.dark,
                              onChanged: (Brightness? value) {
                                _setTheme(context, value!);
                              },
                            ),
                            const Text('darkTheme').tr(),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _setLanguage(BuildContext context, String value) {
    context.read<LocaleBloc>().add(SetLocale(Locale(value)));

    context.setLocale(Locale(value));
  }

  void _setTheme(BuildContext context, Brightness brightness) {
    context.read<ThemeBloc>().add(SetTheme(brightness));
  }
}
