import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hotel_ui_package/view/hotel_card/widgets/info_row_widget.dart';

class TravelInfoWidget extends StatelessWidget {
  final List<String> dateInfo;
  final List<String> roomInfo;
  final List<String> overallInfo;
  const TravelInfoWidget(
      {super.key,
      required this.dateInfo,
      required this.roomInfo,
      required this.overallInfo});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InfoRowWidget(items: dateInfo),
        const Gap(4),
        InfoRowWidget(items: roomInfo),
        const Gap(4),
        InfoRowWidget(items: overallInfo),
      ],
    );
  }
}
