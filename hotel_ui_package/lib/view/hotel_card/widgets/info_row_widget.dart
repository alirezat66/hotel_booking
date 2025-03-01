import 'package:flutter/material.dart';
import 'package:hotel_ui_package/hotel_ui_package.dart';

class InfoRowWidget extends StatelessWidget {
  final List<String> items;
  const InfoRowWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Text(
      items.join(" | "), // Joins all items with " | "
      style: context.bodySmall.copyWith(
        color: context.hotelCartTheme.subtitleTextColor,
      ),
    );
  }
}
