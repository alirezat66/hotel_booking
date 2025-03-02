import 'package:flutter/material.dart';

class HotelLoadingWidget extends StatelessWidget {
  const HotelLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: kToolbarHeight,
        height: kToolbarHeight,
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
