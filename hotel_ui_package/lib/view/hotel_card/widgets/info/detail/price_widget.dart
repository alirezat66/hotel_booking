import 'package:flutter/material.dart';
import 'package:hotel_ui_package/extensions/double_ext.dart';
import 'package:hotel_ui_package/extensions/locale_ext.dart';
import 'package:hotel_ui_package/extensions/theme_ext.dart';

class PriceWidget extends StatelessWidget {
  final double totalPrice;
  final double perPersonPrice;
  final String? fromText;
  final String currency;
  const PriceWidget({
    super.key,
    required this.totalPrice,
    required this.perPersonPrice,
    this.fromText,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: fromText != null ? '$fromText ' : '',
                style: context.bodySmall.copyWith(
                  color: context.hotelCardTheme.titleTextColor,
                ),
              ),
              TextSpan(
                text: totalPrice.formattedTotalPrice(
                  context.localeCode,
                  currency,
                ),
                style: context.bodySmall.copyWith(
                  color: context.hotelCardTheme.titleTextColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Text(
          perPersonPrice.formattedPerPersonPrice(context.localeCode, currency),
          style: context.bodySmall.copyWith(
            color: context.hotelCardTheme.subtitleTextColor,
          ),
        )
      ],
    );
  }
}
