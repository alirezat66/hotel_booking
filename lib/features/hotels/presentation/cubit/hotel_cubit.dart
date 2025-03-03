import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/hotels/data/models/hotel_model.dart';
import 'package:hotel_booking/features/hotels/domain/usecases/get_hotels_use_case.dart';

part 'hotel_state.dart';

class HotelCubit extends Cubit<HotelState> {
  final GetHotelsUseCase _getHotels;
  HotelCubit(GetHotelsUseCase getHotels)
      : _getHotels = getHotels,
        super(HotelLoading());

  void getHotels() async {
    emit(HotelLoading());
    try {
      final hotels = await _getHotels.call();
      emit(HotelSuccess(hotels.hotels, hotels.hotels.length));
    } catch (e) {
      emit(HotelFailure(e.toString()));
    }
  }
}
