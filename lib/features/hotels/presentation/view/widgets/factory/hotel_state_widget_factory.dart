import 'package:flutter/widgets.dart';
import 'package:hotel_booking/features/hotels/presentation/cubit/hotel_cubit.dart';
import 'package:hotel_booking/features/hotels/presentation/view/widgets/hotel_failure_widget.dart';
import 'package:hotel_booking/features/hotels/presentation/view/widgets/hotel_loading_widget.dart';
import 'package:hotel_booking/features/hotels/presentation/view/widgets/hotel_success_widget.dart';

class HotelStateWidgetFactory {
  static Widget build(HotelState state) {
    switch (state.runtimeType) {
      case const (HotelLoading):
        return const HotelLoadingWidget();
      case const (HotelSuccess):
        final successState = state as HotelSuccess;
        return HotelSuccessWidget(
          hotels: successState.hotels,
          numberOfHotels: successState.numberOfHotels,
        );
      case const (HotelFailure):
        final failureState = state as HotelFailure;
        return HotelFailureWidget(
          errorMessage: failureState.errorMessage,
        );
      default:
        return const HotelLoadingWidget();
    }
  }
}
