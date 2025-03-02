import 'package:flutter/material.dart';
import 'package:hotel_ui_package/hotel_ui_package.dart';

class HotelListHeader extends StatelessWidget {
  final int totalCount;
  final String destination;

  const HotelListHeader({
    super.key,
    required this.totalCount,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    final destinations = destination.split(',');
    final finalDestination = destinations.isEmpty
        ? ''
        : destinations.length > 2
            ? destinations[1]
            : destinations.first;
    return Text(
      '$totalCount Hotels für $finalDestination',
      style: context.headlineSmall.copyWith(
          fontWeight: FontWeight.w700, fontSize: 18, color: Colors.black),
    );
  }
}
