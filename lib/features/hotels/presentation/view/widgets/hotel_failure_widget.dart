import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hotel_booking/features/hotels/presentation/cubit/hotel_cubit.dart';
import 'package:hotel_ui_package/hotel_ui_package.dart';

class HotelFailureWidget extends StatelessWidget {
  final String errorMessage;

  const HotelFailureWidget({
    super.key,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'fetchError'.tr(),
            style: context.textTheme.headlineSmall,
          ),
          const Gap(8),
          Text(errorMessage),
          const Gap(16),
          ElevatedButton(
            onPressed: () => context.read<HotelCubit>().getHotels(),
            child: const Text('retry').tr(),
          ),
        ],
      ),
    );
  }
}
