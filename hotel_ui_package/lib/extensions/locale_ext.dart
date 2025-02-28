import 'package:flutter/material.dart';

extension LocaleExtension on BuildContext {
  Locale get locale {
    return Localizations.maybeLocaleOf(this) ?? const Locale('en', 'US');
  }

  String get localeCode => '${locale.languageCode}_${locale.countryCode}';
}
