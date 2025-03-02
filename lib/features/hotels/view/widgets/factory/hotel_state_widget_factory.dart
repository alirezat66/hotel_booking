import 'package:flutter/widgets.dart';
import 'package:hotel_booking/features/hotels/cubit/hotel_cubit.dart';
import 'package:hotel_booking/features/hotels/view/widgets/hotel_failure_widget.dart';
import 'package:hotel_booking/features/hotels/view/widgets/hotel_loading_widget.dart';
import 'package:hotel_booking/features/hotels/view/widgets/hotel_success_widget.dart';

class HotelStateWidgetFactory {
  static Widget build(HotelState state) {
    if (state is HotelLoading) {
      return const HotelLoadingWidget();
    } else if (state is HotelSuccess) {
      return HotelSuccessWidget(
        hotels: state.hotels,
        numberOfHotels: state.numberOfHotels,
      );
    } else if (state is HotelFailure) {
      return HotelFailureWidget(
        errorMessage: state.errorMessage,
      );
    }
    return const Center(child: Text('Unknown State'));
  }
}
