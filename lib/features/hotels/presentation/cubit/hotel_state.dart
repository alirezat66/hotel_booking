part of 'hotel_cubit.dart';

sealed class HotelState {}

final class HotelLoading extends HotelState {}

final class HotelSuccess extends HotelState {
  final List<HotelModel> hotels;
  final int numberOfHotels;
  HotelSuccess(this.hotels, this.numberOfHotels);
}

final class HotelFailure extends HotelState {
  final String errorMessage;
  HotelFailure(this.errorMessage);
}
