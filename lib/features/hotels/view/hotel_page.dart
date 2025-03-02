import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/hotels/cubit/hotel_cubit.dart';
import 'package:hotel_booking/features/hotels/view/widgets/factory/hotel_state_widget_factory.dart';

@RoutePage()
class HotelPage extends StatelessWidget {
  const HotelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelCubit, HotelState>(
      builder: (context, state) {
        return HotelStateWidgetFactory.build(state);
      },
    );
  }
}
