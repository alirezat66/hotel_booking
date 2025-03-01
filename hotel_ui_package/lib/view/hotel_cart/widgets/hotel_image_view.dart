import 'package:flutter/material.dart';
import 'package:hotel_ui_package/hotel_ui_package.dart';

class HotelImageView extends StatelessWidget {
  final String url;
  final double aspectRatio;
  final RateWidget? rateWidget;
  final FavoriteWidget? favoriteWidget;
  const HotelImageView(
      {super.key,
      required this.url,
      this.rateWidget,
      this.aspectRatio = 343 / 186,
      this.favoriteWidget});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppImageView(
          url: url,
          aspectRatio: aspectRatio,
          boarderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5)),
        ),
        Positioned(
          bottom: 16,
          left: 8,
          child: rateWidget ?? const SizedBox(),
        ),
        Positioned(
          top: 12,
          right: 16,
          child: favoriteWidget ?? const SizedBox(),
        ),
      ],
    );
  }
}
