import 'package:intl/intl.dart';

extension PriceExt on double {
  String formattedTotalPrice(
    String localeCode,
    String currency,
  ) {
    String currencySymbol =
        NumberFormat.simpleCurrency(name: currency).currencySymbol;
    return NumberFormat.currency(
            locale: localeCode, symbol: currencySymbol, decimalDigits: 2)
        .format(this);
  }

  String formattedPerPersonPrice(
    String localeCode,
    String currency,
  ) {
    final formatted = formattedTotalPrice(localeCode, currency);
    return '$formatted p.P.';
  }
}
