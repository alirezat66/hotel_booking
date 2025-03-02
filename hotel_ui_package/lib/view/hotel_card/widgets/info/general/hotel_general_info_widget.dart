import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hotel_ui_package/hotel_ui_package.dart';

class HotelGeneralInfoWidget extends StatelessWidget {
  final double score;
  final VoidCallback? onMoreInfoTab;
  final String hotelName;
  final String destination;
  const HotelGeneralInfoWidget({
    super.key,
    this.onMoreInfoTab,
    required this.hotelName,
    required this.destination,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RateStarWidget(score: score, onMoreInfoTab: onMoreInfoTab),
        const Gap(4),
        Text(
          hotelName,
          style: context.titleMedium.copyWith(
              fontWeight: FontWeight.w700,
              color: context.hotelCardTheme.titleTextColor),
        ),
        const Gap(2),
        Text(
          destination,
          style: context.bodySmall.copyWith(
            color: context.hotelCardTheme.subtitleTextColor,
          ),
        ),
      ],
    );
  }
}
