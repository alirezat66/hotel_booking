import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hotel_ui_package/hotel_ui_package.dart';

class HotelInfoHeader extends StatelessWidget {
  final double score;
  final VoidCallback? onMoreInfoTab;
  final String hotelName;
  final String hotelAddress;
  const HotelInfoHeader({
    super.key,
    this.onMoreInfoTab,
    required this.hotelName,
    required this.hotelAddress,
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
              fontWeight: FontWeight.w700, color: const Color(0xFF222222)),
        ),
        const Gap(2),
        Text(
          hotelAddress,
          style: context.bodySmall.copyWith(
            color: const Color(0xFF595959),
          ),
        ),
      ],
    );
  }
}
