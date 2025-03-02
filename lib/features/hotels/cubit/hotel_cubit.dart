import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/hotels/data/models/hotel.dart';
import 'package:hotel_booking/features/hotels/data/repository/hotel_repository.dart';

part 'hotel_state.dart';

class HotelCubit extends Cubit<HotelState> {
  final HotelRepository _repository;
  HotelCubit(HotelRepository hotelRepository)
      : _repository = hotelRepository,
        super(HotelLoading());

  void getHotels() async {
    emit(HotelLoading());
    try {
      final hotels = await _repository.getHotels();
      emit(HotelSuccess(hotels.hotels, hotels.hotels.length));
    } catch (e) {
      emit(HotelFailure(e.toString()));
    }
  }
}
